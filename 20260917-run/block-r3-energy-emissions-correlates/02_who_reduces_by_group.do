/*==========================================================================
  R3-02  Are bigger firms, exporters, importers or foreign-owned firms more
         often the ones whose energy use and CO2 fell more than the typical
         firm's that year?
         Energy and CO2 are shown per unit of value added and in total.
  Answers Deasy R3: "Siapa yang reduce energy use and emisi? ... determinan
         motivasi ..." - "Bukan kausal, tp mengetahui firms mana yg respond"
         (this shows WHICH groups, not WHY).
  Output : figures/02_who_reduces_by_group.png (+ .pdf)
           tables/02_who_reduces_by_group.csv   (one-year changes, main unit)
           tables/02_who_reduces_firm_flag.csv  (firm-level reducer flag, companion)
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
log using "logs/02_who_reduces_by_group.log", replace text
timer clear 1
timer on 1
display _newline "=== [R3-02] STARTING: which groups of firms cut energy and CO2 more often than the typical firm ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

*---------------------------------------------------------------------------
display "Step 1/7: load the variables; find years where foreign ownership jumps"
*---------------------------------------------------------------------------
* workers      = total workers (size)
* export_flag  = any exports (missing = not recorded)
* import_flag  = imports above zero (never missing)
* fdi_10_flag  = foreign ownership of 10% or more (the definition used in all R1-R3 files)
use firm_id year total_gj_s1 co2_total_s1 value_added_nominal workers large_gt100_flag ///
    export_flag import_flag fdi_10_flag using "$DATA", clear
isid firm_id year
* A "break year" is a year whose foreign-owned share is more than twice the
* typical (median) yearly share: foreign status measured in that year is not used.
preserve
collapse (mean) sh_fdi = fdi_10_flag, by(year)
quietly summarize sh_fdi, detail
local med_sh = r(p50)
list, noobs sep(0) abbreviate(24)
quietly levelsof year if sh_fdi > 2 * `med_sh' & !missing(sh_fdi), local(fdi_skip)
restore
display "   Foreign-ownership break year(s): `fdi_skip'"
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
display "Step 3/7: for each change, did it beat the typical firm, and which group was the firm in?"
*---------------------------------------------------------------------------
* beat = the change was below the typical (median) change that year: it fell more or rose less.
foreach v in energy_va co2_va energy co2 {
    gen byte beat_`v' = (rel_chg_`v' < 0) if cmp
    quietly count if cmp & rel_chg_`v' == 0
    display "   `v': changes exactly at the typical change (counted as not beating it) = " r(N)
}
quietly summarize beat_energy_va
assert inrange(r(mean), 0.49, 0.51)            // about half beat the median by construction
* Groups are measured at the START of each change (the year before).
gen int start_year = year - 1 if cmp
gen double s_workers = L.workers if cmp
gen byte g_size = .                             // thirds of workers within each start year
quietly levelsof start_year, local(ys)
foreach y of local ys {
    xtile tmp = s_workers if start_year == `y', nq(3)
    replace g_size = tmp if start_year == `y'
    drop tmp
}
gen byte g_exp    = cond(L.export_flag == 1, 1, cond(L.export_flag == 0, 2, 3)) if cmp    // 3 = not recorded
gen byte g_imp    = cond(L.import_flag == 1, 1, 2) if cmp
gen byte g_fdiall = cond(L.fdi_10_flag == 1, 1, cond(L.fdi_10_flag == 0, 2, 3)) if cmp    // 3 = not recorded
gen byte g_large  = cond(L.large_gt100_flag == 1, 1, 2) if cmp
gen byte g_fdi    = g_fdiall
foreach y of local fdi_skip {
    replace g_fdi = . if start_year == `y'      // status from a break year is not used
}
quietly count if cmp
local n_cmp_num = r(N)
local n_cmp = strtrim(string(r(N), "%9.0fc"))
foreach d in size exp imp large fdiall {
    quietly count if cmp & !missing(g_`d')
    assert r(N) == `n_cmp_num'                  // every change sits in exactly one group
}
quietly count if cmp & missing(g_fdi)
display "   Changes left out of the foreign-ownership rows (break year): " r(N)
* Fall-back check for panels (c)–(d): changes that start from a high energy level
* tend to fall back, so groups that start bigger look better there partly
* automatically. Fifths of starting energy within each start year.
gen double s_lnE = ln(L.total_gj_s1) if cmp
gen byte e5 = .
foreach y of local ys {
    xtile tmp5 = s_lnE if start_year == `y', nq(5)
    replace e5 = tmp5 if start_year == `y'
    drop tmp5
}
quietly summarize beat_energy if e5 == 5
local fb_top = strtrim(string(100 * r(mean), "%3.0f"))
quietly summarize beat_energy if e5 == 1
local fb_bot = strtrim(string(100 * r(mean), "%3.0f"))
display "   Energy use: changes from the top fifth of starting energy beat the typical change `fb_top'%, bottom fifth `fb_bot'%"

*---------------------------------------------------------------------------
display "Step 4/7: share beating the typical firm, per group, with 95% intervals -> CSV"
*---------------------------------------------------------------------------
* The interval allows for the same firm appearing in several years (clustered by firm).
tempname P
tempfile rows
postfile `P' int row_order byte in_figure str40 dimension str24 group long(changes firms) ///
    double(workers_min workers_median workers_max) str24 reference_group ///
    double(pct_energy_va lo_energy_va hi_energy_va gap_energy_va gap_lo_energy_va gap_hi_energy_va ///
           pct_co2_va lo_co2_va hi_co2_va gap_co2_va gap_lo_co2_va gap_hi_co2_va ///
           pct_energy lo_energy hi_energy gap_energy gap_lo_energy gap_hi_energy ///
           pct_co2 lo_co2 hi_co2 gap_co2 gap_lo_co2 gap_hi_co2 pct_energy_va_early) ///
    long changes_early double pct_energy_va_late long changes_late using `rows', replace
local r 0
foreach d in size exp imp fdi large fdiall {
    * labels and the reference group each gap is measured against
    if "`d'" == "size"   local dn "Size (workers, thirds per year)"
    if "`d'" == "exp"    local dn "Exports"
    if "`d'" == "imp"    local dn "Imports"
    if "`d'" == "fdi"    local dn "Foreign ownership (10% or more)"
    if "`d'" == "large"  local dn "More than 100 workers"
    if "`d'" == "fdiall" local dn "Foreign ownership, break year kept"
    if "`d'" == "size"   local gl `""Smallest third" "Middle third" "Largest third""'
    if "`d'" == "exp"    local gl `""Exporter" "Non-exporter" "Not recorded""'
    if "`d'" == "imp"    local gl `""Importer" "Non-importer""'
    if inlist("`d'", "fdi", "fdiall") local gl `""Foreign-owned" "Domestic" "Not recorded""'
    if "`d'" == "large"  local gl `""More than 100 workers" "100 or fewer""'
    local ref = cond("`d'" == "size", 1, 2)
    local refname : word `ref' of `gl'
    local infig = inlist("`d'", "size", "exp", "imp", "fdi")
    forvalues k = 1/3 {
        quietly count if cmp & g_`d' == `k'
        if r(N) == 0 continue
        local ++r
        local gname : word `k' of `gl'
        local vals ""
        foreach v in energy_va co2_va energy co2 {
            quietly mean beat_`v' if cmp & g_`d' == `k', vce(cluster firm_id)
            matrix T = r(table)
            local p  = 100 * T[1,1]
            local lo = 100 * T[5,1]
            local hi = 100 * T[6,1]
            local nn = e(N)
            local nf = e(N_clust)
            if `k' == `ref' {
                local g = .
                local glo = .
                local ghi = .
            }
            else {
                quietly regress beat_`v' ib`ref'.g_`d' if cmp, vce(cluster firm_id)
                quietly lincom 100 * `k'.g_`d'
                local g   = r(estimate)
                local glo = r(lb)
                local ghi = r(ub)
            }
            local vals `vals' (`p') (`lo') (`hi') (`g') (`glo') (`ghi')
        }
        * worker counts behind the size groups
        local wmin = .
        local wmed = .
        local wmax = .
        if inlist("`d'", "size", "large") {
            quietly summarize s_workers if cmp & g_`d' == `k', detail
            local wmin = r(min)
            local wmed = r(p50)
            local wmax = r(max)
        }
        * main measure before and after the missing 2016 file
        quietly summarize beat_energy_va if cmp & g_`d' == `k' & year < 2016
        local pe = 100 * r(mean)
        local ne = r(N)
        quietly summarize beat_energy_va if cmp & g_`d' == `k' & year > 2016
        local pl = 100 * r(mean)
        local nl = r(N)
        post `P' (`r') (`infig') ("`dn'") ("`gname'") (`nn') (`nf') (`wmin') (`wmed') (`wmax') ("`refname'") ///
            `vals' (`pe') (`ne') (`pl') (`nl')
    }
}
postclose `P'

*---------------------------------------------------------------------------
display "Step 5/7: firm-level companion (the R3 reducer flag), status at each firm's first change"
*---------------------------------------------------------------------------
preserve
bysort firm_id: egen int first_cmp = min(cond(cmp, year, .))
foreach d in size exp imp fdi {
    bysort firm_id: egen byte f_`d' = max(cond(year == first_cmp, g_`d', .))
}
bysort firm_id: keep if _n == 1
keep if !missing(reducer_adj_energy_va)         // firms with at least two changes
tempname F
tempfile firmrows
postfile `F' str40 dimension str24 group long(firms changes reducer_adj_firms) ///
    double(pct_reducer_adj lo hi) using `firmrows', replace
foreach d in size exp imp fdi {
    if "`d'" == "size" local dn "Size (workers, thirds per year)"
    if "`d'" == "exp"  local dn "Exports"
    if "`d'" == "imp"  local dn "Imports"
    if "`d'" == "fdi"  local dn "Foreign ownership (10% or more)"
    if "`d'" == "size" local gl `""Smallest third" "Middle third" "Largest third""'
    if "`d'" == "exp"  local gl `""Exporter" "Non-exporter" "Not recorded""'
    if "`d'" == "imp"  local gl `""Importer" "Non-importer""'
    if "`d'" == "fdi"  local gl `""Foreign-owned" "Domestic" "Not recorded""'
    forvalues k = 1/3 {
        quietly count if f_`d' == `k'
        if r(N) == 0 continue
        local gname : word `k' of `gl'
        quietly ci proportions reducer_adj_energy_va if f_`d' == `k', wilson
        local nfirm = r(N)
        local p  = 100 * r(proportion)
        local lo = 100 * r(lb)
        local hi = 100 * r(ub)
        quietly summarize n_chg_energy_va if f_`d' == `k'
        local nch = r(sum)
        quietly count if reducer_adj_energy_va == 1 & f_`d' == `k'
        post `F' ("`dn'") ("`gname'") (`nfirm') (`nch') (r(N)) (`p') (`lo') (`hi')
    }
}
postclose `F'
use `firmrows', clear
format pct_reducer_adj lo hi %6.2f
export delimited using "tables/02_who_reduces_firm_flag.csv", datafmt replace
list, noobs sep(0) abbreviate(24)
restore

use `rows', clear
format workers_* changes* firms %9.0f
format pct_* lo_* hi_* gap_* %6.2f
export delimited using "tables/02_who_reduces_by_group.csv", datafmt replace
list row_order dimension group changes pct_energy_va lo_energy_va hi_energy_va gap_energy_va pct_energy gap_energy, ///
    noobs sep(0) abbreviate(24)
assert lo_energy_va <= pct_energy_va & pct_energy_va <= hi_energy_va

*---------------------------------------------------------------------------
display "Step 6/7: numbers for the notes (read from the data, never typed)"
*---------------------------------------------------------------------------
local fdinote ""
if "`fdi_skip'" != "" local fdinote "; foreign status from `fdi_skip' is not used"

*---------------------------------------------------------------------------
display "Step 7/7: dot plot, four panels on one shared scale"
*---------------------------------------------------------------------------
keep if in_figure
sort row_order
* y positions: a header row per group family, one blank row between families
gen double y = .
local pos 0
local ylab `"0 "Group (number of one-year changes)""'
local prevdim ""
forvalues i = 1/`=_N' {
    local dnm = dimension[`i']
    if "`dnm'" != "`prevdim'" {
        if "`prevdim'" != "" local ++pos
        local ++pos
        local ylab `"`ylab' `pos' "{bf:`dnm':}""'
        local prevdim "`dnm'"
    }
    local ++pos
    replace y = `pos' in `i'
    local nstr = strtrim(string(changes[`i'], "%9.0fc"))
    local gnm = group[`i']
    local ylab `"`ylab' `pos' "`gnm' (`nstr')""'
}
local ymax = `pos' + 0.5
expand 4
bysort row_order: gen byte panel = _n
gen double pct = cond(panel == 1, pct_energy_va, cond(panel == 2, pct_co2_va, cond(panel == 3, pct_energy, pct_co2)))
gen double lo  = cond(panel == 1, lo_energy_va,  cond(panel == 2, lo_co2_va,  cond(panel == 3, lo_energy,  lo_co2)))
gen double hi  = cond(panel == 1, hi_energy_va,  cond(panel == 2, hi_co2_va,  cond(panel == 3, hi_energy,  hi_co2)))
* value label sits past the whisker end that points away from the 50% line
gen str8   plab = string(pct, "%4.1f")
gen double labx = cond(pct < 50, lo, hi)
gen byte   labp = cond(pct < 50, 9, 3)
label define panel 1 "(a) Energy per unit of VA" 2 "(b) CO2 per unit of VA" 3 "(c) Energy use (GJ)" 4 "(d) CO2 emitted (tonnes)"
label values panel panel
* dashed reference line at 50% in each panel
local n0 = _N
set obs `=_N + 8'
gen double refx = 50 if _n > `n0'
gen double refy = .
forvalues p = 1/4 {
    replace panel = `p' in `=`n0' + 2*`p' - 1'
    replace panel = `p' in `=`n0' + 2*`p''
    replace refy = 0.5 in `=`n0' + 2*`p' - 1'
    replace refy = `ymax' in `=`n0' + 2*`p''
}
* symmetric x range around 50: whiskers plus room for the value labels, steps of 5
quietly summarize lo
local dlo = 50 - r(min)
quietly summarize hi
local dhi = r(max) - 50
local half = max(10, 5 * ceil((max(`dlo', `dhi') + 3) / 5))
local xlo = 50 - `half'
local xhi = 50 + `half'
local xs  = 10 * floor(`half' / 10)
sort panel refy y

twoway (rspike lo hi y, horizontal lcolor(black) lwidth(thin)) ///
    (scatter y pct, msymbol(O) mcolor(black) msize(vsmall)) ///
    (scatter y labx, msymbol(none) mlabel(plab) mlabvposition(labp) mlabgap(0.6) mlabsize(vsmall) mlabcolor(gs5)) ///
    (line refy refx, lpattern(dash) lcolor(gs8) lwidth(thin)), ///
    by(panel, rows(1) graphregion(color(white) lcolor(white) ilcolor(white)) legend(pos(6)) ///
        title("Figure R3-02. Share of yearly changes in which energy and CO2 fell more (or rose less) than at the typical firm," ///
              "by firm size, exports, imports and foreign ownership", size(small) pos(11) span) ///
        note("Notes: Each dot = share of the group's one-year changes that fell more or rose less than the typical (median) firm's change that year." ///
             "50% = same as the typical firm; where the 95% interval crosses the dashed line, the group is not clearly different. Shows who, not why." ///
             "In (c)–(d), changes starting from the highest fifth of energy use beat the typical change `fb_top'% of the time, the lowest fifth `fb_bot'%:" ///
             "groups that start with more energy look better there partly automatically." ///
             "Group = the firm's status in the first year of each change (`n_cmp' changes). Each change is compared only with the same year's changes," ///
             "so a shift in how a status is recorded between years cannot create a gap by itself`fdinote'." ///
             "VA = value added = output value minus materials, energy and services bought (current prices). GJ = gigajoules." ///
             "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6))) ///
    subtitle(, pos(11) nobox fcolor(white) lcolor(white) size(small)) ///
    yscale(reverse noline range(-0.3 `ymax')) ylabel(`ylab', angle(0) noticks tlength(0) nogrid labsize(vsmall)) ytitle("") ///
    xscale(range(`xlo' `xhi') lcolor(gs10)) ///
    xlabel(`=50 - `xs''(10)`=50 + `xs'', noticks tlength(0) labsize(vsmall) grid glcolor(gs15) glwidth(vthin)) ///
    xtitle("Changes that fell more or rose less than the typical firm's that year (% of the group's changes)", size(vsmall)) ///
    legend(order(2 "Share (%)" 1 "95% interval" 4 "50% = same as the typical firm") rows(1) region(lcolor(none)) ///
        size(vsmall) symxsize(8) keygap(1) colgap(6)) ///
    plotregion(style(none)) xsize(9) ysize(6.5)

graph export "figures/02_who_reduces_by_group.png", width(2700) replace
graph export "figures/02_who_reduces_by_group.pdf", replace

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/02_who_reduces_by_group.png (elapsed `elapsed' s)"
quietly log close
