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
display "Step 1/7: load; sector code as a number; each sector's share of all energy and CO2 (table only)"
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
display "Step 2/7: one-year changes, as in R3-01 (same code)"
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
display "Step 3/7: did each change beat the typical firm? sector at the start of each change"
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
display "Step 4/7: share per sector with 95% intervals (clustered by firm)"
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
display "Step 5/7: firm-level companion (the R3 reducer flag), sector at each firm's first change"
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
display "Step 6/7: names, drawing rule, order -> CSVs (numbers written before drawing)"
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
display "Step 7/7: dot plot, four panels on one shared scale, sectors sorted by panel (a)"
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
timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/03_who_reduces_by_sector.png (elapsed `elapsed' s)"
quietly log close
