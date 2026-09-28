/*==========================================================================
  R1-05  Before vs after the Paris Agreement (adopted December 2015): how
         did the typical firm's energy use, CO2, electricity and own
         electricity change - for all firms, and did exporters, importers
         and foreign-owned firms change more than other firms?
  Answers Deasy R1: "Do global climate commitments reach the factory
         floor?"; "Did internationally engaged firms change their
         environmental behaviour more strongly after the Paris Agreement?";
         every listed outcome: "VA/energy use, scope 1, scope 2, total;
         VA/emisi, scope 1, scope 2, total; Energi use, scope 1, 2, total;
         Emisi, scope 1, 2, total; GJ/emisi, scope 1, 2, total; Co2/va;
         Gj/va; Electricity; Self generation"; groups "export vs non
         export, import vs non import, fdi vs non fdi"; "average 2013-14".
  Foreign-owned = 10% or more of the firm's capital held abroad
         (fdi_10_flag), the definition used in every R1-R3 exhibit.
  Output : figures/05_before_after_paris.png (+ .pdf)
           tables/05_before_after_paris.csv   (every outcome x grouping)
           tables/05_before_after_paris_table.pdf (every plotted point)
  Runtime: about 3 minutes (999 random redraws for each of 4 groupings).
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

* ---- THE WINDOWS (why: INDEX.md, paragraph "05") ------------------------------------------
local pre_yrs  "2013 2014"   // before Paris: Deasy's "average 2013-14"
local post_yrs "2018"        // after Paris: the one later year whose energy records look normal in
                             // every group (2017 jumps; 2019-2022 drop for about a third of firms)
* Check window, table only: every later year, minus years where a group flag is wrong or empty
local chk_all    "2017 2018 2019 2020 2021 2022"
local chk_export "2017 2018 2019 2020 2021"       // 2022: no firm is recorded as a non-exporter
local chk_import "2017 2018 2019 2020 2021 2022"
local chk_fdi    "2017 2018 2019 2021 2022"       // 2020: far more firms marked foreign-owned
local min_n  30              // a group's yearly value is used only if at least 30 firms have it
local og_min 75              // own-electricity rows use a year only if at least 75% of the group's
                             // firms have own electricity recorded (2014: only 57%, and the unrecorded
                             // firms are almost all non-makers, so dividing by recorded firms inflates it)
local reps   999             // random redraws of each year's firms, for the 95% ranges
* -------------------------------------------------------------------------------------------

cap log close
log using "logs/05_before_after_paris.log", replace text
timer clear 1
timer on 1
display _newline "=== [R1-05] STARTING: before vs after Paris, every outcome, all firms and three groupings ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

display "Step 1/8: load energy, CO2, electricity, value added, workers and the three group flags"
* gj_fuel_s1      = energy from nine fuels burned at the plant (GJ)      = scope 1
* gj_electricity  = energy from bought electricity (GJ = kWh x 0.0036)  = scope 2
* total_gj_s1     = the two together; co2_* = the matching CO2 in tonnes (energy x standard factors)
* elec_owngen_kwh = electricity the firm makes itself (kWh); own_gen_unknown = 1 if not recorded
use firm_id year export_flag import_flag fdi_10_flag gj_fuel_s1 gj_electricity total_gj_s1 ///
    co2_scope1_s1 co2_scope2_s1 co2_total_s1 elec_purchased_kwh elec_owngen_kwh own_gen_unknown ///
    value_added_nominal workers using "$DATA", clear
isid firm_id year
assert year != 2016
assert inlist(export_flag, 0, 1, .) & inlist(import_flag, 0, 1, .) & inlist(fdi_10_flag, 0, 1, .)
* the scope parts add up to the totals, so the three scopes are consistent
assert abs(total_gj_s1 - gj_fuel_s1 - gj_electricity) <= 1e-6 * total_gj_s1
assert abs(co2_total_s1 - co2_scope1_s1 - co2_scope2_s1) <= 1e-6 * co2_total_s1

display "Step 2/8: one value per firm and year for every outcome"
* "Absent is not zero": the energy fields cover a fixed list of fuels, so a zero may mean
* "not recorded". Each outcome uses only firms whose quantities in it are above zero:
*   scope-1 rows: fuel energy and fuel CO2 > 0;  scope-2 rows: bought electricity > 0;
*   total rows: total energy and total CO2 > 0 (the R1-02 to R1-04 sample). Value added > 0 in all.
gen byte va_ok = value_added_nominal > 0 & !missing(value_added_nominal)
gen byte s1 = va_ok & gj_fuel_s1 > 0     & co2_scope1_s1 > 0 & !missing(gj_fuel_s1, co2_scope1_s1)
gen byte s2 = va_ok & gj_electricity > 0 & co2_scope2_s1 > 0 & !missing(gj_electricity, co2_scope2_s1)
gen byte st = va_ok & total_gj_s1 > 0    & co2_total_s1 > 0  & !missing(total_gj_s1, co2_total_s1)
* own electricity: only firms where it is recorded (own_gen_unknown == 0)
gen byte og = st & own_gen_unknown == 0 & !missing(elec_owngen_kwh, elec_purchased_kwh)
* per million money units of value added (a unit a reader can picture)
gen double o1  = 1e6 * gj_fuel_s1     / value_added_nominal if s1   // energy per VA, fuels
gen double o2  = 1e6 * gj_electricity / value_added_nominal if s2   // energy per VA, bought electricity
gen double o3  = 1e6 * total_gj_s1    / value_added_nominal if st   // energy per VA, total ("Gj/va")
gen double o4  = 1e6 * co2_scope1_s1  / value_added_nominal if s1   // CO2 per VA, fuels
gen double o5  = 1e6 * co2_scope2_s1  / value_added_nominal if s2   // CO2 per VA, bought electricity
gen double o6  = 1e6 * co2_total_s1   / value_added_nominal if st   // CO2 per VA, total ("Co2/va")
gen double o7  = gj_fuel_s1     if s1                               // energy used (GJ)
gen double o8  = gj_electricity if s2
gen double o9  = total_gj_s1    if st
gen double o10 = co2_scope1_s1  if s1                               // CO2 emitted (tonnes)
gen double o11 = co2_scope2_s1  if s2
gen double o12 = co2_total_s1   if st
gen double o13 = gj_fuel_s1     / co2_scope1_s1 if s1               // GJ per tonne of CO2 ("GJ/emisi")
gen double o14 = gj_electricity / co2_scope2_s1 if s2               // one national grid factor: same for all
gen double o15 = total_gj_s1    / co2_total_s1  if st
gen double o16 = 100 * gj_electricity / total_gj_s1 if st           // bought electricity, % of energy
gen double o17 = 100 * (elec_owngen_kwh > 0) if og                  // makes some own electricity (0 or 100)
gen double o18 = 100 * elec_owngen_kwh / (elec_owngen_kwh + elec_purchased_kwh) ///
                 if og & elec_owngen_kwh + elec_purchased_kwh > 0   // own electricity, % of electricity used
gen double o19 = value_added_nominal if st                          // for comparison: value added
gen double o20 = workers if st & workers > 0                        // for comparison: workers
gen double o21 = value_added_nominal / gj_fuel_s1     if s1         // Deasy's "VA/energy use" (table only):
gen double o22 = value_added_nominal / gj_electricity if s2         //   o1-o3 upside down
gen double o23 = value_added_nominal / total_gj_s1    if st
gen double o24 = value_added_nominal / co2_scope1_s1  if s1         // Deasy's "VA/emisi" (table only):
gen double o25 = value_added_nominal / co2_scope2_s1  if s2         //   o4-o6 upside down
gen double o26 = value_added_nominal / co2_total_s1   if st
local K 26
keep firm_id year export_flag import_flag fdi_10_flag o1-o`K'
tempfile base
save `base'

* Program: from firm-level data in memory (year, grp, o1-o26) compute each group's yearly
* median (for o17-o18 the average: they are shares of firms, mostly 0), drop yearly values
* resting on fewer than min_n firms, average them over the before years and over the after
* years, and post the % changes. rel = the group's change set against the other firms':
* (1 + group's change) / (1 + other firms' change) - 1, in %; 0 = both changed by the same %.
capture program drop r105stat
program define r105stat
    args h rep preyrs postyrs K minn ogmin
    quietly {
        gen byte per = .
        foreach y of local preyrs {
            replace per = 1 if year == `y'
        }
        foreach y of local postyrs {
            replace per = 2 if year == `y'
        }
        keep if !missing(per)
        local cnt ""
        local med ""
        local all ""
        forvalues k = 1/`K' {
            local cnt "`cnt' c`k' = o`k'"
            local all "`all' o`k'"
            if !inlist(`k', 17, 18) local med "`med' o`k'"
        }
        collapse (p50) `med' (mean) o17 o18 (count) `cnt', by(grp per year)
        forvalues k = 1/`K' {
            replace o`k' = . if c`k' < `minn'
        }
        foreach k in 17 18 {        // own electricity: skip years where too few firms record it
            replace o`k' = . if c`k' < `ogmin' / 100 * c3
        }
        * a year dropped for one group is dropped for the other too, so both use the same years
        sort per year grp
        forvalues k = 1/`K' {
            by per year: replace o`k' = . if missing(o`k'[1]) | missing(o`k'[_N])
        }
        collapse (mean) `all', by(grp per)
        sort grp per
        assert inlist(_N, 2, 4) & per == 2 - mod(_n, 2)   // rows: (grp, before), (grp, after)
        forvalues k = 1/`K' {
            if _N == 4 {            // rows 1-2 = other firms (grp 0), rows 3-4 = the group (grp 1)
                local c0 = 100 * (o`k'[2] / o`k'[1] - 1)
                local c1 = 100 * (o`k'[4] / o`k'[3] - 1)
                local rr = 100 * ((o`k'[4] / o`k'[3]) / (o`k'[2] / o`k'[1]) - 1)
                post `h' (`rep') (`k') (o`k'[3]) (o`k'[4]) (`c1') (o`k'[1]) (o`k'[2]) (`c0') (`rr')
            }
            else {                  // all firms: one group
                local c1 = 100 * (o`k'[2] / o`k'[1] - 1)
                post `h' (`rep') (`k') (o`k'[1]) (o`k'[2]) (`c1') (.) (.) (.) (.)
            }
        }
    }
end

display "Step 3/8: yearly group values and counts, every year (for the table)"
local groupings "all export_flag import_flag fdi_10_flag"
local i 0
foreach g of local groupings {
    local ++i
    use `base', clear
    if "`g'" == "all" gen byte grp = 1
    else gen byte grp = `g'
    drop if missing(grp)          // unknown status is left out, never counted as "no"
    local cnt ""
    local med ""
    forvalues k = 1/`K' {
        local cnt "`cnt' n`k' = o`k'"
        if !inlist(`k', 17, 18) local med "`med' o`k'"
    }
    collapse (p50) `med' (mean) o17 o18 (count) `cnt', by(grp year)
    gen byte og_used = n17 >= `og_min' / 100 * n3    // own electricity recorded for enough firms
    gen str12 grouping = "`g'"
    tempfile yr`i'
    save `yr`i''
}
use `yr1', clear
forvalues j = 2/4 {
    append using `yr`j''
}
reshape long o n, i(grouping grp year og_used) j(k)
gen byte used = cond(inlist(k, 17, 18), og_used, 1) & n >= `min_n'
drop og_used
tempfile yearly
save `yearly'

display "Step 4/8: before/after changes, the check window, and `reps' random redraws per grouping"
local pre_in  = subinstr("`pre_yrs'", " ", ",", .)
local post_in = subinstr("`post_yrs'", " ", ",", .)
tempname h
local i 0
foreach g of local groupings {
    local ++i
    use `base', clear
    if "`g'" == "all" gen byte grp = 1
    else gen byte grp = `g'
    drop if missing(grp)
    keep year grp o1-o`K'
    tempfile gdata bdata pts`i'
    save `gdata'
    if "`g'" == "export_flag" local chk "`chk_export'"
    if "`g'" == "import_flag" local chk "`chk_import'"
    if "`g'" == "fdi_10_flag" local chk "`chk_fdi'"
    if "`g'" == "all"         local chk "`chk_all'"
    local chk_`i' "`chk'"
    postfile `h' int rep int k double(pre1 post1 pct1 pre0 post0 pct0 rel) using `pts`i'', replace
    r105stat `h' 0 "`pre_yrs'" "`post_yrs'" `K' `min_n' `og_min'   // rep 0  = the result
    use `gdata', clear
    r105stat `h' -1 "`pre_yrs'" "`chk'" `K' `min_n' `og_min'       // rep -1 = check window
    use `gdata', clear
    keep if inlist(year, `pre_in', `post_in')
    save `bdata'
    display "   `g': redrawing firms `reps' times"
    set seed 20260925
    forvalues r = 1/`reps' {
        quietly use `bdata', clear     // quietly: otherwise the data label fills the log 999 times
        bsample, strata(year grp)      // redraw firms within each year and group
        r105stat `h' `r' "`pre_yrs'" "`post_yrs'" `K' `min_n' `og_min'
        if mod(`r', 250) == 0 display "      `r' of `reps' done"
    }
    postclose `h'
}
forvalues j = 1/4 {
    use `pts`j'', clear
    gen str12 grouping = word("`groupings'", `j')
    gen str40 chk_years = "`chk_`j''"
    save `pts`j'', replace
}
use `pts1', clear
forvalues j = 2/4 {
    append using `pts`j''
}
tempfile allpts
save `allpts'

display "Step 5/8: 95% ranges from the redraws (middle 95% of the redrawn changes)"
use `allpts', clear
keep if rep >= 1
foreach v in pct1 pct0 rel {
    egen double `v'_lo95 = pctile(`v'), by(grouping k) p(2.5)
    egen double `v'_hi95 = pctile(`v'), by(grouping k) p(97.5)
}
bysort grouping k (rep): keep if _n == 1
keep grouping k *_lo95 *_hi95
tempfile ci
save `ci'
use `allpts', clear
keep if rep == -1
keep grouping k chk_years post1 post0 pct1 pct0 rel
rename (post1 post0 pct1 pct0 rel) (chk_after_g1 chk_after_g0 chk_pct_g1 chk_pct_g0 chk_rel_pct)
tempfile chk
save `chk'
* yearly values and counts behind the before and after averages
use `yearly', clear
keep if inlist(year, `pre_in', `post_in')
drop used
reshape wide o n, i(grouping k grp) j(year)
local w ""
foreach y in `pre_yrs' `post_yrs' {
    rename (o`y' n`y') (val_`y'_g n_`y'_g)
    local w "`w' val_`y'_g n_`y'_g"
}
reshape wide `w', i(grouping k) j(grp)
tempfile yrs
save `yrs'

* before-years actually used for each row (own-electricity rows can skip a year), for the table
use `yearly', clear
keep if inlist(year, `pre_in')
collapse (min) used, by(grouping k year)       // a year counts only if every group can use it
keep if used == 1
sort grouping k year
by grouping k: gen str20 years_before_used = string(year) if _n == 1
by grouping k: replace years_before_used = years_before_used[_n-1] + " " + string(year) if _n > 1
by grouping k: keep if _n == _N
keep grouping k years_before_used
rename k outcome_id
tempfile usedyrs
save `usedyrs'

display "Step 6/8: table -> CSV (numbers written before drawing)"
use `allpts', clear
keep if rep == 0
drop rep chk_years
merge 1:1 grouping k using `ci',  nogenerate assert(match)
merge 1:1 grouping k using `chk', nogenerate assert(match)
merge 1:1 grouping k using `yrs', nogenerate assert(match)
rename (pre1 post1 pct1 pre0 post0 pct0 rel) (before_g1 after_g1 pct_g1 before_g0 after_g0 pct_g0 rel_pct)
rename (pct1_lo95 pct1_hi95 pct0_lo95 pct0_hi95) (pct_g1_lo95 pct_g1_hi95 pct_g0_lo95 pct_g0_hi95)
gen double diff_points = pct_g1 - pct_g0
* clear = the 95% range excludes 0 (all firms: the change; groups: the gap between the two changes)
gen byte clear = cond(grouping == "all", pct_g1_lo95 > 0 | pct_g1_hi95 < 0, rel_lo95 > 0 | rel_hi95 < 0)
replace clear = . if missing(cond(grouping == "all", pct_g1, rel_pct))
gen byte panel = 1*(grouping == "all") + 2*(grouping == "export_flag") + 3*(grouping == "import_flag") + 4*(grouping == "fdi_10_flag")
gen str30 grp1_label = word("All_firms Exporters Importers Foreign-owned", panel)
replace grp1_label = subinstr(grp1_label, "_", " ", .)
gen str30 grp0_label = word("- Non-exporters Non-importers Other_firms", panel)
replace grp0_label = subinstr(grp0_label, "_", " ", .)
replace grp0_label = "" if panel == 1
* what each row is: section heading, row label, unit, Deasy's words, statistic
gen str40 section = ""
gen str50 row_label = ""
gen str40 unit = ""
gen str70 deasy_item = ""
gen str40 statistic = "median of firms"
local sec1 "Energy (GJ) per unit of VA"
local sec2 "CO2 (tonnes) per unit of VA"
local sec3 "Energy used (GJ)"
local sec4 "CO2 emitted (tonnes)"
local sec5 "Energy (GJ) per tonne of CO2"
local sec6 "Electricity"
local sec7 "For comparison"
forvalues k = 1/15 {
    local s = ceil(`k' / 3)
    local j = `k' - 3 * (`s' - 1)
    replace section = "`sec`s''" if k == `k'
    replace row_label = word("Scope_1_(fuels) Scope_2_(bought_electricity) Total", `j') if k == `k'
}
replace row_label = "Scope 2 (same for all firms)" if k == 14
replace section = "`sec6'" if inrange(k, 16, 18)
replace row_label = "Bought, % of energy used"   if k == 16
replace row_label = "Firms making their own, %"  if k == 17
replace row_label = "Own, % of electricity used" if k == 18
replace section = "`sec7'" if inrange(k, 19, 20)
replace row_label = "Value added (current prices)" if k == 19
replace row_label = "Workers" if k == 20
replace section = "Value added per GJ (table only)" if inrange(k, 21, 23)
replace section = "Value added per tonne of CO2 (table only)" if inrange(k, 24, 26)
forvalues k = 21/26 {
    replace row_label = word("Scope_1_(fuels) Scope_2_(bought_electricity) Total", `k' - 20 - 3*(`k' > 23)) if k == `k'
}
replace row_label = subinstr(row_label, "_", " ", .)
replace unit = "GJ per million of value added"          if inrange(k, 1, 3)
replace unit = "tonnes CO2 per million of value added"  if inrange(k, 4, 6)
replace unit = "GJ"                                     if inrange(k, 7, 9)
replace unit = "tonnes CO2"                             if inrange(k, 10, 12)
replace unit = "GJ per tonne CO2"                       if inrange(k, 13, 15)
replace unit = "% of GJ"                                if k == 16
replace unit = "% of firms with own electricity recorded" if k == 17
replace unit = "% of kWh used (bought + own)"           if k == 18
replace unit = "money units, current prices (masked)"   if k == 19
replace unit = "workers"                                if k == 20
replace unit = "value added per GJ"                     if inrange(k, 21, 23)
replace unit = "value added per tonne CO2"              if inrange(k, 24, 26)
replace statistic = "average over firms (share)" if inlist(k, 17, 18)
replace deasy_item = "Gj/va (scope parts); VA/energy use upside down"  if inrange(k, 1, 3)
replace deasy_item = "Co2/va (scope parts); VA/emisi upside down"      if inrange(k, 4, 6)
replace deasy_item = "Energi use, scope 1, 2, total"                   if inrange(k, 7, 9)
replace deasy_item = "Emisi, scope 1, 2, total"                        if inrange(k, 10, 12)
replace deasy_item = "GJ/emisi, scope 1, 2, total"                     if inrange(k, 13, 15)
replace deasy_item = "Electricity"                                     if k == 16
replace deasy_item = "Self generation"                                 if inlist(k, 17, 18)
replace deasy_item = "(reference, not in Deasy's list)"                if inlist(k, 19, 20)
replace deasy_item = "VA/energy use, scope 1, scope 2, total"          if inrange(k, 21, 23)
replace deasy_item = "VA/emisi, scope 1, scope 2, total"               if inrange(k, 24, 26)
gen byte in_figure = k <= 20
gen str90 note = ""
replace note = "Same for every firm in a year (electricity GJ / grid factor): no firm or group difference can exist" if k == 14
replace note = "Fewer than `min_n' firms in a group-year: left empty" if missing(pct_g1) | (panel > 1 & missing(pct_g0))
rename k outcome_id
merge 1:1 grouping outcome_id using `usedyrs', nogenerate assert(match)
replace note = "Before = " + years_before_used + " only: in other before-years own electricity is recorded for under `og_min'% of a group's firms" ///
    if years_before_used != "`pre_yrs'" & inlist(outcome_id, 17, 18)
gen str20 years_before = "`pre_yrs'"
gen str20 years_after  = "`post_yrs'"
order grouping grp1_label grp0_label outcome_id section row_label unit statistic deasy_item in_figure ///
      years_before years_before_used years_after n_* val_* before_g1 after_g1 pct_g1 pct_g1_lo95 pct_g1_hi95 ///
      before_g0 after_g0 pct_g0 pct_g0_lo95 pct_g0_hi95 rel_pct rel_lo95 rel_hi95 clear diff_points ///
      chk_years chk_after_g1 chk_after_g0 chk_pct_g1 chk_pct_g0 chk_rel_pct note
sort panel outcome_id
format n_* %9.0f
format val_* before_* after_* chk_after_* %14.4f
format pct_* rel_* diff_points chk_pct_* chk_rel_pct %8.2f
* structural checks: the ranges contain the result; the fixed-factor row shows no group gap
assert pct_g1_lo95 <= pct_g1 + 1e-9 & pct_g1 <= pct_g1_hi95 + 1e-9 if !missing(pct_g1)
assert rel_lo95 <= rel_pct + 1e-9 & rel_pct <= rel_hi95 + 1e-9 if !missing(rel_pct)
assert abs(rel_pct) < 1e-9 if outcome_id == 14 & panel > 1
assert reldif(1 + rel_pct/100, (1 + pct_g1/100) / (1 + pct_g0/100)) < 1e-9 if !missing(rel_pct)
export delimited grouping-note using "tables/05_before_after_paris.csv", datafmt replace
tempfile ctsrc                     // same numbers, full precision, for the companion table (Step 8)
quietly save `ctsrc'
list grouping outcome_id before_g1 after_g1 pct_g1 pct_g1_lo95 pct_g1_hi95 if panel == 1 & in_figure, noobs sep(0) abbreviate(24)
list grouping outcome_id pct_g1 pct_g0 rel_pct rel_lo95 rel_hi95 clear n_2018_g1 n_2018_g0 if panel > 1 & in_figure, noobs sepby(grouping) abbreviate(24)

display "Step 7/8: dot plot: one row per outcome, four panels on one shared scale"
* words for the notes and axis, built from the windows above (never typed)
local pre_txt = subinstr("`pre_yrs'", " ", " and ", .)
local post_txt = subinstr("`post_yrs'", " ", ", ", .)
keep if in_figure
* y position: 7 sections (heading line + up to 3 rows), in Deasy's order
gen byte s = cond(outcome_id <= 18, ceil(outcome_id / 3), 7)
gen byte j = cond(outcome_id <= 18, outcome_id - 3 * (s - 1), outcome_id - 18)
gen double y = 4 * (s - 1) + j
local ylab ""
forvalues s = 1/7 {
    local h = 4 * (`s' - 1)
    local ylab `"`ylab' `h' "{bf:`sec`s''}""'
}
sort panel y
forvalues i = 1/`=_N' {
    if panel[`i'] == 1 {
        local yy = y[`i']
        local ll = row_label[`i']
        local ylab `"`ylab' `yy' "`ll'""'
    }
}
local ymax = 26.6
label define panel 1 "(a) All firms" 2 "(b) Exporters" 3 "(c) Importers" 4 "(d) Foreign-owned"
label values panel panel
* the internationalised group's marker is drawn in every panel; the other firms' only in (b)-(d)
gen double lo = pct_g1_lo95 if panel == 1
gen double hi = pct_g1_hi95 if panel == 1
replace pct_g0 = . if panel == 1
* shared x scale: a round range (steps of 50) around every marker and range
egen double xl = rowmin(pct_g1 pct_g0 lo)
egen double xh = rowmax(pct_g1 pct_g0 hi)
quietly summarize xl
local xlo = 50 * floor(min(r(min), -50) / 50)
quietly summarize xh
local xhi = 50 * ceil(max(r(max), 50) / 50)
display "   x range `xlo' to `xhi'"
* the number printed at the right of every row: (a) the change; (b)-(d) the gap between the two
* changes (rel). Whole %, from the same values as the marks; gray when its 95% range includes 0.
gen double labv = cond(panel == 1, pct_g1, rel_pct)
gen str8 lab = cond(round(labv) == 0, "0", cond(labv > 0, "+", "") + string(round(labv), "%9.0f")) if !missing(labv)
local labx = `xhi' + 65
gen double labx = `labx' if !missing(labv)
* dashed 0 line in each panel (8 rows) and the number-column heading (4 rows)
local n0 = _N
set obs `=_N + 12'
gen double refx = 0 if _n > `n0'
gen double refy = .
gen double hx = .
gen double hy = .
gen str10 htxt = ""
forvalues p = 1/4 {
    replace panel = `p' in `=`n0' + 2*`p' - 1'
    replace panel = `p' in `=`n0' + 2*`p''
    replace refy = 0.5 in `=`n0' + 2*`p' - 1'
    replace refy = `ymax' in `=`n0' + 2*`p''
    local r = `n0' + 8 + `p'
    replace panel = `p' in `r'
    replace hx = `labx' in `r'
    replace hy = 0 in `r'
    replace htxt = cond(`p' == 1, "change", "gap") in `r'
}
sort panel refy y
* Notes: one text, wrapped here into lines of at most 105 characters (PDF text runs wider than the PNG)
local ntext "Notes: % change in the middle (median) firm from before the Paris Agreement (adopted December 2015) to after. After = `post_txt' only: other later files have many energy records that jump or drop sharply (see Figures R1-02 to R1-04). Own-electricity rows: only years where `og_min'%+ of firms record it. VA = value added = output value minus materials, energy and services bought, at current prices, so price rises alone push per-VA rows down. Numbers: (a) the change; (b)–(d) the gap = % change in the group's median divided by other firms' (0 = both changed alike); gray = its 95% range includes 0. Foreign-owned = 10%+ of capital held abroad; unknown status is left out. Firms differ each year (none is followed); groups differ in size and industry. Later files count far more firms as importers, most with no export answer; this drives much of (a) and (c). Many rows already moved this way before Paris: this shows change, not its cause."
local notelines ""
local line ""
foreach w of local ntext {
    if ustrlen("`line' `w'") > 105 & "`line'" != "" {
        local notelines `"`notelines' "`line'""'
        local line "`w'"
    }
    else local line = strtrim("`line' `w'")
}
local notelines `"`notelines' "`line'""'
display `"   note lines: `notelines'"'

twoway (rspike pct_g0 pct_g1 y if panel > 1 & clear == 1, horizontal lcolor(black) lwidth(medthin)) ///
    (rspike pct_g0 pct_g1 y if panel > 1 & clear == 0, horizontal lcolor(gs12) lwidth(medthin)) ///
    (rspike lo hi y, horizontal lcolor(black) lwidth(thin)) ///
    (scatter y pct_g0, msymbol(S) mfcolor(white) mlcolor(gs5) msize(small)) ///
    (scatter y pct_g1, msymbol(O) mcolor(black) msize(small)) ///
    (line refy refx, lpattern(dash) lcolor(gs8) lwidth(thin)) ///
    (scatter y labx if clear == 1, msymbol(none) mlabel(lab) mlabpos(0) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter y labx if clear != 1, msymbol(none) mlabel(lab) mlabpos(0) mlabsize(vsmall) mlabcolor(gs9)) ///
    (scatter hy hx, msymbol(none) mlabel(htxt) mlabpos(0) mlabsize(vsmall) mlabcolor(black)), ///
    by(panel, rows(1) imargin(tiny) graphregion(color(white) lcolor(white) ilcolor(white) margin(r+3)) legend(pos(6)) ///
        title("Figure R1-05. Energy, CO2 and electricity before vs after the Paris Agreement", ///
              size(small) pos(11) span) ///
        note(`notelines' "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6))) ///
    subtitle(, pos(11) nobox fcolor(white) lcolor(white) size(small)) ///
    yscale(reverse noline range(-0.3 `ymax')) ylabel(`ylab', angle(0) noticks tlength(0) nogrid labsize(vsmall)) ytitle("") ///
    xscale(range(`xlo' `=`labx' + 12') noline) ///
    xlabel(`xlo'(100)`xhi', format(%9.0f) noticks tlength(0) labsize(vsmall) grid glcolor(gs15) glwidth(vthin)) ///
    xmtick(`xlo'(50)`xhi', noticks tlength(0) grid glcolor(gs15) glwidth(vthin)) ///
    xtitle("% change from before (average of `pre_txt') to after (`post_txt')", size(vsmall)) ///
    legend(order(5 "All firms (a); the panel's group (b)–(d)" 4 "Other firms (b)–(d)" ///
                 3 "95% range of the change (a)" 6 "0 = no change" ///
                 1 "Black link: the two changes clearly differ" 2 "Gray link or number: not clear") ///
        cols(2) region(lcolor(none)) size(vsmall) symxsize(8) keygap(1) colgap(6) rowgap(0.5)) ///
    plotregion(style(none)) xsize(8) ysize(10)

graph export "figures/05_before_after_paris.png", width(2400) replace
graph export "figures/05_before_after_paris.pdf", replace

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
* Source: the table saved right after the CSV export (full precision, same run
* as the chart). One row per plotted point, in chart order: panel (a) all firms,
* then (b) exporters, (c) importers, (d) foreign-owned; within a panel the 20
* chart rows top to bottom. (a): one row per chart row (the dot, its 95% range
* and the number printed at the right, which is the dot rounded). (b)-(d): three
* rows per chart row: the group's dot, the other firms' square, and the gap
* printed at the right (with its 95% range; it sets the link's colour).
use `ctsrc', clear
keep if in_figure
gen byte s = cond(outcome_id <= 18, ceil(outcome_id / 3), 7)
gen byte j = cond(outcome_id <= 18, outcome_id - 3 * (s - 1), outcome_id - 18)
sort panel s j
local nrow = 20
assert _N == 4 * `nrow'
* marks on the chart: every dot; in (b)-(d) also every square and every printed gap
quietly count if !missing(pct_g1)
local nmarks = r(N)
quietly count if !missing(pct_g0) & panel > 1
local nmarks = `nmarks' + r(N)
quietly count if !missing(rel_pct) & panel > 1
local nmarks = `nmarks' + r(N)
gen byte chartrow = _n
expand cond(panel == 1, 1, 3)
bysort chartrow: gen byte series = cond(panel == 1, 0, _n)     // 0 = (a) dot; 1 = group dot, 2 = other firms, 3 = gap
sort chartrow series
local ntab = `nrow' + 3 * 3 * `nrow'
assert _N == `ntab'
gen str20 t_panel = word("(a)_All_firms (b)_Exporters (c)_Importers (d)_Foreign-owned", panel)
replace t_panel = subinstr(t_panel, "_", " ", .)
gen str90 t_out = section + ": " + row_label
gen str20 t_series = cond(series == 0, "All firms", cond(series == 1, word("- Exporters Importers Foreign-owned", panel), ///
                     cond(series == 2, "Other firms", "Gap, as printed")))
* the number printed at the right: whole %, exactly as the chart; its range the same way
gen double labv = cond(panel == 1, pct_g1, rel_pct)
gen double lo = cond(panel == 1, pct_g1_lo95, rel_lo95)
gen double hi = cond(panel == 1, pct_g1_hi95, rel_hi95)
gen str12 t_v = ""
replace t_v = cond(round(labv) == 0, "0", cond(labv > 0, "+", "") + string(round(labv), "%9.0f")) if inlist(series, 0, 3) & !missing(labv)
* unlabelled marks (the dot and the square in (b)-(d)): one decimal
replace t_v = cond(pct_g1 > 0, "+", "") + string(pct_g1, "%9.1f") if series == 1 & !missing(pct_g1)
replace t_v = cond(pct_g0 > 0, "+", "") + string(pct_g0, "%9.1f") if series == 2 & !missing(pct_g0)
gen str12 t_lo = cond(round(lo) > 0, "+", "") + string(round(lo), "%9.0f") if inlist(series, 0, 3) & !missing(lo)
gen str12 t_hi = cond(round(hi) > 0, "+", "") + string(round(hi), "%9.0f") if inlist(series, 0, 3) & !missing(hi)
* firms behind the point: each before year and the after year (gap: both groups)
gen str40 t_n = ""
local fyrs "`pre_yrs' `post_yrs'"
foreach y of local fyrs {
    gen double nn = cond(inlist(series, 0, 1), n_`y'_g1, cond(series == 2, n_`y'_g0, n_`y'_g1 + n_`y'_g0))
    replace t_n = t_n + cond(t_n == "", "", " · ") + string(nn, "%12.0fc") if !missing(nn)
    drop nn
}
local fyrs_h = subinstr("`fyrs'", " ", " · ", .)
* status: drawn or not; for the number, black = its 95% range excludes 0
gen str90 t_status = "drawn"
replace t_status = cond(clear == 1, "black: range excludes 0", "gray: range includes 0") if inlist(series, 0, 3)
replace t_status = t_status + "; 0 by construction" if outcome_id == 14 & series == 3
replace t_status = t_status + "; before = " + years_before_used + " only" if years_before_used != "`pre_yrs'" & inlist(outcome_id, 17, 18)
replace t_status = "not drawn: under `min_n' firms in a group-year" if t_v == ""
* checks: one row per mark ((a): the dot and its printed number share a row);
* the drawn rows equal the marks counted before the rows were split
quietly count if !strpos(t_status, "not drawn")
assert r(N) == `nmarks'
assert t_lo != "" & t_hi != "" if inlist(series, 0, 3) & !strpos(t_status, "not drawn")
local ntext_t = itrim(`"`ntext'"')
local tnote "Table: every mark of Figure R1-05, panel by panel, top to bottom. (a): the dot with its 95% range and the number printed"
local tnote "`tnote' at the right (whole %, as printed). (b)–(d): the group's dot and the other firms' square (one decimal), then the gap printed at the"
local tnote "`tnote' right with its 95% range (whole %); black/gray = colour of that number and of the link. Ranges from `reps' redraws of each"
local tnote "`tnote' year's firms. Firms = firms with the outcome in `fyrs_h' (gap: both groups). Full precision: tables/05_before_after_paris.csv."
local r "`nrow'"
forvalues p = 2/3 {
    local r "`r' `=`nrow' + 3 * `nrow' * (`p' - 1)'"
}
ctable_pdf t_panel t_out t_series t_v t_lo t_hi t_n t_status using "tables/05_before_after_paris_table.pdf", ///
    title("Table R1-05. Energy, CO2 and electricity before vs after the Paris Agreement: every plotted point") ///
    subtitle("% change from before (average of `pre_txt') to after (`post_txt')") ///
    header("Panel" "Outcome" "Series" "Plotted|value, %" "95% range|low" "95% range|high" "Firms|`fyrs_h'" "Status") ///
    right(4 5 6 7) norepeat(1 2) fontsize(9) rules(`r') perpage(27) ///
    notes("`ntext_t'" "`tnote'" "`srcnote'" "`devnote'")
display "table -> tables/05_before_after_paris_table.pdf"
* --- end of PART 2 ------------------------------------------------------------

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/05_before_after_paris.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
