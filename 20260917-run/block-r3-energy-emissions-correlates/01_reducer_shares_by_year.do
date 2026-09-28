/*==========================================================================
  R3-01  In each year, what share of firms used less energy / emitted less
         CO2 than in the year before - as amounts and per unit of value added?
         Also defines the firm-level "reducer" flag used in R3-02 to R3-07
         (main flag: year-adjusted, energy per unit of value added).
  Answers Deasy R3: "Siapa yang reduce energy use and emisi?"
  Output : figures/01_reducer_shares_by_year.png (+ .pdf)
           tables/01_reducer_shares_by_year.csv  (per year)
           tables/01_reducer_firms.csv           (firm-level reducer counts)
           tables/01_reducer_shares_by_year_table.pdf (every plotted point)
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
global OUTDIR "/Users/natanaelmassie/Downloads/2026-kolega-den-bps-repo/20260917-run/block-r3-energy-emissions-correlates"
* ---------------------------------------------------------------------------
if `"`data_arg'"'   != "" global DATA   `"`data_arg'"'
if `"`outdir_arg'"' != "" global OUTDIR `"`outdir_arg'"'
cd "$OUTDIR"
foreach d in figures tables logs {
    capture mkdir "`d'"
}
cap log close
log using "logs/01_reducer_shares_by_year.log", replace text
timer clear 1
timer on 1
display _newline "=== [R3-01] STARTING: share of firms whose energy use and CO2 fell from the previous year ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

*---------------------------------------------------------------------------
display "Step 1/7: load the variables we need"
*---------------------------------------------------------------------------
* total_gj_s1  = energy use in GJ (nine fuels + purchased electricity; partial scope)
* co2_total_s1 = CO2 in tonnes from the same fuels and electricity
* value_added_nominal = value added, current prices (masked money unit)
use firm_id year total_gj_s1 co2_total_s1 value_added_nominal using "$DATA", clear
isid firm_id year
xtset firm_id year

*---------------------------------------------------------------------------
display "Step 2/7: pair each firm-year with the same firm exactly one year earlier"
*---------------------------------------------------------------------------
* L. means "the same firm, previous calendar year". There is no 2016 file, so
* every 2017 row has no previous year: the 2015->2017 change covers two years
* and is left out on purpose.
gen double energy    = total_gj_s1
gen double co2       = co2_total_s1
gen double energy_va = total_gj_s1  / value_added_nominal
gen double co2_va    = co2_total_s1 / value_added_nominal

gen byte pair1 = !missing(L.total_gj_s1)                        // firm is in last year's file
gen byte link2 = (year == 2017) & !missing(L2.total_gj_s1)      // firm seen in 2015 and 2017 (not used)

* Compared pair: energy, CO2 and value added above zero in BOTH years.
* A zero is dropped, not read as "no energy": these fields cover only the
* fuels asked about, and a zero may be an unanswered question.
gen byte cmp = pair1 & total_gj_s1>0 & L.total_gj_s1>0 & co2_total_s1>0 & L.co2_total_s1>0 ///
               & value_added_nominal>0 & L.value_added_nominal>0

*---------------------------------------------------------------------------
display "Step 3/7: mark reductions (value lower than the year before)"
*---------------------------------------------------------------------------
foreach v in energy co2 energy_va co2_va {
    gen byte down_`v'  = (`v' < L.`v') if cmp                        // main rule: any fall
    gen byte down5_`v' = (ln(`v') - ln(L.`v') < ln(0.95)) if cmp     // check: fell by more than 5%
    quietly count if cmp & `v' == L.`v'
    display "   exact ties (unchanged) for `v': " r(N)
}
assert pair1 == 0 if year == 2017         // no 2016 file, so no one-year pair ends in 2017

*---------------------------------------------------------------------------
display "Step 4/7: firm-level reducer flag (used by R3-02 to R3-07)"
*---------------------------------------------------------------------------
* A firm is a "reducer" when the average of its year-on-year log changes is
* below zero. Needs at least 2 compared changes; firms with 0 or 1 change stay
* unclassified (missing), never counted as non-reducers.
* MAIN flag for R3-02 to R3-07 = reducer_adj_energy_va (year-adjusted, energy
* per unit of value added). The raw flag (reducer_*) is kept for comparison:
* it mostly records WHICH years a firm is observed, because the masked data
* jump and fall back between years.
preserve
foreach v in energy co2 energy_va co2_va {
    gen double chg_`v' = ln(`v') - ln(L.`v') if cmp
}
foreach v in energy co2 energy_va co2_va {
    * Year-adjusted: this firm's change minus the typical (median) change of all
    * compared firms in the same year, so the years a firm happens to be
    * observed in do not decide whether it is a reducer.
    bysort year: egen double med_chg_`v' = pctile(chg_`v'), p(50)   // median; egen median() would ignore "double"
    gen double rel_chg_`v' = chg_`v' - med_chg_`v'
    bysort firm_id: egen int    n_chg_`v'   = count(chg_`v')
    bysort firm_id: egen double avg_chg_`v' = mean(chg_`v')
    bysort firm_id: egen double avg_rel_`v' = mean(rel_chg_`v')
    gen byte reducer_`v'     = (avg_chg_`v' < 0) if n_chg_`v' >= 2
    gen byte reducer_adj_`v' = (avg_rel_`v' < 0) if n_chg_`v' >= 2
}
bysort firm_id: keep if _n == 1
tempfile firmfile
tempname firmtab
postfile `firmtab' str10 outcome byte main_flag long(firms_total firms_0_changes firms_1_change ///
    firms_classified reducer_firms nonreducer_firms) double pct_reducer_firms ///
    long reducer_adj_firms double pct_reducer_adj_firms using `firmfile', replace
foreach v in energy co2 energy_va co2_va {
    quietly count
    local nt = r(N)
    quietly count if n_chg_`v' == 0
    local n0 = r(N)
    quietly count if n_chg_`v' == 1
    local n1 = r(N)
    quietly count if !missing(reducer_`v')
    local nc = r(N)
    quietly count if reducer_`v' == 1
    local nr = r(N)
    quietly count if reducer_adj_`v' == 1
    local na = r(N)
    post `firmtab' ("`v'") (("`v'" == "energy_va")) (`nt') (`n0') (`n1') (`nc') (`nr') (`nc' - `nr') (100 * `nr' / `nc') ///
        (`na') (100 * `na' / `nc')
}
postclose `firmtab'
restore

*---------------------------------------------------------------------------
display "Step 5/7: yearly shares -> CSV (numbers written before drawing)"
*---------------------------------------------------------------------------
* Pooled shares over all years, for the firm table.
foreach v in energy co2 energy_va co2_va {
    quietly summarize down_`v'
    local pool_n_`v'   = r(N)
    local pool_pct_`v' = 100 * r(mean)
}
collapse (count) firms_in_year = firm_id ///
         (sum) one_year_pairs = pair1 two_year_links = link2 pairs_compared = cmp ///
               n_down_energy = down_energy n_down_co2 = down_co2 ///
               n_down_energy_va = down_energy_va n_down_co2_va = down_co2_va ///
         (mean) pct_down5_energy = down5_energy pct_down5_co2 = down5_co2 ///
                pct_down5_energy_va = down5_energy_va pct_down5_co2_va = down5_co2_va, by(year)
gen long pairs_dropped_zero = one_year_pairs - pairs_compared
foreach v in energy co2 energy_va co2_va {
    gen double pct_down_`v' = 100 * n_down_`v' / pairs_compared if pairs_compared > 0
    replace n_down_`v' = . if pairs_compared == 0      // no pairs: blank, not "0 reductions"
    replace pct_down5_`v'   = 100 * pct_down5_`v'
}
assert one_year_pairs == 0 if inlist(year, 2010, 2017)
* Numbers quoted in the figure notes are read from the data, never typed.
quietly summarize pairs_compared
local n_cmp : display %9.0fc r(sum)
quietly summarize two_year_links
local n_link2 : display %9.0fc r(sum)
gen double gap5 = max(pct_down_energy - pct_down5_energy, pct_down_co2 - pct_down5_co2, ///
                      pct_down_energy_va - pct_down5_energy_va, pct_down_co2_va - pct_down5_co2_va)
quietly summarize gap5
local gap5 : display %3.1f r(max)
drop gap5
local n_cmp   = strtrim("`n_cmp'")
local n_link2 = strtrim("`n_link2'")

* 2016: an explicit empty row (no annual file), never a zero.
gen byte annual_file = 1
set obs `=_N + 1'
replace year = 2016 in L
replace annual_file = 0 in L
sort year
order year annual_file firms_in_year one_year_pairs two_year_links pairs_dropped_zero pairs_compared ///
      n_down_energy pct_down_energy n_down_co2 pct_down_co2 n_down_energy_va pct_down_energy_va ///
      n_down_co2_va pct_down_co2_va pct_down5_energy pct_down5_co2 pct_down5_energy_va pct_down5_co2_va
format firms_in_year one_year_pairs two_year_links pairs_dropped_zero pairs_compared n_down_* %9.0f
format pct_* %6.2f
export delimited using "tables/01_reducer_shares_by_year.csv", datafmt replace
tempfile ctsrc                     // same numbers, full precision, for the companion table (Step 7)
quietly save `ctsrc'
list year pairs_compared pct_down_energy pct_down_co2 pct_down_energy_va pct_down_co2_va, noobs sep(0) abbreviate(20)

* Firm-level table (with pooled pair shares) -> CSV
preserve
use `firmfile', clear
gen long   pairs_pooled = .
gen double pct_pairs_down_pooled = .
foreach v in energy co2 energy_va co2_va {
    replace pairs_pooled          = `pool_n_`v''   if outcome == "`v'"
    replace pct_pairs_down_pooled = `pool_pct_`v'' if outcome == "`v'"
}
format pct_* %6.2f
export delimited using "tables/01_reducer_firms.csv", datafmt replace
list, noobs sep(0) abbreviate(24)
restore

*---------------------------------------------------------------------------
display "Step 6/7: draw two small multiples (energy, CO2) on one shared 0-100 scale"
*---------------------------------------------------------------------------
keep year pairs_compared pct_down_energy pct_down_co2 pct_down_energy_va pct_down_co2_va
expand 2
bysort year: gen byte panel = _n
gen double amt = cond(panel == 1, pct_down_energy,    pct_down_co2)      // amount
gen double pva = cond(panel == 1, pct_down_energy_va, pct_down_co2_va)   // per unit of value added
label define panel 1 "(a) Energy use (gigajoules)" 2 "(b) CO2 emissions (tonnes)"
label values panel panel

* Endpoint labels: first and last year with data, higher line labelled above.
bysort panel: egen fy = min(cond(!missing(amt), year, .))
bysort panel: egen ly = max(cond(!missing(amt), year, .))
gen byte endpt = inlist(year, fy, ly)
gen str20 lab_amt = "Total " + string(amt, "%4.1f") if endpt
gen str20 lab_pva = "Per VA " + string(pva, "%4.1f") if endpt
gen byte pos_amt = cond(year == fy, cond(amt >= pva, 10, 8), cond(amt >= pva, 2, 4)) if endpt
gen byte pos_pva = cond(year == fy, cond(pva >  amt, 10, 8), cond(pva >  amt, 2, 4)) if endpt

gen double band = 100 if year == 2016                                    // "No annual file" band
gen double ytxt = 92      if year == 2016 & panel == 1
gen double xtxt = 2016.55 if year == 2016 & panel == 1
gen str45 txt = "2017: no one-year change (no 2016 file)" if year == 2016 & panel == 1

* x-axis labels: year, and under it the number of firm pairs compared.
local xl ""
forvalues y = 2010/2022 {
    quietly summarize pairs_compared if year == `y' & panel == 1
    if `y' == 2016 {
        local xl `"`xl' 2016 `""2016" " ""'"'
    }
    else {
        local nstr : display %9.0fc r(mean)
        local nstr = strtrim("`nstr'")
        local xl `"`xl' `y' `""`y'" "`nstr'""'"'
    }
}
sort panel year

twoway (bar band year, barwidth(0.9) color(gs14) lwidth(none) base(0)) ///
    (connected amt year, lcolor(black) lpattern(solid) lwidth(medthin) msymbol(O) mcolor(black) ///
        msize(small) cmissing(n) mlabel(lab_amt) mlabvposition(pos_amt) mlabsize(vsmall) mlabcolor(black)) ///
    (connected pva year, lcolor(gs5) lpattern(dash) lwidth(medthin) msymbol(Sh) mcolor(gs5) ///
        msize(small) cmissing(n) mlabel(lab_pva) mlabvposition(pos_pva) mlabsize(vsmall) mlabcolor(gs5)) ///
    (scatter ytxt xtxt, msymbol(none) mlabel(txt) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(gs6)), ///
    by(panel, cols(1) graphregion(color(white) lcolor(white) ilcolor(white)) legend(pos(6)) ///
        title("Figure R3-01. Share of firms whose energy use and CO2 fell from the previous year", ///
              size(small) pos(11) span) ///
        note("Notes: Each point = share of firms below their own level one year earlier; at 50%, as many fell as rose." ///
             "Only firms present in both years, with energy and CO2 above zero in both, are compared: the same `n_cmp'" ///
             "firm pairs in all four lines. Value added = output value minus materials, energy and services bought, in" ///
             "current prices; price rises alone push the per-value-added share up. Fictional firm links and masked" ///
             "values: levels and year-to-year jumps are not findings." ///
             "`srcnote'" "`devnote'", size(vsmall) span)) ///
    subtitle(, pos(11) nobox fcolor(white) lcolor(white) size(small)) ///
    ytitle("Firms lower than the year before (%)", size(vsmall)) ///
    ylabel(0(25)100, angle(0) noticks tlength(0) grid glcolor(gs15) glwidth(vthin) labsize(vsmall)) ///
    yscale(noline range(0 100)) ///
    xlabel(`xl', noticks tlength(0) labsize(vsmall)) xscale(range(2008.6 2023.8) lcolor(gs10)) ///
    xtitle("Year (number underneath: firm pairs compared)", size(vsmall)) ///
    legend(order(2 "Total" 3 "Per unit of value added (VA)" 1 "No annual file") ///
        rows(1) region(lcolor(none)) size(vsmall) symxsize(8) keygap(1) colgap(6)) ///
    plotregion(style(none)) xsize(6.5) ysize(7.5)

graph export "figures/01_reducer_shares_by_year.png", width(1950) replace
graph export "figures/01_reducer_shares_by_year.pdf", replace


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
* Source: the yearly table saved right after the CSV export (full precision,
* same run as the chart). One row per point, in chart order: panel (a) Total
* then Per VA, panel (b) the same; every year of the axis, so the years not
* drawn appear with the reason.
use `ctsrc', clear
sort year
local ny = _N
quietly count if pairs_compared > 0 & !missing(pairs_compared)
local ndrawn = r(N)
expand 4
bysort year: gen byte series = _n       // 1-2 = panel (a) Total, Per VA; 3-4 = panel (b)
sort series year
* panel and line names exactly as on the chart
gen str40 t_panel  = cond(series <= 2, "(a) Energy use (gigajoules)", "(b) CO2 emissions (tonnes)")
gen str40 t_series = cond(inlist(series, 1, 3), "Total", "Per unit of value added (VA)")
gen str8  t_year   = string(year)
* the plotted share and the firm counts behind it
gen double v  = cond(series == 1, pct_down_energy, cond(series == 2, pct_down_energy_va, ///
                cond(series == 3, pct_down_co2, pct_down_co2_va)))
gen double nd = cond(series == 1, n_down_energy, cond(series == 2, n_down_energy_va, ///
                cond(series == 3, n_down_co2, n_down_co2_va)))
* rounding as the chart labels (one decimal)
gen str12 t_v  = string(v, "%9.1f") if !missing(v)
gen str12 t_nd = string(nd, "%12.0fc") if !missing(nd)
gen str12 t_np = string(pairs_compared, "%12.0fc") if annual_file == 1
* status: how (and whether) the point is drawn; first and last year carry a label
bysort series: egen int fy = min(cond(!missing(v), year, .))
bysort series: egen int ly = max(cond(!missing(v), year, .))
sort series year
gen str70 t_status = "drawn"
replace t_status = "drawn, labelled (first year with data)" if year == fy
replace t_status = "drawn, labelled (last year)" if year == ly
replace t_status = "not drawn: no firm pairs compared" if missing(v)
replace t_status = "not drawn: first year, no earlier file" if missing(v) & year == 2010
replace t_status = "not drawn: no one-year change (no 2016 file)" if missing(v) & year == 2017
replace t_status = "not drawn: no annual file (gray band)" if annual_file == 0
* checks: every drawn point is one row with a number; one row per line and axis year
quietly count if !strpos(t_status, "not drawn")
assert r(N) == 4 * `ndrawn'
assert t_v != "" & t_nd != "" & t_np != "" if !strpos(t_status, "not drawn")
assert _N == 4 * `ny'
* notes: the chart's notes, how to read the table, Source, development-data line
local ntext "Notes: Each point = share of firms below their own level one year earlier; at 50%, as many fell as rose."
local ntext "`ntext' Only firms present in both years, with energy and CO2 above zero in both, are compared: the same `n_cmp'"
local ntext "`ntext' firm pairs in all four lines. Value added = output value minus materials, energy and services bought, in"
local ntext "`ntext' current prices; price rises alone push the per-value-added share up. Fictional firm links and masked"
local ntext "`ntext' values: levels and year-to-year jumps are not findings."
local tnote "Table: every point of Figure R3-01 in chart order, with the years not drawn and why. Plotted value = 100 ×"
local tnote "`tnote' Firms lower (than the year before) / Pairs compared, to one decimal. Full precision: tables/01_reducer_shares_by_year.csv."
ctable_pdf t_panel t_series t_year t_v t_nd t_np t_status using "tables/01_reducer_shares_by_year_table.pdf", ///
    title("Table R3-01. Share of firms whose energy use and CO2 fell from the previous year: every plotted point") ///
    header("Panel" "Series" "Year" "Plotted|value (%)" "Firms|lower" "Pairs|compared" "Status") ///
    right(3 4 5 6) norepeat(1 2) fontsize(9) rules(`ny' `=2*`ny'' `=3*`ny'') perpage(`=2*`ny'') ///
    notes("`ntext'" "`tnote'" "`srcnote'" "`devnote'")
display "table -> tables/01_reducer_shares_by_year_table.pdf"
* --- end of PART 2 ------------------------------------------------------------

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/01_reducer_shares_by_year.png (elapsed `elapsed' s)"
quietly log close
