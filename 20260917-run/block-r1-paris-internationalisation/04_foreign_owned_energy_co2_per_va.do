/*==========================================================================
  R1-04  Year by year: does the typical foreign-owned firm use less energy
         and emit less CO2 per unit of value added than the typical other
         firm, and does that gap change after the Paris Agreement
         (December 2015)?
  Answers Deasy R1: "fdi vs non fdi"; "Did internationally engaged firms
         change their environmental behaviour more strongly after the
         Paris Agreement?"; outcomes "Gj/va", "Co2/va" (drawn) and
         "VA/energy use ... total", "VA/emisi ... total" (their reciprocals,
         in the table); notes "matching yearly ... dicompare bagaimana
         behaviour mereka".
  Foreign-owned = 10% or more of the firm's capital held abroad
         (fdi_10_flag), the definition used in every R1-R3 exhibit.
  Output : figures/04_foreign_owned_energy_co2_per_va.png (+ .pdf)
           tables/04_foreign_owned_energy_co2_per_va.csv
  Built from the R1-02 template: only the GROUPING block differs.
  Development data - obscured values, fictional firm panel. Not BPS findings.
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

* ---- THE GROUPING: the only block R1-03 (importers) and R1-04 (foreign-owned) change ----
local exhibit  "R1-04"
local fname    "04_foreign_owned_energy_co2_per_va"
local gvar     "fdi_10_flag"          // 1 = 10%+ of capital held abroad, 0 = under 10%, . = unknown (left out)
local g1       "Foreign-owned"
local g0       "Other firms"
local g1s      "foreign-owned"
local g0s      "other firms"
local gtitle   "by foreign ownership"
local gstat    "ownership"
local skip_yrs "2020"                 // years NOT drawn (numbers stay in the table)
local skip_why "foreign share spikes that year (likely a recording change)"
local flag_yrs "2017 2019 2021 2022"  // years drawn hollow gray: records in doubt (numbers stay in the table)
local flag_why "energy records of many firms in both groups jump or drop far from other years"
local flag_key "Foreign-owned: energy records in doubt (see notes)"
local flag_g0  "yes"                  // "yes" = the other group's marks are also drawn light gray in flag_yrs
local flag_key0 "Other firms: energy records in doubt"   // legend text for the other group's light gray marks
local cav_note "Foreign-owned = 10%+ of capital held abroad; `skip_yrs' not drawn (far more firms marked foreign-owned). Light gray = many firms' energy records jump or drop, not a real change."
local min_n   30                   // a year is drawn only if both groups have at least this many firms
local reps    999                  // random redraws of each year's firms for the 95% range
* -------------------------------------------------------------------------------------------

* Guard: longer group names overflow the panel titles in the PDF; shorten g1s/g0s if this stops
assert ustrlen("(c) Energy: `g1s' as % of `g0s'") <= 45
assert ustrlen("Figure `exhibit'. Energy and CO2 per unit of value added, `gtitle'") <= 80

cap log close
log using "logs/`fname'.log", replace text
timer clear 1
timer on 1
display _newline "=== [`exhibit'] STARTING: energy and CO2 per unit of value added, `g1s' vs `g0s', by year ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

display "Step 1/6: load the group flag, energy, CO2, value added and workers"
* total_gj_s1 = energy in GJ (nine fuels + purchased electricity); co2_total_s1 = CO2 in tonnes
* value_added_nominal = value added, current prices (masked money unit)
use firm_id year `gvar' total_gj_s1 co2_total_s1 value_added_nominal workers using "$DATA", clear
isid firm_id year
assert year != 2016
assert inlist(`gvar', 0, 1, .)

display "Step 2/6: common sample and groups"
* One sample for both ratios: energy, CO2 and value added all above zero. A zero is
* dropped, not read as "no energy" (the energy fields cover only some fuels).
* Firms whose group status is unknown are left out, but counted each year.
gen byte cs  = total_gj_s1 > 0 & co2_total_s1 > 0 & value_added_nominal > 0 ///
             & !missing(total_gj_s1, co2_total_s1, value_added_nominal)
gen byte grp = `gvar'
gen byte one = 1
gen byte unk = cs & missing(grp)
gen byte in1 = cs & grp == 1
gen byte in0 = cs & grp == 0
gen byte drop0 = !cs
preserve
collapse (sum) firms_in_year = one n_dropped_zero = drop0 n_unknown = unk n_grp1 = in1 n_grp0 = in0, by(year)
tempfile counts
save `counts'
restore

* Units a reader can picture: GJ (or tonnes of CO2) per million money units of value added.
gen double gj_mva     = 1e6 * total_gj_s1  / value_added_nominal
gen double co2_mva    = 1e6 * co2_total_s1 / value_added_nominal
gen double va_per_gj  = value_added_nominal / total_gj_s1
gen double va_per_tco2 = value_added_nominal / co2_total_s1
gen double lgj  = ln(gj_mva)
gen double lco2 = ln(co2_mva)
keep if cs & !missing(grp)

display "Step 3/6: medians per group and year"
* Median = half the group's firms lie above. The ratios have extreme tails, so a mean
* would be driven by a few firms. VA per GJ and VA per tonne are the reciprocals.
preserve
collapse (median) med_gj = gj_mva med_co2 = co2_mva med_va_per_gj = va_per_gj med_va_per_tco2 = va_per_tco2 ///
         med_workers = workers ///
         (p25) p25_gj = gj_mva p25_co2 = co2_mva (p75) p75_gj = gj_mva p75_co2 = co2_mva ///
         (mean) ml_gj = lgj ml_co2 = lco2, by(year grp)
gen double gm_gj  = exp(ml_gj)
gen double gm_co2 = exp(ml_co2)
drop ml_*
reshape wide med_gj med_co2 med_va_per_gj med_va_per_tco2 med_workers p25_gj p25_co2 p75_gj p75_co2 gm_gj gm_co2, i(year) j(grp)
tempfile meds
save `meds'
restore

display "Step 4/6: gap between the groups and its 95% range"
* Gap = group median as % of the other group's median (100 = same). The 95% range comes
* from redrawing each year's firms at random (bootstrap, percentile method).
capture program drop r102gap
program define r102gap, rclass
    quietly _pctile gj_mva  if grp == 1, p(50)
    local a = r(r1)
    quietly _pctile gj_mva  if grp == 0, p(50)
    return scalar gap_gj = 100 * `a' / r(r1)
    quietly _pctile co2_mva if grp == 1, p(50)
    local a = r(r1)
    quietly _pctile co2_mva if grp == 0, p(50)
    return scalar gap_co2 = 100 * `a' / r(r1)
end
tempname h
tempfile gaps
postfile `h' int year double(gap_gj gap_gj_lo95 gap_gj_hi95 gap_co2 gap_co2_lo95 gap_co2_hi95) using `gaps', replace
levelsof year, local(yrs)
foreach y of local yrs {
    quietly count if year == `y' & grp == 1
    local n1 = r(N)
    quietly count if year == `y' & grp == 0
    local n0 = r(N)
    if `n1' < `min_n' | `n0' < `min_n' continue
    preserve
    quietly keep if year == `y'
    quietly bootstrap gap_gj = r(gap_gj) gap_co2 = r(gap_co2), reps(`reps') seed(20260925) strata(grp) double nodots: r102gap
    matrix b  = e(b)
    quietly estat bootstrap, percentile
    matrix ci = e(ci_percentile)
    post `h' (`y') (b[1,1]) (ci[1,1]) (ci[2,1]) (b[1,2]) (ci[1,2]) (ci[2,2])
    restore
}
postclose `h'

display "Step 5/6: table -> CSV (numbers written before drawing)"
use `counts', clear
merge 1:1 year using `meds', nogenerate
merge 1:1 year using `gaps', nogenerate
gen byte drawn = n_grp1 >= `min_n' & n_grp0 >= `min_n'
gen byte skipped = 0
foreach y of local skip_yrs {
    replace skipped = 1 if year == `y' & drawn
}
assert reldif(gap_gj,  100 * med_gj1  / med_gj0)  < 1e-9 if drawn
assert reldif(gap_co2, 100 * med_co21 / med_co20) < 1e-9 if drawn
gen double pct_unknown = 100 * n_unknown / (n_unknown + n_grp1 + n_grp0)
set obs `=_N + 1'
replace year = 2016 in L
replace drawn = 0 in L
gen byte annual_file = year != 2016
sort year
list year n_grp1 n_grp0 n_unknown med_gj1 med_gj0 gap_gj gap_gj_lo95 gap_gj_hi95 med_co21 med_co20 gap_co2 gap_co2_lo95 gap_co2_hi95, noobs sep(0) abbreviate(12)
assert gap_gj_lo95 <= gap_gj & gap_gj <= gap_gj_hi95 if drawn
assert gap_co2_lo95 <= gap_co2 & gap_co2 <= gap_co2_hi95 if drawn
assert firms_in_year == n_dropped_zero + n_unknown + n_grp1 + n_grp0 if annual_file
replace drawn = 0 if skipped == 1
* years drawn hollow gray because the group's records look wrong (numbers stay in the table)
gen byte flagged = 0
foreach y of local flag_yrs {
    replace flagged = 1 if year == `y' & drawn == 1
}
preserve
rename (med_gj1 med_gj0 med_co21 med_co20 gap_gj gap_co2) (med_gj_grp1 med_gj_grp0 med_co2_grp1 med_co2_grp0 gap_gj_pct gap_co2_pct)
rename (med_va_per_gj1 med_va_per_gj0 med_va_per_tco21 med_va_per_tco20) (med_va_per_gj_grp1 med_va_per_gj_grp0 med_va_per_tco2_grp1 med_va_per_tco2_grp0)
rename (p25_gj1 p75_gj1 p25_gj0 p75_gj0 p25_co21 p75_co21 p25_co20 p75_co20) (p25_gj_grp1 p75_gj_grp1 p25_gj_grp0 p75_gj_grp0 p25_co2_grp1 p75_co2_grp1 p25_co2_grp0 p75_co2_grp0)
rename (gm_gj1 gm_gj0 gm_co21 gm_co20 med_workers1 med_workers0) (gmean_gj_grp1 gmean_gj_grp0 gmean_co2_grp1 gmean_co2_grp0 med_workers_grp1 med_workers_grp0)
gen str20 group_variable = "`gvar'"
gen str30 grp1_label = "`g1'"
gen str30 grp0_label = "`g0'"
gen str80 note = ""
replace note = "No annual file" if year == 2016
replace note = "No comparison: fewer than `min_n' known firms in a group; group medians only, not drawn" if annual_file & !drawn & skipped != 1
replace note = "Computed but not drawn: `skip_why'" if skipped == 1
replace note = "Drawn hollow gray (records in doubt): `flag_why'" if flagged == 1
order group_variable grp1_label grp0_label year annual_file drawn firms_in_year n_dropped_zero n_unknown pct_unknown ///
      n_grp1 n_grp0 med_gj_grp1 med_gj_grp0 gap_gj_pct gap_gj_lo95 gap_gj_hi95 med_co2_grp1 med_co2_grp0 gap_co2_pct ///
      gap_co2_lo95 gap_co2_hi95 med_va_per_gj_grp1 med_va_per_gj_grp0 med_va_per_tco2_grp1 med_va_per_tco2_grp0 ///
      p25_gj_grp1 p75_gj_grp1 p25_gj_grp0 p75_gj_grp0 p25_co2_grp1 p75_co2_grp1 p25_co2_grp0 p75_co2_grp0 ///
      gmean_gj_grp1 gmean_gj_grp0 gmean_co2_grp1 gmean_co2_grp0 med_workers_grp1 med_workers_grp0 note
format firms_in_year n_dropped_zero n_unknown n_grp1 n_grp0 %9.0f
format med_* p25_* p75_* gmean_* %12.3f
format gap_* pct_unknown %7.2f
export delimited group_variable-note using "tables/`fname'.csv", datafmt replace
restore

display "   (numbers for the notes are read from the table, never typed)"
quietly summarize pct_unknown if drawn
local u_lo : display %3.0f r(min)
local u_hi : display %3.0f r(max)
local u_lo = strtrim("`u_lo'")
local u_hi = strtrim("`u_hi'")
* years with an annual file but no comparison (first such year is annotated in panel a, two short lines)
local blank1 ""
local blank2 ""
forvalues i = 1/`=_N' {
    if annual_file[`i'] & !drawn[`i'] & skipped[`i'] != 1 & "`blank1'" == "" {
        local y = year[`i']
        local blank1 "`y': no known"
        if n_grp0[`i'] == 0      local blank2 "`g0s'"
        else if n_grp1[`i'] == 0 local blank2 "`g1s'"
        else {
            local blank1 "`y': under `min_n' firms"
            local blank2 "in a group"
        }
    }
}
display "blank years: `blank1' `blank2'"

gen double lg_gj = ln(gap_gj/100)
gen double lg_co2 = ln(gap_co2/100)
foreach v in gj co2 {
    quietly summarize lg_`v' if drawn & year <= 2015
    local pre = 100*exp(r(mean))
    quietly summarize lg_`v' if drawn & year >= 2017
    local post = 100*exp(r(mean))
    display "   `v': average gap before Paris " %5.1f `pre' "  after " %5.1f `post'
}
* Notes: one text, wrapped here into lines of at most 100 characters (PDF text runs wider than the PNG)
local unk ""
if "`u_hi'" != "0" local unk "; unknown `gstat' (`u_lo'–`u_hi'% of firms a year) is left out"
local ntext "Notes: (a)–(b): each group's middle (median) firm; energy = gigajoules (GJ) of fuel and bought electricity. Value added = output value minus materials, energy and services bought, at current prices, so price rises alone lower (a)–(b). (c)–(d) = `g1s' line as % of `g0s' line; below 100 = less energy or CO2 per unit of value added; vertical line = 95% range; crossing 100 = no clear difference. `cav_note' Firms differ each year (none is followed) and groups differ in size and industry`unk', so it cannot show what caused a gap or a change after Paris."
local notelines ""
local line ""
foreach w of local ntext {
    if ustrlen("`line' `w'") > 100 & "`line'" != "" {
        local notelines `"`notelines' "`line'""'
        local line "`w'"
    }
    else local line = strtrim("`line' `w'")
}
local notelines `"`notelines' "`line'""'
display `"   note lines: `notelines'"'
local nlines : word count `notelines'
if `nlines' > 8 display as error "   WARNING: the notes run to `nlines' lines (limit 8) - shorten cav_note in the grouping block"

display "Step 6/6: draw: top row = the two groups, bottom row = the gap"
keep year drawn skipped flagged med_gj1 med_gj0 med_co21 med_co20 gap_gj gap_gj_lo95 gap_gj_hi95 gap_co2 gap_co2_lo95 gap_co2_hi95
expand 4
bysort year: gen byte panel = _n
label define panel 1 "(a) Energy (GJ) per million of value added" ///
                   2 "(b) CO2 (tonnes) per million of value added" ///
                   3 "(c) Energy: `g1s' as % of `g0s'" ///
                   4 "(d) CO2: `g1s' as % of `g0s'"
label values panel panel
gen double y1  = cond(panel == 1, med_gj1, med_co21) if inlist(panel, 1, 2) & drawn
gen double y0  = cond(panel == 1, med_gj0, med_co20) if inlist(panel, 1, 2) & drawn
gen double gp  = cond(panel == 3, gap_gj, gap_co2)             if inlist(panel, 3, 4) & drawn
gen double glo = cond(panel == 3, gap_gj_lo95, gap_co2_lo95)   if inlist(panel, 3, 4) & drawn
gen double ghi = cond(panel == 3, gap_gj_hi95, gap_co2_hi95)   if inlist(panel, 3, 4) & drawn
gen double ref = 100 if inlist(panel, 3, 4)

* panel top: a round number above the highest mark; the two gap panels share one scale
gen double pmax = max(y1, y0, ghi)
bysort panel: egen double top = max(pmax)
quietly summarize top if inlist(panel, 3, 4)
replace top = r(max) if inlist(panel, 3, 4)
gen double mag  = 10^floor(log10(top))
gen double step = cond(top / mag < 5, mag / 2, mag)
replace top = ceil(top / step) * step

* endpoint labels: first and last drawn year, higher line labelled above
bysort panel: egen fy = min(cond(drawn, year, .))
bysort panel: egen ly = max(cond(drawn, year, .))
gen byte endpt = drawn & inlist(year, fy, ly)
gen str8 l1 = string(y1, cond(panel == 1, "%9.0f", "%9.1f")) if endpt & inlist(panel, 1, 2)
gen str8 l0 = string(y0, cond(panel == 1, "%9.0f", "%9.1f")) if endpt & inlist(panel, 1, 2)
gen byte p1 = cond(year == fy, cond(y1 >= y0, 10, 8), cond(y1 >= y0, 2, 4)) if endpt
gen byte p0 = cond(year == fy, cond(y0 >  y1, 10, 8), cond(y0 >  y1, 2, 4)) if endpt
gen str8 lg = string(gp, "%9.0f") if endpt & inlist(panel, 3, 4)
gen byte pg = cond(year == fy, 9, 3) if endpt
* flagged years (flag_yrs): move the group-1 and gap marks to hollow gray layers,
* not joined to the solid line, so they are not read as a real change
gen double y1f  = y1  if flagged == 1
gen double gpf  = gp  if flagged == 1
gen double glof = glo if flagged == 1
gen double ghif = ghi if flagged == 1
gen str8 l1f = l1 if flagged == 1
gen str8 lgf = lg if flagged == 1
foreach v in y1 gp glo ghi {
    replace `v' = . if flagged == 1
}
replace l1 = "" if flagged == 1
replace lg = "" if flagged == 1
* flag_g0 = yes: the other group's records are in doubt in those years too, so its
* marks move to a light gray layer as well
gen double y0f = y0 if flagged == 1 & "`flag_g0'" == "yes"
gen str8 l0f = l0 if flagged == 1 & "`flag_g0'" == "yes"
replace y0 = . if flagged == 1 & "`flag_g0'" == "yes"
replace l0 = "" if flagged == 1 & "`flag_g0'" == "yes"
local flaglayers ""
local flagkey ""
local lrows 3
local ysz 8.5
quietly count if flagged == 1
if r(N) > 0 {
    local flaglayers `"(connected y1f year, cmissing(n) lcolor(gs8) lpattern(solid) lwidth(thin) msymbol(Oh) msize(small) mcolor(gs8) mlabel(l1f) mlabvposition(p1) mlabsize(vsmall) mlabcolor(gs6))"'
    local flaglayers `"`flaglayers' (rspike ghif glof year, lcolor(gs8) lwidth(thin)) (scatter gpf year, msymbol(Dh) msize(small) mcolor(gs8) mlabel(lgf) mlabvposition(pg) mlabsize(vsmall) mlabcolor(gs6))"'
    if "`flag_g0'" == "yes" local flaglayers `"`flaglayers' (connected y0f year, cmissing(n) lcolor(gs10) lpattern(shortdash) lwidth(thin) msymbol(Sh) msize(small) mcolor(gs10) mlabel(l0f) mlabvposition(p0) mlabsize(vsmall) mlabcolor(gs8))"'
    local flagkey `"9 "`flag_key'""'
    if "`flag_g0'" == "yes" local flagkey `"`flagkey' 12 "`flag_key0'""'
    local lrows 4
    local ysz 9            // one more legend row and note line; 9 keeps the PNG edges opaque
}

* 2016 band and Paris line (end of 2015)
gen double band = top if year == 2016
gen double px = 2015.5 if year == 2016
gen double plo = 0 if year == 2016
gen double phi = top if year == 2016

* note on years with no comparison (panel a only)
gen str40 atx = "`blank1'" if panel == 1 & year == 2016
replace atx = "`blank2'" if panel == 1 & year == 2015
* years computed but not drawn: gray "YYYY not drawn" under the x axis of every panel,
* on its own row below the year labels, so it never sits on the 2016 band or on a marker
local skipopt ""
foreach y of local skip_yrs {
    local skipopt `"`skipopt' `y' "`y' not drawn""'
}
if `"`skipopt'"' != "" local skipopt `"xmlabel(`skipopt', noticks tlength(0) labsize(vsmall) labcolor(gs6) labgap(3.5))"'
gen double ax = 2023.3 if atx != ""
gen double ay = cond(year == 2016, 0.97, 0.88) * top if atx != ""

sort panel year
twoway (bar band year, barwidth(0.8) color(gs14) lwidth(none) base(0)) ///
    (rspike phi plo px, lcolor(gs4) lpattern(shortdash) lwidth(thin)) ///
    (line ref year, lcolor(gs8) lwidth(thin) lpattern(solid)) ///
    (connected y1 year, cmissing(n) lcolor(black) lpattern(solid) lwidth(medthin) msymbol(O) msize(small) mcolor(black) ///
        mlabel(l1) mlabvposition(p1) mlabsize(vsmall) mlabcolor(black)) ///
    (connected y0 year, cmissing(n) lcolor(gs6) lpattern(shortdash) lwidth(medthin) msymbol(Sh) msize(small) mcolor(gs6) ///
        mlabel(l0) mlabvposition(p0) mlabsize(vsmall) mlabcolor(gs6)) ///
    (rspike ghi glo year, lcolor(black) lwidth(thin)) ///
    (scatter gp year, msymbol(D) msize(small) mcolor(black) mlabel(lg) mlabvposition(pg) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter ay ax, msymbol(none) mlabel(atx) mlabposition(9) mlabgap(0) mlabsize(vsmall) mlabcolor(gs6)) `flaglayers', ///
    by(panel, cols(2) yrescale ixaxes graphregion(color(white) lcolor(white) ilcolor(white)) legend(pos(6)) ///
        title("Figure `exhibit'. Energy and CO2 per unit of value added, `gtitle'", size(small) pos(11) span) ///
        note(`notelines' "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6))) ///
    subtitle(, pos(11) nobox fcolor(white) lcolor(white) size(small)) ///
    ylabel(#4, angle(0) noticks tlength(0) grid glcolor(gs15) glwidth(vthin) labsize(vsmall) format(%9.0f)) ///
    yscale(noline range(0)) ytitle("") ///
    xlabel(2010(2)2022, noticks tlength(0) labsize(vsmall)) `skipopt' xscale(range(2008.6 2023.4) lcolor(gs10)) xtitle("") ///
    legend(order(4 "`g1'" 5 "`g0'" 7 "`g1' as % of `g0s' (line = 95% range)" 3 "100 = same as `g0s'" ///
                 2 "Paris Agreement adopted (December 2015)" 1 "No annual file" `flagkey') ///
        rows(`lrows') region(lcolor(none)) size(vsmall) symxsize(6) keygap(1) colgap(4) rowgap(0.3)) ///
    plotregion(style(none)) xsize(7.5) ysize(`ysz')

graph export "figures/`fname'.png", width(2250) replace
graph export "figures/`fname'.pdf", replace
timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/`fname'.png (elapsed `elapsed' s)"
quietly log close
