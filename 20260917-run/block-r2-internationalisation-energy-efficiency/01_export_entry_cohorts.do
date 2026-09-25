/*==========================================================================
  R2-01  In which year did each firm start exporting, how many firms start
         each year, and which firms cannot be dated? A staggered before/after
         comparison needs one start year per firm.
  Answers Deasy R2: "Intertionalized and energy efficiency" - Strategy
         "Stagged did" - Notes "Mirip dengan paper kita sebelumnya hanya
         Ganti tahun" (the previous paper's entry rule is built as rule B).
  Output : figures/01_export_entry_cohorts.png (+ .pdf)
           tables/01_export_entry_cohorts.csv (export, import and foreign
           ownership of 10%+; both entry rules side by side)
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
global OUTDIR "/Users/natanaelmassie/Downloads/2026-kolega-den-bps-repo/20260917-run/block-r2-internationalisation-energy-efficiency"
* ---------------------------------------------------------------------------
if `"`data_arg'"'   != "" global DATA   `"`data_arg'"'
if `"`outdir_arg'"' != "" global OUTDIR `"`outdir_arg'"'
cd "$OUTDIR"
foreach d in figures tables logs {
    capture mkdir "`d'"
}
cap log close
log using "logs/01_export_entry_cohorts.log", replace text
timer clear 1
timer on 1
display _newline "=== [R2-01] STARTING: firms that started exporting, by year of entry ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

*---------------------------------------------------------------------------
display "Step 1/5: load the participation flags"
*---------------------------------------------------------------------------
* export_flag  = any export activity (1 yes, 0 no, missing = unknown).
*                In 2022 the file records only direct exporters: no firm is 0.
* import_flag  = imports reported above zero (never missing)
* fdi_10_flag  = foreign ownership of 10% or more (the previous paper's rule)
use firm_id year export_flag import_flag fdi_10_flag using "$DATA", clear
isid firm_id year
local N_rows = _N
assert year != 2016
assert export_flag != 0 if year == 2022
sort firm_id year
tsset firm_id year                 // L. and F. below mean exact calendar years
egen byte firm_tag = tag(firm_id)
quietly count if firm_tag
local N_firms = r(N)
tempfile base rows
save `base'

*---------------------------------------------------------------------------
display "Step 2/5: date each firm's entry under two rules (same code in every R2 file)"
*---------------------------------------------------------------------------
* Missing status is unknown, never read as "not participating".
* Rule A, simple first entry (main): the first year the firm is seen
*   participating, if it was seen NOT participating in some earlier year.
*   Firms participating when first seen cannot be dated and are left out.
* Rule B, previous paper's sustained entry (variant): the first year t with
*   participation in t, none in t-1 AND t-2, and participation again in t+1
*   (exact calendar years; the missing 2016 file breaks the pattern).
* Comparison group for BOTH rules: firms never seen participating.
* Row keys: 9001 never seen participating · 9002 already participating when first
* seen (rule A, excluded) · 9003 status never observed · 9004 seen participating
* without the sustained pattern (rule B, excluded) · 8000 all entrants · 9999 all firms.
local first 1
foreach m in export import fdi10 {
    use `base', clear
    if "`m'" == "export" local x export_flag
    if "`m'" == "import" local x import_flag
    if "`m'" == "fdi10"  local x fdi_10_flag

    * --- Rule A ---
    by firm_id: egen int first_yes = min(cond(`x' == 1, year, .))
    by firm_id: egen int first_no  = min(cond(`x' == 0, year, .))
    by firm_id: egen int n_known   = total(!missing(`x'))
    gen int keyA = .
    replace keyA = 9003 if n_known == 0                                     // status never observed
    replace keyA = 9001 if n_known > 0 & missing(first_yes)                 // never seen participating
    replace keyA = 9002 if n_known > 0 & !missing(first_yes) & (missing(first_no) | first_no > first_yes)
    replace keyA = first_yes if n_known > 0 & !missing(first_yes) & !missing(first_no) & first_no < first_yes
    assert !missing(keyA)
    gen int gA = keyA if keyA < 9000                                        // entry year, rule A
    by firm_id: egen int last_no_before = max(cond(`x' == 0 & year < gA, year, .))
    gen byte exactA = !missing(gA) & last_no_before == gA - 1               // seen "no" the year just before
    by firm_id: egen int first_stop = min(cond(!missing(gA) & `x' == 0 & year > gA, year, .))
    gen byte stopA = !missing(first_stop)                                   // later seen not participating
    by firm_id: egen byte reenterA = max(!missing(first_stop) & `x' == 1 & year > first_stop)

    * --- Rule B ---
    gen byte cleanB = (`x' == 1 & L1.`x' == 0 & L2.`x' == 0 & F1.`x' == 1)
    by firm_id: egen int gB = min(cond(cleanB == 1, year, .))               // entry year, rule B
    by firm_id: egen byte earlier_yesB = max(`x' == 1 & year < gB & !missing(gB))
    gen int keyB = cond(!missing(gB), gB, cond(n_known == 0, 9003, cond(missing(first_yes), 9001, 9004)))

    * --- one row per firm, then one row per group ---
    gen byte one     = 1
    gen byte beforeA = !missing(gA) & year <  gA
    gen byte fromA   = !missing(gA) & year >= gA
    gen byte beforeB = !missing(gB) & year <  gB
    gen byte fromB   = !missing(gB) & year >= gB
    collapse (first) keyA keyB exactA stopA reenterA earlier_yesB ///
             (sum) fy = one bA = beforeA fA = fromA bB = beforeB fB = fromB, by(firm_id)
    preserve
    collapse (count) simple_firms = firm_id (sum) simple_firm_years = fy simple_rows_before_entry = bA ///
        simple_rows_from_entry = fA simple_entry_year_exact = exactA simple_later_stop = stopA ///
        simple_later_reenter = reenterA, by(keyA)
    rename keyA row_key
    tempfile tA
    save `tA'
    restore
    collapse (count) sustained_firms = firm_id (sum) sustained_firm_years = fy ///
        sustained_rows_before_entry = bB sustained_rows_from_entry = fB ///
        sustained_had_earlier_yes = earlier_yesB, by(keyB)
    rename keyB row_key
    merge 1:1 row_key using `tA', nogenerate

    * --- full row skeleton: entry years 2010-2022, then the other groups ---
    tempfile got
    save `got'
    clear
    set obs 19
    gen byte row_order = _n
    gen int row_key = 2009 + _n if _n <= 13
    replace row_key = 8000 if _n == 14                                      // all entrants
    replace row_key = 9001 if _n == 15
    replace row_key = 9002 if _n == 16
    replace row_key = 9004 if _n == 17
    replace row_key = 9003 if _n == 18
    replace row_key = 9999 if _n == 19                                      // all firms
    merge 1:1 row_key using `got', nogenerate
    assert !missing(row_order)

    * Which rule applies to which row (the other rule's cells stay empty).
    gen byte isA = (inrange(row_key, 2011, 2022) & row_key != 2016) | inlist(row_key, 9001, 9002, 9003)
    gen byte isB = inlist(row_key, 2012, 2013, 2014, 2019, 2020, 2021) | inlist(row_key, 9001, 9004, 9003)
    foreach v of varlist simple_* {
        replace `v' = 0 if isA & missing(`v')          // a possible group with no firms is a genuine 0
        replace `v' = . if !isA & row_key < 8000
    }
    foreach v of varlist sustained_* {
        replace `v' = 0 if isB & missing(`v')
        replace `v' = . if !isB & row_key < 8000
    }
    * Entry details only make sense for entrants.
    foreach v in simple_rows_before_entry simple_rows_from_entry simple_entry_year_exact simple_later_stop simple_later_reenter {
        replace `v' = . if row_key > 9000
    }
    foreach v in sustained_rows_before_entry sustained_rows_from_entry sustained_had_earlier_yes {
        replace `v' = . if row_key > 9000
    }
    replace simple_firms = . if row_key == 9004
    replace simple_firm_years = . if row_key == 9004
    replace sustained_firms = . if row_key == 9002
    replace sustained_firm_years = . if row_key == 9002
    * Totals: all entrants (row 14) and all firms (row 19).
    foreach v of varlist simple_* sustained_* {
        quietly summarize `v' if row_key < 8000
        replace `v' = r(sum) if row_key == 8000
    }
    foreach v in simple_firms simple_firm_years sustained_firms sustained_firm_years {
        quietly summarize `v' if row_key < 9999 & row_key != 8000
        replace `v' = r(sum) if row_key == 9999
    }
    assert simple_firms == `N_firms' & sustained_firms == `N_firms' if row_key == 9999
    assert simple_firm_years == `N_rows' & sustained_firm_years == `N_rows' if row_key == 9999
    assert simple_entry_year_exact <= simple_firms & simple_later_reenter <= simple_later_stop if row_key < 8000 & isA
    assert simple_rows_before_entry >= simple_firms & simple_rows_from_entry >= simple_firms if row_key < 8000 & isA
    if "`m'" == "export" assert simple_later_stop == 0 if inlist(row_key, 2022)     // nothing after the last file

    gen str6 margin = "`m'"
    if !`first' append using `rows'
    save `rows', replace
    local first 0
}

*---------------------------------------------------------------------------
display "Step 3/5: labels and notes -> CSV (numbers written before drawing)"
*---------------------------------------------------------------------------
gen int cohort_year = row_key if row_key < 8000
gen str80 group = ""
replace group = "Entered in " + string(row_key) if row_key < 8000
replace group = "All entrants"                                                   if row_key == 8000
replace group = "Never seen participating (comparison group, both rules)"        if row_key == 9001
replace group = "Already participating when first seen (simple rule: excluded)"  if row_key == 9002
replace group = "Seen participating, no sustained-entry pattern (sustained rule: excluded)" if row_key == 9004
replace group = "Participation status never observed"                            if row_key == 9003
replace group = "All firms"                                                      if row_key == 9999
gen str90 note = ""
replace note = "First file: entry cannot be seen" if row_key == 2010
replace note = "No annual file" if row_key == 2016
replace note = "Sustained rule cannot apply: needs 2009" if inlist(row_key, 2011)
replace note = "Sustained rule cannot apply: needs 2016" if inlist(row_key, 2015, 2017, 2018)
replace note = "Sustained rule cannot apply: needs 2023" if row_key == 2022
replace note = "Simple rule: entry made in 2016 or 2017; " + note if row_key == 2017
replace note = note + "; 2022 file records direct exporters only" if margin == "export" & row_key == 2022
replace note = "Inflated by the 2015-2017 jump in import share (likely coding change); " + note if margin == "import" & row_key == 2017
replace note = "Inflated by the 2020 foreign-ownership anomaly (48% of firms)" if margin == "fdi10" & row_key == 2020
gen byte morder = 1*(margin == "export") + 2*(margin == "import") + 3*(margin == "fdi10")
sort morder row_order
order margin row_order group cohort_year simple_firms simple_firm_years simple_rows_before_entry ///
      simple_rows_from_entry simple_entry_year_exact simple_later_stop simple_later_reenter ///
      sustained_firms sustained_firm_years sustained_rows_before_entry sustained_rows_from_entry ///
      sustained_had_earlier_yes note
format simple_* sustained_* %9.0f
export delimited margin-note using "tables/01_export_entry_cohorts.csv", datafmt replace
list margin group simple_firms simple_entry_year_exact sustained_firms if margin == "export", noobs sep(0) abbreviate(20)

*---------------------------------------------------------------------------
display "Step 4/5: numbers quoted in the notes (read from the table, never typed)"
*---------------------------------------------------------------------------
foreach k in 8000 9001 9002 9003 {
    quietly summarize simple_firms if margin == "export" & row_key == `k'
    local nA`k' : display %9.0fc r(sum)
    local nA`k' = strtrim("`nA`k''")
}
quietly summarize simple_later_stop if margin == "export" & row_key == 8000
local n_stop : display %9.0fc r(sum)
local n_stop = strtrim("`n_stop'")
quietly summarize sustained_firms if margin == "export" & row_key == 8000
local n_sust : display %9.0fc r(sum)
local n_sust = strtrim("`n_sust'")

*---------------------------------------------------------------------------
display "Step 5/5: bar chart of export entrants by entry year (rule A)"
*---------------------------------------------------------------------------
keep if margin == "export" & row_key < 8000
gen double total = simple_firms
gen double exact = simple_entry_year_exact
gen double zero  = 0
gen double exact_mid = exact / 2
quietly summarize total
local step = 10^floor(log10(r(max)))                        // axis step that grows with the counts
if r(max)/`step' < 2       local step = `step'/5
else if r(max)/`step' < 5  local step = `step'/2
local ytop = `step' * ceil(1.1*r(max)/`step')               // headroom for the count labels
gen double band_lo = 0   if row_key == 2016
gen double band_hi = `ytop' if row_key == 2016
gen str6 total_lbl = string(total, "%9.0f") if !missing(total)
gen str6 exact_lbl = string(exact, "%9.0f") if exact > 0 & !missing(exact)

twoway (rbar band_lo band_hi cohort_year, barwidth(0.9) fcolor(gs15) lcolor(gs15) lwidth(none)) ///
    (rbar zero exact cohort_year if !missing(total), barwidth(0.66) fcolor(gs4) lcolor(gs4) lwidth(vthin)) ///
    (rbar exact total cohort_year if !missing(total), barwidth(0.66) fcolor(white) lcolor(gs4) lwidth(medthin)) ///
    (scatter total cohort_year if total_lbl != "", msymbol(none) mlabel(total_lbl) mlabposition(12) mlabgap(0.6) ///
        mlabcolor(black) mlabsize(small)) ///
    (scatter exact_mid cohort_year if exact_lbl != "", msymbol(none) mlabel(exact_lbl) mlabposition(0) ///
        mlabcolor(white) mlabsize(small)), ///
    xlabel(2010(1)2022, labsize(small) noticks) xscale(range(2009.5 2022.5) lcolor(gs10)) ///
    ylabel(0(`step')`ytop', angle(0) labsize(small) nogrid noticks tlength(0) labgap(1.5)) yscale(range(0 `ytop') noline) ///
    xtitle("Year the firm is first seen exporting (entry year)", size(small)) ///
    ytitle("Number of firms", size(small) margin(r+2)) ///
    text(`=0.065*`ytop'' 2010 "First" "file", size(vsmall) color(gs7)) ///
    legend(order(2 "Seen not exporting the year just before (entry year exact)" ///
                 3 "Last seen not exporting 2+ years before (entry year approximate)" ///
                 1 "No annual file") cols(1) position(6) region(lstyle(none)) size(small) symysize(2.5) symxsize(4) keygap(1) rowgap(0.3)) ///
    title("Figure R2-01. Firms that started exporting, by year of entry", size(medium) position(11) justification(left) span) ///
    note("Notes: Entry year = first year a firm is seen exporting after an earlier year seen not exporting. No start can be seen in 2010, the first file." ///
         "The 2017 bar also holds 2016 starts (no 2016 file), so none is exact. The 2022 file asks only about direct exports. `n_stop' of the `nA8000'" ///
         "starters are later seen not exporting again. Not shown: `nA9001' firms never seen exporting (the comparison group in later R2 figures), `nA9002'" ///
         "already exporting when first seen (start year unknown) and `nA9003' with no known export status. The previous paper's stricter rule (no exports" ///
         "in both years before, exports again the year after) leaves `n_sust' starters. Firm links are fictional, so the 'no' and 'yes' years may belong to" ///
         "different real firms: this tests the method; it is not a finding." ///
         "`srcnote'" "`devnote'", size(vsmall) span) ///
    graphregion(color(white) lcolor(white) margin(r+3)) plotregion(style(none) margin(t+2 b=0)) ///
    xsize(8) ysize(6)

graph export "figures/01_export_entry_cohorts.png", width(2400) replace
graph export "figures/01_export_entry_cohorts.pdf", replace

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/01_export_entry_cohorts.png (elapsed `elapsed' s)"
quietly log close
