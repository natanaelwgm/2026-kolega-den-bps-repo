/*==========================================================================
  R2-02  For the firms that started exporting, how many are seen in each year
         before and after their start year? Which of those years have enough
         firms for the later before/after charts, and how many comparison
         firms (never seen exporting) are there each year?
  Answers Deasy R2: "Intertionalized and energy efficiency" - Strategy
         "Stagged did" (the firm counts a staggered before/after design stands on).
  Output : figures/02_event_time_support.png (+ .pdf)
           tables/02_event_time_support.csv (also holds the year window that
           R2-03, R2-04 and R2-05 read)
           tables/02_event_time_support_table.pdf (every plotted point)
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
global OUTDIR "/Users/natanaelmassie/Downloads/2026-kolega-den-bps-repo/20260917-run/block-r2-internationalisation-energy-efficiency"
* ---------------------------------------------------------------------------
if `"`data_arg'"'   != "" global DATA   `"`data_arg'"'
if `"`outdir_arg'"' != "" global OUTDIR `"`outdir_arg'"'
cd "$OUTDIR"
foreach d in figures tables logs {
    capture mkdir "`d'"
}
cap log close
log using "logs/02_event_time_support.log", replace text
timer clear 1
timer on 1
display _newline "=== [R2-02] STARTING: firms seen each year before and after their export start ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

* ---- the one choice made in this file ----
local minfirms 30      // a year since the start gets its own point in later charts only with 30+ firms

*---------------------------------------------------------------------------
display "Step 1/7: load export status, energy, CO2 and value added"
*---------------------------------------------------------------------------
* export_flag         = any export activity (1 yes, 0 no, missing = unknown)
* total_gj_s1         = energy use in GJ (nine fuels + purchased electricity)
* co2_total_s1        = CO2 tonnes from the same fuels and electricity
* value_added_nominal = value added, current prices (masked money unit)
use firm_id year export_flag total_gj_s1 co2_total_s1 value_added_nominal using "$DATA", clear
isid firm_id year
assert year != 2016
sort firm_id year
tsset firm_id year                 // L. and F. below mean exact calendar years

*---------------------------------------------------------------------------
display "Step 2/7: date each firm's export start under two rules (same code in every R2 file)"
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
local x export_flag
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

*---------------------------------------------------------------------------
display "Step 3/7: years since the start; choose the years shown one by one"
*---------------------------------------------------------------------------
* Years since the start = calendar year minus start year (0 = start year,
* -1 = the year before). Counted in calendar years, so a firm's 2016 is simply
* missing: no row, no count.
gen int kA = year - gA                                  // rule A (missing for non-starters)
gen int kB = year - gB                                  // rule B
* Usable row = energy, CO2 and value added all above zero, so the logs used in
* R2-03 to R2-05 exist. A zero is left out, not read as "none".
gen byte usable = total_gj_s1 > 0 & co2_total_s1 > 0 & value_added_nominal > 0 ///
    & !missing(total_gj_s1, co2_total_s1, value_added_nominal)
by firm_id: egen int n_usable = total(usable)           // a firm needs 2+ to be compared with itself
gen byte one = 1
tempfile fy tot totB est cells comp summ
save `fy'

* Totals by single year since the start (rule A).
keep if !missing(gA)
gen byte early = gA < 2016 & usable                     // started before the missing 2016 file
gen byte late  = gA > 2016 & usable                     // started after it
egen byte coh_tag = tag(gA kA) if usable
collapse (sum) firms = one usable_firms = usable exact_firms = exactA cohorts_seen = coh_tag ///
         (max) early_seen = early late_seen = late, by(kA)
* A year since the start gets its own point in the later charts when (1) at
* least `minfirms' firms have a usable row in it and (2) firms that started
* before AND after the missing 2016 file are both seen in it. Take the widest
* window -K..+K in which every year passes; years further out are grouped at
* the two ends (only early or only late starters reach them).
gen byte passes = usable_firms >= `minfirms' & early_seen & late_seen
assert passes if inlist(kA, -1, 0)
local K 0
local go 1
while `go' {
    local kk = `K' + 1
    quietly count if passes & inlist(kA, -`kk', `kk')
    if r(N) == 2 local K = `kk'
    else local go 0
}
local wlo = -`K'
local whi = `K'
local blo = `wlo' - 1                                   // column code of the lower grouped end
local bhi = `whi' + 1                                   // column code of the upper grouped end
display "   window: each year from `wlo' to +`whi' on its own; `blo' or earlier and +`bhi' or later grouped"
gen byte own_estimate = inrange(kA, `wlo', `whi')
gen str1 rule = "A"
rename kA event_time
save `tot'

* Totals by single year since the start (rule B).
use `fy', clear
keep if !missing(gB)
collapse (sum) firms = one usable_firms = usable, by(kB)
gen str1 rule = "B"
rename kB event_time
save `totB'

* The columns of panel A: each year in the window + the two grouped ends,
* by start year (cells) and for all starters (estimate rows), both rules.
* In a grouped end a firm is counted once, however many years it has there.
foreach r in A B {
    use `fy', clear
    keep if !missing(g`r')
    gen int col = cond(k`r' < `wlo', `blo', cond(k`r' > `whi', `bhi', k`r'))
    egen byte f_tag = tag(firm_id col)
    egen byte u_tag = tag(firm_id col) if usable
    preserve
    collapse (sum) firms = f_tag firm_years = one usable_firms = u_tag usable_firm_years = usable, by(col)
    gen str1 rule = "`r'"
    tempfile e`r'
    save `e`r''
    restore
    collapse (sum) firms = f_tag firm_years = one usable_firms = u_tag, by(g`r' col)
    fillin g`r' col
    rename g`r' cohort_year
    * A cell can hold firms only if its calendar year(s) lie inside 2010-2022.
    gen int calendar_year = cohort_year + col if inrange(col, `wlo', `whi')
    gen byte possible = inrange(calendar_year, 2010, 2022) & calendar_year != 2016 if inrange(col, `wlo', `whi')
    replace possible = (cohort_year + `blo' >= 2010) if col == `blo'
    replace possible = (cohort_year + `bhi' <= 2022) if col == `bhi'
    foreach v in firms firm_years usable_firms {
        replace `v' = 0 if missing(`v') & possible      // could be seen, none seen = genuine 0
        replace `v' = . if !possible                    // 2016 (no file) or outside 2010-2022: empty
    }
    drop if possible == 0 & calendar_year != 2016       // outside 2010-2022: no row
    gen str1 rule = "`r'"
    drop _fillin possible
    tempfile c`r'
    save `c`r''
}
use `eA', clear
append using `eB'
save `est'
use `cA', clear
append using `cB'
save `cells'
* Each firm has one start year, so the cells add up to the all-starters row.
collapse (sum) sumc = firms, by(rule col)
merge 1:1 rule col using `est', nogenerate assert(match)
assert sumc == firms
quietly summarize usable_firms if rule == "B"
local maxB = r(max)                                     // previous paper's rule: largest column

* Comparison firms (never seen exporting), by calendar year.
use `fy', clear
keep if keyA == 9001
gen byte seen_no = export_flag == 0
gen byte usable2 = usable & n_usable >= 2
collapse (sum) firms = one seen_not_exporting = seen_no usable_firms = usable usable_firms_2plus = usable2, by(year)
set obs `=_N + 1'
replace year = 2016 in L                                // empty row for the missing file
sort year
rename year calendar_year
save `comp'

*---------------------------------------------------------------------------
display "Step 4/7: key counts, then the CSV (numbers written before drawing)"
*---------------------------------------------------------------------------
use `fy', clear
egen byte ftag = tag(firm_id)
by firm_id: egen byte pre_u   = max(kA <  0 & usable & !missing(kA))
by firm_id: egen byte from_u  = max(kA >= 0 & usable & !missing(kA))
by firm_id: egen byte after1  = max(kA >= 1 & !missing(kA))
by firm_id: egen byte has_m1  = max(kA == -1 & usable)
by firm_id: egen byte pre_uB  = max(kB <  0 & usable & !missing(kB))
by firm_id: egen byte from_uB = max(kB >= 0 & usable & !missing(kB))
by firm_id: egen int  n_no    = total(export_flag == 0)
local labs `" "Starters, simple rule (all)" "Starters with a usable year before AND a usable year from the start year" "Starters seen at least one year after their start year" "Starters with a usable row the year just before the start" "Firms never seen exporting (comparison group)" "Comparison firms with 2+ usable years" "Comparison firms with 1 usable year (cannot be compared with themselves)" "Comparison firms with no usable year" "Comparison firms seen not exporting in 2+ years" "Starters, previous paper's rule (all)" "Starters, previous paper's rule, usable year before and from the start" "'
local i 0
foreach c in "!missing(gA)" "!missing(gA) & pre_u & from_u" "!missing(gA) & after1" ///
             "!missing(gA) & has_m1" "keyA == 9001" "keyA == 9001 & n_usable >= 2" ///
             "keyA == 9001 & n_usable == 1" "keyA == 9001 & n_usable == 0" ///
             "keyA == 9001 & n_no >= 2" "!missing(gB)" "!missing(gB) & pre_uB & from_uB" {
    local ++i
    quietly count if ftag & `c'
    local s`i' = r(N)
}
assert `s2' <= `s1' & `s3' <= `s1' & `s4' <= `s1' & `s11' <= `s10'
assert `s6' + `s7' + `s8' == `s5'
clear
set obs 12
gen int row_order = _n
gen str90 row_label = ""
gen double firms = .
forvalues j = 1/11 {
    local l : word `j' of `labs'
    replace row_label = "`l'" in `j'
    replace firms = `s`j'' in `j'
}
replace row_label = "Previous paper's rule: most usable firms in any one column" in 12
replace firms = `maxB' in 12
gen str12 section = "summary"
save `summ'

* Stack the sections into one long table (one row per number set).
use `summ', clear
append using `est'
replace section = "estimate" if missing(section)
append using `tot'
append using `totB'
replace section = "event_time" if missing(section)
append using `cells'
replace section = "cell" if missing(section)
append using `comp'
replace section = "comparison" if missing(section)
* Readable labels and the column code used in panel A.
replace event_time = col if inlist(section, "estimate", "cell")
gen str40 column = ""
replace column = cond(event_time > 0, "+", "") + string(event_time) if !missing(event_time)
replace column = "`blo' or earlier (grouped)" if inlist(section, "estimate", "cell") & event_time == `blo'
replace column = "+`bhi' or later (grouped)"  if inlist(section, "estimate", "cell") & event_time == `bhi'
replace row_label = "All starters" if inlist(section, "estimate", "event_time") & rule == "A"
replace row_label = "All starters, previous paper's rule" if inlist(section, "estimate", "event_time") & rule == "B"
replace row_label = "Started " + string(cohort_year) if section == "cell"
replace row_label = "Never seen exporting" if section == "comparison"
gen str70 note = ""
replace note = "No annual file" if calendar_year == 2016 & inlist(section, "cell", "comparison")
replace note = "Reference year: left out of the later estimates" if section == "estimate" & event_time == -1 & rule == "A"
replace note = "2022 file records direct exporters only: no firm is seen not exporting" if section == "comparison" & calendar_year == 2022
gen int window_first = `wlo'
gen int window_last  = `whi'
gen int min_firms    = `minfirms'
gen byte sorder = 1*(section=="summary") + 2*(section=="estimate") + 3*(section=="event_time") + 4*(section=="cell") + 5*(section=="comparison")
sort sorder rule cohort_year event_time calendar_year row_order
order section rule row_label cohort_year column event_time calendar_year firms firm_years usable_firms usable_firm_years ///
      exact_firms cohorts_seen early_seen late_seen own_estimate seen_not_exporting usable_firms_2plus ///
      window_first window_last min_firms note
keep section-note
format firms-min_firms %9.0f
export delimited using "tables/02_event_time_support.csv", datafmt replace
list rule row_label column firms firm_years usable_firms if inlist(section, "summary", "estimate"), noobs sep(0) abbreviate(24) clean
tempfile all
save `all'

*---------------------------------------------------------------------------
display "Step 5/7: numbers quoted in the notes (read from the table, never typed)"
*---------------------------------------------------------------------------
foreach j in 1 3 5 6 {
    local t : display %9.0fc `s`j''
    local n`j' = strtrim("`t'")
}

*---------------------------------------------------------------------------
display "Step 6/7: panel A = firms by start year x years since start; panel B = comparison firms"
*---------------------------------------------------------------------------
* ---- panel A: the counts drawn as a table ----
use `all', clear
keep if inlist(section, "cell", "estimate")
quietly levelsof cohort_year if section == "cell", local(cohorts)
local ncoh : word count `cohorts'
gen double row = .
local r 0
local ylab ""
foreach g of local cohorts {
    local ++r
    replace row = `r' if section == "cell" & cohort_year == `g'
    local ylab `"`ylab' `r' "`g'""'
}
local rA = `ncoh' + 1.3
local rB = `ncoh' + 2.3
replace row = `rA' if section == "estimate" & rule == "A"
replace row = `rB' if section == "estimate" & rule == "B"
drop if section == "cell" & rule == "B"                 // previous rule: all-starters row only
local ylab `"`ylab' `rA' "All starters" `rB' "Previous rule""'
gen str8 lbl = string(firms, "%9.0fc") if !missing(firms)
gen double lo = row - 0.42 if section == "cell" & calendar_year == 2016
gen double hi = row + 0.42 if section == "cell" & calendar_year == 2016
local xlab `"`blo' "≤ `blo'""'
forvalues k = `wlo'/`whi' {
    local s = cond(`k' > 0, "+`k'", "`k'")
    local xlab `"`xlab' `k' "`s'""'
}
local xlab `"`xlab' `bhi' "≥ +`bhi'""'
local xl = `wlo' - 0.5                                 // dashed edges of the year-by-year columns
local xr = `whi' + 0.5
local ytop = 0.55                                      // dashed lines start below the headers
local ybot = `rB' + 0.5
local ysep = `ncoh' + 0.65
twoway (rbar lo hi event_time, barwidth(0.92) fcolor(gs14) lcolor(gs14) lwidth(none)) ///
    (pci `ytop' `xl' `ybot' `xl' `ytop' `xr' `ybot' `xr', lpattern(dash) lcolor(gs7) lwidth(thin)) ///
    (pci `ysep' `=`blo'-0.5' `ysep' `=`bhi'+0.5', lcolor(gs11) lwidth(vthin)) ///
    (scatter row event_time if section == "cell", msymbol(none) mlabel(lbl) mlabposition(0) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter row event_time if section == "estimate" & rule == "A", msymbol(none) mlabel(lbl) mlabposition(0) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter row event_time if section == "estimate" & rule == "B", msymbol(none) mlabel(lbl) mlabposition(0) mlabsize(vsmall) mlabcolor(gs6)), ///
    yscale(reverse range(-0.4 `ybot') noline) ///
    ylabel(`ylab', angle(0) labsize(vsmall) noticks nogrid tlength(0) labgap(1)) ///
    ytitle("Year the firm started exporting", size(vsmall)) ///
    xscale(range(`=`blo'-0.5' `=`bhi'+0.5') noline) xlabel(`xlab', labsize(vsmall) noticks tlength(0) labgap(0.5)) ///
    xtitle("Years since the start (0 = start year; -1 = the year before)", size(vsmall)) ///
    text(-0.05 `blo' "Grouped", size(vsmall) color(gs5)) ///
    text(-0.05 0 "Each year shown separately in later charts", size(vsmall) color(gs5)) ///
    text(-0.05 `bhi' "Grouped", size(vsmall) color(gs5)) ///
    legend(order(1 "No annual file" 2 "Edge of the year-by-year columns") rows(1) position(6) ///
        region(lstyle(none)) size(vsmall) symysize(2) symxsize(4) keygap(1) colgap(4)) ///
    subtitle("A. Number of starters seen, by start year (rows) and years since the start (columns)", ///
        size(small) position(11) justification(left) nobox span) ///
    graphregion(color(white) lcolor(white)) plotregion(style(none) margin(zero)) ///
    fysize(64) name(pA, replace) nodraw

* ---- panel B: comparison firms by calendar year ----
use `all', clear
keep if section == "comparison"
gen double total = firms
gen double known = seen_not_exporting
gen double zero = 0
gen double known_mid = known / 2
quietly summarize total
local btop = 1.2 * r(max)                               // headroom for the count labels
gen double band_lo = 0 if calendar_year == 2016
gen double band_hi = `btop' if calendar_year == 2016
gen str8 total_lbl = string(total, "%9.0fc") if !missing(total)
gen str8 known_lbl = string(known, "%9.0fc") if known > 0 & !missing(known)
twoway (rbar band_lo band_hi calendar_year, barwidth(0.9) fcolor(gs14) lcolor(gs14) lwidth(none)) ///
    (rbar zero known calendar_year if !missing(total), barwidth(0.8) fcolor(gs4) lcolor(gs4) lwidth(vthin)) ///
    (rbar known total calendar_year if !missing(total), barwidth(0.8) fcolor(white) lcolor(gs4) lwidth(thin)) ///
    (scatter total calendar_year if total_lbl != "", msymbol(none) mlabel(total_lbl) mlabposition(12) mlabgap(0.4) ///
        mlabcolor(black) mlabsize(vsmall)) ///
    (scatter known_mid calendar_year if known_lbl != "", msymbol(none) mlabel(known_lbl) mlabposition(0) ///
        mlabcolor(white) mlabsize(vsmall)), ///
    xlabel(2010(1)2022, labsize(vsmall) noticks) xscale(range(2009.5 2022.5) lcolor(gs10)) ///
    yscale(off range(0 `btop')) ylabel(, nogrid) xtitle("") ///
    legend(order(2 "Seen not exporting that year" 3 "Export status not recorded that year" 1 "No annual file") rows(1) position(6) ///
        region(lstyle(none)) size(vsmall) symysize(2) symxsize(4) keygap(1) colgap(4)) ///
    subtitle("B. Number of comparison firms (never seen exporting in any year), by calendar year", ///
        size(small) position(11) justification(left) nobox) ///
    graphregion(color(white) lcolor(white)) plotregion(style(none) margin(t+1 b=0)) ///
    fysize(33) name(pB, replace) nodraw

graph combine pA pB, cols(1) iscale(1) imargin(0 0 1 1) ///
    title("Figure R2-02. Firms seen before and after they start exporting", size(medsmall) ///
        position(11) justification(left) span) ///
    note("Notes: Start year = first year a firm is seen exporting after a year seen not exporting. Later charts" ///
         "compare each starter's energy use and CO2 with its year before the start (-1), minus the change in panel B's" ///
         "firms. Between the dashed lines each column has `minfirms'+ firms with data, from starters before and after 2016;" ///
         "further out only early or only late starters are seen, so those years are pooled. Previous rule (last row," ///
         "previous paper): no exports in the two years before, exports again the year after; it never reaches `minfirms'. The" ///
         "2022 file records direct exporters only, hence no dark bar. `n6' of `n5' comparison firms have 2+ years" ///
         "with data (needed to see a change). Firm links are fictional: this tests the method, not a finding." ///
         "`srcnote'" "`devnote'", size(vsmall) span) ///
    graphregion(color(white) lcolor(white) margin(r+2)) xsize(9) ysize(10)

graph export "figures/02_event_time_support.png", width(2700) replace
graph export "figures/02_event_time_support.pdf", replace

*---------------------------------------------------------------------------
display "Step 7/7: companion table: every plotted point"
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
* Source: `all' = the table just written to the CSV (same numbers as drawn).
* One row per drawn number, in chart order: panel A row by row (start years top
* to bottom, then All starters and Previous rule), left to right; then panel B,
* series by series, left to right. Cells with no annual file are included.
* -- panel A: the grid of counts --
use `all', clear
keep if (section == "cell" & rule == "A") | section == "estimate"
gen byte ord = cond(section == "cell", 1, cond(rule == "A", 2, 3))
sort ord cohort_year event_time
gen str40 t_panel = "A. Starters"
gen str60 t_row = "Started " + string(cohort_year) if ord == 1
replace t_row = "All starters" if ord == 2
replace t_row = "Previous rule" if ord == 3
gen str16 t_pos = cond(event_time > 0, "+", "") + string(event_time)
replace t_pos = "≤ `blo'"  if event_time == `blo'
replace t_pos = "≥ +`bhi'" if event_time == `bhi'
gen str8  t_cal = string(calendar_year) if !missing(calendar_year)
gen str12 t_v   = string(firms, "%9.0fc") if !missing(firms)        // as the chart label
gen str12 t_fy  = string(firm_years, "%12.0fc") if !missing(firms)
gen str90 t_status = "drawn"
replace t_status = "drawn: grouped end" if inlist(event_time, `blo', `bhi')
replace t_status = subinstr(t_status, "drawn", "drawn gray", 1) if ord == 3
replace t_status = "not drawn: no annual file" if missing(firms) & calendar_year == 2016
assert !missing(firms) if !(calendar_year == 2016 & section == "cell")
local nA = _N
* thin rules under each start year's last cell and under the two summary rows
local rl ""
forvalues i = 1/`=_N - 1' {
    if t_row[`i'] != t_row[`i' + 1] local rl `rl' `i'
}
keep t_*
tempfile ctA
save `ctA'
* -- panel B: comparison firms by calendar year (three parts of each bar) --
use `all', clear
keep if section == "comparison"
sort calendar_year
local nyB = _N
expand 3
bysort calendar_year: gen byte series = _n       // 1 = dark part, 2 = white part, 3 = total (on top)
sort series calendar_year
gen str40 t_panel = "B. Comparison"
gen str60 t_row = cond(series == 1, "Dark: not exporting", ///
                  cond(series == 2, "White: not recorded", "All comparison firms"))
gen str16 t_pos = ""
gen str8  t_cal = string(calendar_year)
gen double v = cond(series == 1, seen_not_exporting, cond(series == 2, firms - seen_not_exporting, firms))
gen str12 t_v  = string(v, "%9.0fc") if !missing(v)
gen str12 t_fy = ""
gen str90 t_status = cond(series == 1, "drawn: inside the bar", cond(series == 2, "drawn: no number", ///
                     "drawn: on top of the bar"))
replace t_status = "not drawn: 0 (see notes)" if series == 1 & v == 0
replace t_status = "not drawn: no annual file" if calendar_year == 2016
assert missing(v) == (calendar_year == 2016)
keep t_*
local nB = _N
append using `ctA'
gen byte pp = cond(t_panel == "A. Starters", 1, 2)
gen long n0 = _n
sort pp n0                                          // panel A first, then panel B, each in its order
drop pp n0
assert _N == `nA' + 3 * `nyB'
* chart's notes word for word; then how to read the table
local ntext "Notes: Start year = first year a firm is seen exporting after a year seen not exporting. Later charts"
local ntext "`ntext' compare each starter's energy use and CO2 with its year before the start (-1), minus the change in panel B's"
local ntext "`ntext' firms. Between the dashed lines each column has `minfirms'+ firms with data, from starters before and after 2016;"
local ntext "`ntext' further out only early or only late starters are seen, so those years are pooled. Previous rule (last row,"
local ntext "`ntext' previous paper): no exports in the two years before, exports again the year after; it never reaches `minfirms'. The"
local ntext "`ntext' 2022 file records direct exporters only, hence no dark bar. `n6' of `n5' comparison firms have 2+ years"
local ntext "`ntext' with data (needed to see a change). Firm links are fictional: this tests the method, not a finding."
local tnote "Table: every number of Figure R2-02 in chart order, with the cells and years not drawn and why. Panel A: firms seen"
local tnote "`tnote' (the number in each cell) and all their rows (firm-years; in a grouped end a firm counts once but all its years"
local tnote "`tnote' are rows); gray = the previous rule's row; no annual file = gray cell or band. Panel B: the dark and white parts of each bar and the total on top; 2022 has no dark part because that file records direct exporters only. Full precision, the firms with usable data and the"
local tnote "`tnote' previous rule by start year: tables/02_event_time_support.csv."
local rB1 = `nA' + `nyB'
local rB2 = `nA' + 2 * `nyB'
ctable_pdf t_panel t_row t_pos t_cal t_v t_fy t_status using "tables/02_event_time_support_table.pdf", ///
    title("Table R2-02. Firms seen before and after they start exporting: every plotted point") ///
    header("Panel" "Row / series" "Years since|the start" "Calendar|year" "Firms|(drawn)" "Firm-years" "Status") ///
    right(3 4 5 6) norepeat(1 2) rules(`rl' `nA' `rB1' `rB2') portrait fontsize(9) perpage(46) ///
    notes("`ntext'" "`tnote'" "`srcnote'" "`devnote'")
display "table -> tables/02_event_time_support_table.pdf"
* --- end of PART 2 ------------------------------------------------------------


timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/02_event_time_support.png (elapsed `elapsed' s)"
quietly log close
