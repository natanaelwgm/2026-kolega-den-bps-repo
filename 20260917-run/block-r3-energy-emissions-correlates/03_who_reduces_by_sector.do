/*==========================================================================
  R3-03  In which manufacturing sectors did energy use and CO2 (per unit of
         value added, and in total) fall more often than at the typical firm
         that year?
  Answers Deasy R3: "Siapa yang reduce energy use and emisi? ... determinan
         motivasi ..." - "Bukan kausal, tp mengetahui firms mana yg respond"
         (this shows WHICH sectors, not WHY). Same chart form as R3-02.
  Output : figures/03_who_reduces_by_sector.png (+ .pdf)
           tables/03_who_reduces_by_sector.csv            (one-year changes, main unit)
           tables/03_who_reduces_by_sector_firm_flag.csv  (firm-level reducer flag, companion)
           tables/03_who_reduces_by_sector_table.pdf (every plotted point)
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
log using "logs/03_who_reduces_by_sector.log", replace text
timer clear 1
timer on 1
display _newline "=== [R3-03] STARTING: which sectors cut energy and CO2 more often than the typical firm ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."
local minchg 100                 // a sector is drawn only with at least this many one-year changes

*---------------------------------------------------------------------------
display "Step 1/8: load; sector code as a number; each sector's share of all energy and CO2 (table only)"
*---------------------------------------------------------------------------
* industry2_reported = first two digits of the reported industry code (24 manufacturing
* sectors, 10-33); whether codes are consistent across years is not verified.
use firm_id year industry2_reported total_gj_s1 co2_total_s1 value_added_nominal using "$DATA", clear
isid firm_id year
gen int sector = real(industry2_reported)
quietly count if missing(sector)
display "   rows with no readable sector code: " r(N)
replace sector = 99 if missing(sector)
preserve
collapse (sum) gj = total_gj_s1 tco2 = co2_total_s1 (count) rows = firm_id, by(sector)
quietly summarize gj
gen double pct_all_energy = 100 * gj / r(sum)
quietly summarize tco2
gen double pct_all_co2 = 100 * tco2 / r(sum)
keep sector rows pct_all_energy pct_all_co2
tempfile shares
save `shares'
restore
* Largest single firm-year share of that year's energy: on masked data one row can dominate
* a year, so the sector shares of energy are a rough reading aid only (logged, not drawn).
preserve
bysort year: egen double tot = total(total_gj_s1)
gen double sh1 = 100 * total_gj_s1 / tot
collapse (max) top_row_pct = sh1, by(year)
list, noobs sep(0) abbreviate(24)
restore
xtset firm_id year

*---------------------------------------------------------------------------
display "Step 2/8: one-year changes, as in R3-01 (same code)"
*---------------------------------------------------------------------------
gen double energy    = total_gj_s1
gen double co2       = co2_total_s1
gen double energy_va = total_gj_s1  / value_added_nominal
gen double co2_va    = co2_total_s1 / value_added_nominal
gen byte pair1 = !missing(L.total_gj_s1)                        // firm is in last year's file
gen byte cmp = pair1 & total_gj_s1>0 & L.total_gj_s1>0 & co2_total_s1>0 & L.co2_total_s1>0 ///
               & value_added_nominal>0 & L.value_added_nominal>0
assert pair1 == 0 if year == 2017                               // no 2016 file
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
xtset firm_id year                // the bysort calls above changed the sort order

*---------------------------------------------------------------------------
display "Step 3/8: did each change beat the typical firm? sector at the start of each change"
*---------------------------------------------------------------------------
* beat = the change was below the typical (median) change that year: it fell more or rose less.
foreach v in energy_va co2_va energy co2 {
    gen byte beat_`v' = (rel_chg_`v' < 0) if cmp
    quietly count if cmp & rel_chg_`v' == 0
    display "   `v': changes exactly at the typical change (counted as not beating it) = " r(N)
}
quietly summarize beat_energy_va
assert inrange(r(mean), 0.49, 0.51)            // about half beat the median by construction
gen int g_sec = L.sector if cmp                 // sector in the first year of the change
quietly count if cmp & g_sec != sector
display "   changes whose two-digit sector differs between the two years: " r(N)
quietly count if cmp
local n_cmp_num = r(N)
local n_cmp = strtrim(string(r(N), "%9.0fc"))
assert !missing(g_sec) if cmp

*---------------------------------------------------------------------------
display "Step 4/8: share per sector with 95% intervals (clustered by firm)"
*---------------------------------------------------------------------------
* The interval allows for the same firm appearing in several years.
tempname P
tempfile rows
postfile `P' int sector long(changes firms) ///
    double(pct_energy_va lo_energy_va hi_energy_va pct_co2_va lo_co2_va hi_co2_va ///
           pct_energy lo_energy hi_energy pct_co2 lo_co2 hi_co2 pct_energy_va_early) ///
    long changes_early double pct_energy_va_late long changes_late using `rows', replace
quietly levelsof g_sec if cmp, local(ss)
foreach s of local ss {
    local vals ""
    foreach v in energy_va co2_va energy co2 {
        quietly mean beat_`v' if cmp & g_sec == `s', vce(cluster firm_id)
        matrix T = r(table)
        local p  = 100 * T[1,1]
        local lo = 100 * T[5,1]
        local hi = 100 * T[6,1]
        local nn = e(N)
        local nf = e(N_clust)
        local vals `vals' (`p') (`lo') (`hi')
    }
    quietly summarize beat_energy_va if cmp & g_sec == `s' & year < 2016
    local pe = 100 * r(mean)
    local ne = r(N)
    quietly summarize beat_energy_va if cmp & g_sec == `s' & year > 2016
    local pl = 100 * r(mean)
    local nl = r(N)
    post `P' (`s') (`nn') (`nf') `vals' (`pe') (`ne') (`pl') (`nl')
}
postclose `P'
foreach v in energy_va energy co2 co2_va {
    quietly regress beat_`v' i.g_sec if cmp, vce(cluster firm_id)
    quietly testparm i.g_sec
    display "   `v': do sectors differ at all? F(" r(df) ", " r(df_r) ") = " %6.2f r(F) ", p = " %6.4f r(p)
}

*---------------------------------------------------------------------------
display "Step 5/8: firm-level companion (the R3 reducer flag), sector at each firm's first change"
*---------------------------------------------------------------------------
preserve
bysort firm_id: egen int first_cmp = min(cond(cmp, year, .))
bysort firm_id: egen int f_sec = max(cond(year == first_cmp, g_sec, .))
bysort firm_id: keep if _n == 1
keep if !missing(reducer_adj_energy_va)         // firms with at least two changes
tempname F
tempfile firmrows
postfile `F' int sector long(firms changes reducer_adj_firms) double(pct_reducer_adj lo hi) using `firmrows', replace
quietly levelsof f_sec, local(fs)
foreach s of local fs {
    quietly count if f_sec == `s' & reducer_adj_energy_va == 1
    local nr = r(N)
    quietly summarize n_chg_energy_va if f_sec == `s'
    local nch = r(sum)
    local nf  = r(N)
    if `nf' >= 2 {
        quietly ci proportions reducer_adj_energy_va if f_sec == `s', wilson
        post `F' (`s') (`nf') (`nch') (`nr') (100 * r(proportion)) (100 * r(lb)) (100 * r(ub))
    }
    else post `F' (`s') (`nf') (`nch') (`nr') (100 * `nr' / `nf') (.) (.)
}
postclose `F'
restore

*---------------------------------------------------------------------------
display "Step 6/8: names, drawing rule, order -> CSVs (numbers written before drawing)"
*---------------------------------------------------------------------------
use `rows', clear
merge 1:1 sector using `shares', nogen
replace changes = 0 if missing(changes)
replace firms = 0 if missing(firms)
label define secname 10 "Food products" 11 "Beverages" 12 "Tobacco" 13 "Textiles" 14 "Clothing" ///
    15 "Leather and footwear" 16 "Wood products" 17 "Paper" 18 "Printing" 19 "Refined petroleum, coke" ///
    20 "Chemicals" 21 "Medicines" 22 "Rubber and plastics" 23 "Cement, glass, ceramics" ///
    24 "Steel and other metals" 25 "Metal products" 26 "Computers, electronics" 27 "Electrical equipment" ///
    28 "Machinery" 29 "Motor vehicles" 30 "Motorcycles, other vehicles" 31 "Furniture" 32 "Other manufacturing" ///
    33 "Machine repair" 99 "Not recorded"
label values sector secname
decode sector, gen(sector_name)
gen str100 isic4_title = ""
local t10 "Food products"
local t11 "Beverages"
local t12 "Tobacco products"
local t13 "Textiles"
local t14 "Wearing apparel"
local t15 "Leather and related products"
local t16 "Wood and products of wood and cork, except furniture; articles of straw and plaiting materials"
local t17 "Paper and paper products"
local t18 "Printing and reproduction of recorded media"
local t19 "Coke and refined petroleum products"
local t20 "Chemicals and chemical products"
local t21 "Pharmaceuticals, medicinal chemical and botanical products"
local t22 "Rubber and plastics products"
local t23 "Other non-metallic mineral products"
local t24 "Basic metals"
local t25 "Fabricated metal products, except machinery and equipment"
local t26 "Computer, electronic and optical products"
local t27 "Electrical equipment"
local t28 "Machinery and equipment n.e.c."
local t29 "Motor vehicles, trailers and semi-trailers"
local t30 "Other transport equipment"
local t31 "Furniture"
local t32 "Other manufacturing"
local t33 "Repair and installation of machinery and equipment"
forvalues c = 10/33 {
    replace isic4_title = "`t`c''" if sector == `c'
}
replace sector_name = "Code " + string(sector) if sector_name == ""
label values sector
gen byte in_figure = changes >= `minchg'        // too few changes: kept in the table, named under the plot
quietly summarize changes
assert r(sum) == `n_cmp_num'                    // every change sits in exactly one sector
assert lo_energy_va <= pct_energy_va & pct_energy_va <= hi_energy_va if firms >= 2
gsort -in_figure -pct_energy_va sector
gen int row_order = _n
order row_order in_figure sector sector_name isic4_title changes firms rows pct_all_energy pct_all_co2
format pct_* lo_* hi_* %6.2f
export delimited using "tables/03_who_reduces_by_sector.csv", datafmt replace
tempfile ctsrc                     // same numbers, full precision, for the companion table (Step 8)
quietly save `ctsrc'
list row_order sector sector_name changes firms pct_all_energy pct_energy_va lo_energy_va hi_energy_va pct_energy pct_co2, noobs sep(0) abbreviate(24)

preserve
use `firmrows', clear
merge 1:1 sector using `shares', keepusing(sector) nogen keep(match)
label define secname2 10 "Food products" 11 "Beverages" 12 "Tobacco" 13 "Textiles" 14 "Clothing" ///
    15 "Leather and footwear" 16 "Wood products" 17 "Paper" 18 "Printing" 19 "Refined petroleum, coke" ///
    20 "Chemicals" 21 "Medicines" 22 "Rubber and plastics" 23 "Cement, glass, ceramics" ///
    24 "Steel and other metals" 25 "Metal products" 26 "Computers, electronics" 27 "Electrical equipment" ///
    28 "Machinery" 29 "Motor vehicles" 30 "Motorcycles, other vehicles" 31 "Furniture" 32 "Other manufacturing" ///
    33 "Machine repair" 99 "Not recorded"
label values sector secname2
decode sector, gen(sector_name)
replace sector_name = "Code " + string(sector) if sector_name == ""
label values sector
order sector sector_name firms changes reducer_adj_firms pct_reducer_adj lo hi
sort sector
format pct_reducer_adj lo hi %6.2f
export delimited using "tables/03_who_reduces_by_sector_firm_flag.csv", datafmt replace
list, noobs sep(0) abbreviate(24)
restore

*---------------------------------------------------------------------------
display "Step 7/8: dot plot, four panels on one shared scale, sectors sorted by panel (a)"
*---------------------------------------------------------------------------
* y positions: header row 0, drawn sectors 1..K, then a block naming the sectors with too few changes
quietly count if in_figure
local K = r(N)
gen double y = row_order if in_figure
local ylab `"0 "Sector (number of one-year changes)""'
forvalues i = 1/`K' {
    local nstr = strtrim(string(changes[`i'], "%9.0fc"))
    local lab = sector_name[`i'] + " (`nstr')"
    local ylab `"`ylab' `i' "`lab'""'
}
local ymax = `K' + 0.5
local nsmall = _N - `K'
if `nsmall' > 0 {
    local pos = `K' + 2
    local ylab `"`ylab' `pos' "{bf:Too few changes to draw (under `minchg'):}""'
    forvalues i = `=`K'+1'/`=_N' {
        local ++pos
        local nstr = strtrim(string(changes[`i'], "%9.0fc"))
        local lab = sector_name[`i'] + " (`nstr')"
        local ylab `"`ylab' `pos' "`lab'""'
    }
    local ymax = `pos' + 0.5
}
* numbers for the notes (read from the data, never typed)
quietly count if in_figure & !missing(lo_energy_va, hi_energy_va) & (lo_energy_va > 50 | hi_energy_va < 50)
local nmiss = r(N)
local nexp = max(1, round(`K' / 20))
keep if in_figure
expand 4
bysort row_order: gen byte panel = _n
gen double pct = cond(panel == 1, pct_energy_va, cond(panel == 2, pct_co2_va, cond(panel == 3, pct_energy, pct_co2)))
gen double lo  = cond(panel == 1, lo_energy_va,  cond(panel == 2, lo_co2_va,  cond(panel == 3, lo_energy,  lo_co2)))
gen double hi  = cond(panel == 1, hi_energy_va,  cond(panel == 2, hi_co2_va,  cond(panel == 3, hi_energy,  hi_co2)))
gen str8   plab = string(pct, "%4.1f")
gen double labx = cond(pct < 50, lo, hi)
gen byte   labp = cond(pct < 50, 9, 3)
label define panel 1 "(a) Energy per unit of VA" 2 "(b) CO2 per unit of VA" 3 "(c) Energy use (GJ)" 4 "(d) CO2 emitted (tonnes)"
label values panel panel
local n0 = _N
set obs `=_N + 8'
gen double refx = 50 if _n > `n0'
gen double refy = .
forvalues p = 1/4 {
    replace panel = `p' in `=`n0' + 2*`p' - 1'
    replace panel = `p' in `=`n0' + 2*`p''
    replace refy = 0.5 in `=`n0' + 2*`p' - 1'
    replace refy = `K' + 0.5 in `=`n0' + 2*`p''
}
quietly summarize lo
local dlo = 50 - r(min)
quietly summarize hi
local dhi = r(max) - 50
local half = max(10, 5 * ceil((max(`dlo', `dhi') + 3) / 5))
local xlo = 50 - `half'
local xhi = 50 + `half'
local xs  = 10 * floor(`half' / 10)
display "   x range `xlo'-`xhi'"
sort panel refy y

twoway (rspike lo hi y, horizontal lcolor(black) lwidth(thin)) ///
    (scatter y pct, msymbol(O) mcolor(black) msize(vsmall)) ///
    (scatter y labx, msymbol(none) mlabel(plab) mlabvposition(labp) mlabgap(0.6) mlabsize(vsmall) mlabcolor(gs5)) ///
    (line refy refx, lpattern(dash) lcolor(gs8) lwidth(thin)), ///
    by(panel, rows(1) graphregion(color(white) lcolor(white) ilcolor(white)) legend(pos(6)) scale(0.8125) ///
        title("Figure R3-03. Share of yearly changes in which energy and CO2 fell more (or rose less) than at the typical firm," ///
              "by manufacturing sector, sorted by panel (a)", size(small) pos(11) span) ///
        note("Notes: Each dot = share of the sector's one-year changes that fell more or rose less than the typical (median) change of all firms that year." ///
             "50% = same as the typical firm. Where the 95% interval crosses the dashed line, the sector is not clearly different. In panel (a), `nmiss' of `K'" ///
             "intervals do not cross it, against about `nexp' by chance alone. Each change counts once, whatever the firm's size. Shows which sectors, not why." ///
             "Sector = two-digit industry code at the start of each change (`n_cmp' changes); codes are not checked for consistency across years. GJ = gigajoules." ///
             "VA = value added = output minus materials, energy and services bought (current prices); sectors whose prices rose faster look better in (a) and (b)." ///
             "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6))) ///
    subtitle(, pos(11) nobox fcolor(white) lcolor(white) size(small)) ///
    yscale(reverse noline range(-0.3 `ymax')) ylabel(`ylab', angle(0) noticks tlength(0) nogrid labsize(vsmall)) ytitle("") ///
    xscale(range(`xlo' `xhi') lcolor(gs10)) ///
    xlabel(`=50 - `xs''(10)`=50 + `xs'', noticks tlength(0) labsize(vsmall) grid glcolor(gs15) glwidth(vthin)) ///
    xtitle("Changes that fell more or rose less than the typical firm's that year (% of the sector's changes)", size(vsmall)) ///
    legend(order(2 "Share (%)" 1 "95% interval" 4 "50% = same as the typical firm") rows(1) region(lcolor(none)) ///
        size(vsmall) symxsize(8) keygap(1) colgap(6)) ///
    plotregion(style(none)) xsize(9.5) ysize(8)

graph export "figures/03_who_reduces_by_sector.png", width(2850) replace
graph export "figures/03_who_reduces_by_sector.pdf", replace

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
* Source: the sector table saved right after the CSV export (full precision,
* same run as the chart). One row per point, in chart order: panel (a) to (d),
* sectors top to bottom (sorted by panel (a)), then the sectors with too few
* changes, which the chart names under the plot without a dot.
use `ctsrc', clear
sort row_order
local nsec = _N
quietly count if in_figure
local K = r(N)
expand 4
bysort row_order: gen byte panel = _n
sort panel row_order
gen str30 t_panel = cond(panel == 1, "(a) Energy per unit of VA", cond(panel == 2, "(b) CO2 per unit of VA", ///
                    cond(panel == 3, "(c) Energy use (GJ)", "(d) CO2 emitted (tonnes)")))
gen str40 t_sec = sector_name
gen double v  = cond(panel == 1, pct_energy_va, cond(panel == 2, pct_co2_va, cond(panel == 3, pct_energy, pct_co2)))
gen double lo = cond(panel == 1, lo_energy_va,  cond(panel == 2, lo_co2_va,  cond(panel == 3, lo_energy,  lo_co2)))
gen double hi = cond(panel == 1, hi_energy_va,  cond(panel == 2, hi_co2_va,  cond(panel == 3, hi_energy,  hi_co2)))
* rounding as the chart labels (one decimal)
gen str12 t_v  = string(v,  "%9.1f") if !missing(v)
gen str12 t_lo = string(lo, "%9.1f") if !missing(lo)
gen str12 t_hi = string(hi, "%9.1f") if !missing(hi)
gen str12 t_ch = string(changes, "%12.0fc")
gen str12 t_f  = string(firms, "%12.0fc")
gen str60 t_status = "drawn"
replace t_status = "not drawn: under `minchg' changes (named under the plot)" if !in_figure
* checks: every drawn point is one row with a number and an interval
quietly count if in_figure
assert r(N) == 4 * `K'
assert t_v != "" & t_lo != "" & t_hi != "" if in_figure
assert _N == 4 * `nsec'
* notes: the chart's notes, how to read the table, Source, development-data line
local ntext "Notes: Each dot = share of the sector's one-year changes that fell more or rose less than the typical (median) change of all firms that year."
local ntext "`ntext' 50% = same as the typical firm. Where the 95% interval crosses the dashed line, the sector is not clearly different. In panel (a), `nmiss' of `K'"
local ntext "`ntext' intervals do not cross it, against about `nexp' by chance alone. Each change counts once, whatever the firm's size. Shows which sectors, not why."
local ntext "`ntext' Sector = two-digit industry code at the start of each change (`n_cmp' changes); codes are not checked for consistency across years. GJ = gigajoules."
local ntext "`ntext' VA = value added = output minus materials, energy and services bought (current prices); sectors whose prices rose faster look better in (a) and (b)."
local tnote "Table: every point of Figure R3-03, panel by panel, sectors in chart order (sorted by panel (a)), then the sectors with too"
local tnote "`tnote' few changes to draw; rounded as the chart labels. 95% interval clustered by firm. Changes = one-year changes in the sector"
local tnote "`tnote' (the number on the chart); Firms = firms behind them. Full precision and ISIC titles: tables/03_who_reduces_by_sector.csv."
ctable_pdf t_panel t_sec t_v t_lo t_hi t_ch t_f t_status using "tables/03_who_reduces_by_sector_table.pdf", ///
    title("Table R3-03. Share of yearly changes in which energy and CO2 fell more (or rose less) than at the typical firm, by sector: every plotted point") ///
    header("Panel" "Sector" "Share|(%)" "95%|low" "95%|high" "Changes" "Firms" "Status") ///
    right(3 4 5 6 7) norepeat(1) fontsize(9) rules(`nsec' `=2*`nsec'' `=3*`nsec'') perpage(`nsec') ///
    notes("`ntext'" "`tnote'" "`srcnote'" "`devnote'")
display "table -> tables/03_who_reduces_by_sector_table.pdf"
* --- end of PART 2 ------------------------------------------------------------

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/03_who_reduces_by_sector.png (elapsed `elapsed' s)"
quietly log close
