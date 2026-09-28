/*==========================================================================
  R3-04  Holding the other traits fixed, which firm traits go with bigger
         one-year cuts in energy and CO2 (per unit of value added and in
         total)? Fixed-effects associations, not causes.
  Answers Deasy R3: "determinan motivasi apa yg membuat firms respond" -
         Strategy "FE" - "Bukan kausal".
  Figure : comparisons (A) and (B); comparison (C) is in the CSVs only.
  Output : figures/04_trait_associations_fe.png (+ .pdf)
           tables/04_trait_associations_fe.csv            (numbers in the figure)
           tables/04_trait_associations_fe_all_terms.csv  (every coefficient, all checks)
           tables/04_trait_associations_fe_table.pdf (every plotted point)
           tables/04_trait_associations_fe_regression.pdf (comparisons A, B, C; with and without starting level)
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
log using "logs/04_trait_associations_fe.log", replace text
timer clear 1
timer on 1
display _newline "=== [R3-04] STARTING: which firm traits go with bigger cuts, other traits held fixed ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

*---------------------------------------------------------------------------
display "Step 1/9: load the variables; find years where foreign ownership jumps"
*---------------------------------------------------------------------------
use firm_id year total_gj_s1 co2_total_s1 value_added_nominal workers ///
    export_flag import_flag fdi_10_flag own_gen_positive_reported ///
    industry2_reported province_code using "$DATA", clear
isid firm_id year
preserve
collapse (mean) sh_fdi = fdi_10_flag, by(year)
quietly summarize sh_fdi, detail
local med_sh = r(p50)
quietly levelsof year if sh_fdi > 2 * `med_sh' & !missing(sh_fdi), local(fdi_skip)
restore
display "   Foreign-ownership break year(s): `fdi_skip'"
gen int sector = real(industry2_reported)
encode province_code, gen(province)
xtset firm_id year

*---------------------------------------------------------------------------
display "Step 2/9: one-year changes, as in R3-01 (same code)"
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
    gen double lev_`v' = ln(L.`v') if cmp                        // starting level (log)
}
bysort year: egen double med_chg_energy_va = pctile(chg_energy_va), p(50)  // for the check in Step 4
xtset firm_id year

*---------------------------------------------------------------------------
display "Step 3/9: traits at the START of each change"
*---------------------------------------------------------------------------
gen int    start_year = year - 1 if cmp
gen double s_lnw  = ln(L.workers) if cmp
gen byte   exp1   = (L.export_flag == 1) if cmp
gen byte   exp_nr = missing(L.export_flag) if cmp
gen byte   imp1   = (L.import_flag == 1) if cmp
gen byte   fdi1   = (L.fdi_10_flag == 1) if cmp
gen byte   fdi_nr = missing(L.fdi_10_flag) if cmp
gen byte   own1   = (L.own_gen_positive_reported == 1) if cmp
gen byte   own_nr = missing(L.own_gen_positive_reported) if cmp
* Foreign status measured in a break year is not used. Those changes are left
* out of EVERY model (not only the foreign row): comparison B compares a firm
* with itself, and any filler value would create fake switches in and out of
* foreign ownership. One sample for A, B and C keeps the three comparable.
gen byte brk = 0 if cmp
foreach y of local fdi_skip {
    replace brk = 1 if start_year == `y' & cmp
}
quietly count if cmp & brk == 0 & missing(s_lnw)
display "   changes left out: no worker count at the start = " r(N)
gen byte use = cmp & brk == 0 & !missing(s_lnw)   // ln(workers) needs workers > 0
gen byte fdi1_k   = fdi1 & brk == 0 if cmp           // check only: keep break-year changes,
gen byte fdi_nr_k = (fdi_nr == 1 | brk == 1) if cmp  // their foreign status as "not used"
quietly count if cmp
local n_all = r(N)
quietly count if use
local n_use = r(N)
display "   changes: all `n_all', used `n_use' (left out: break-year starts or no worker count: " `n_all' - `n_use' ")"
assert !missing(s_lnw) if use
gen byte period = cond(year < 2016, 1, 2) if cmp          // before / after the missing 2016 file
keep if cmp
local X "s_lnw exp1 exp_nr imp1 fdi1 fdi_nr own1 own_nr"

*---------------------------------------------------------------------------
display "Step 4/9: the three comparisons, four outcomes, with and without starting level"
*---------------------------------------------------------------------------
* check: with year effects, comparing with the year's typical change changes nothing
gen double rel_chg_energy_va = chg_energy_va - med_chg_energy_va
quietly reghdfe chg_energy_va `X' if use, absorb(year sector province) vce(cluster firm_id)
matrix b1 = e(b)
matrix b1 = b1[1, 1..8]
quietly reghdfe rel_chg_energy_va `X' if use, absorb(year sector province) vce(cluster firm_id)
matrix b2 = e(b)
matrix b2 = b2[1, 1..8]
assert mreldif(b1, b2) < 1e-8          // identical slopes

tempname P
tempfile coefs
postfile `P' str10 outcome str14 spec str8 term double(b se p lo hi) long(changes firms singletons) using `coefs', replace
foreach y in energy_va co2_va energy co2 {
    foreach s in A B C A_lev B_lev C_lev A_keepbreak A_noowngen B_split2016 A_early A_late {
        local ab "year sector province"
        if inlist("`s'", "B", "B_lev")   local ab "firm_id year"
        if inlist("`s'", "C", "C_lev")   local ab "sector#year province#year"
        if "`s'" == "B_split2016"         local ab "firm_id#period year"
        local xx "`X'"
        if strpos("`s'", "_lev")          local xx "`X' lev_`y'"
        if "`s'" == "A_noowngen"          local xx "s_lnw exp1 exp_nr imp1 fdi1 fdi_nr"
        local cond "1"
        if "`s'" == "A_early"             local cond "start_year < 2016"
        if "`s'" == "A_late"              local cond "start_year > 2016"
        local smp "use"
        if "`s'" == "A_keepbreak" {
            local smp "1"
            local xx "s_lnw exp1 exp_nr imp1 fdi1_k fdi_nr_k own1 own_nr"
        }
        quietly reghdfe chg_`y' `xx' if `smp' & `cond', absorb(`ab') vce(cluster firm_id)
        matrix T = r(table)
        local N  = e(N)
        local G  = e(N_clust)
        local S  = e(num_singletons)
        if "`S'" == "" local S 0
        foreach t of local xx {
            local j = colnumb(T, "`t'")
            local tn = cond(substr("`t'", 1, 4) == "lev_", "lev", subinstr("`t'", "_k", "", 1))
            if missing(T[2,`j']) | T[2,`j'] == 0 {     // term dropped (no one has it in this sample): blank
                post `P' ("`y'") ("`s'") ("`tn'") (.) (.) (.) (.) (.) (`N') (`G') (`S')
            }
            else {
                post `P' ("`y'") ("`s'") ("`tn'") (T[1,`j']) (T[2,`j']) (T[4,`j']) (T[5,`j']) (T[6,`j']) (`N') (`G') (`S')
            }
        }
    }
}
postclose `P'

*---------------------------------------------------------------------------
display "Step 5/9: firms whose trait changes (these alone drive comparison B)"
*---------------------------------------------------------------------------
quietly reghdfe chg_energy_va `X' if use, absorb(firm_id year) vce(cluster firm_id)
gen byte inB = e(sample)
tempname W
tempfile sw
postfile `W' str8 term long(changes_with_trait firms_B switch_firms switch_gap_only changes_of_switchers) using `sw', replace
egen byte tagB = tag(firm_id) if inB
quietly count if tagB == 1
local fB = r(N)
foreach t in s_lnw exp1 imp1 fdi1 own1 {
    local ok "1"
    if "`t'" == "exp1" local ok "!exp_nr"
    if "`t'" == "fdi1" local ok "!fdi_nr"
    if "`t'" == "own1" local ok "!own_nr"
    bysort firm_id: egen double mx = max(cond(inB & `ok', `t', .))
    bysort firm_id: egen double mn = min(cond(inB & `ok', `t', .))
    bysort firm_id period: egen double pmx = max(cond(inB & `ok', `t', .))
    bysort firm_id period: egen double pmn = min(cond(inB & `ok', `t', .))
    gen byte wsw = (pmx != pmn) & !missing(pmx)
    bysort firm_id: egen byte anyw = max(wsw)
    quietly count if tagB == 1 & mx != mn & !missing(mx)
    local a = r(N)
    quietly count if tagB == 1 & mx != mn & !missing(mx) & anyw == 0
    local g = r(N)
    quietly count if inB & mx != mn & !missing(mx)
    local c = r(N)
    quietly count if use & `t' == 1
    local ct = cond("`t'" == "s_lnw", ., r(N))
    post `W' ("`t'") (`ct') (`fB') (`a') (`g') (`c')
    display "   `t': firms whose value changes within comparison B = `a' of `fB' (only across the missing year: `g')"
    drop mx mn pmx pmn wsw anyw
}
postclose `W'
xtset firm_id year

*---------------------------------------------------------------------------
display "Step 6/9: leave out one pair of years at a time (comparison A)"
*---------------------------------------------------------------------------
tempname L
tempfile loo
postfile `L' str10 outcome str14 spec str8 term int left_out double b using `loo', replace
quietly levelsof start_year if use, local(sys)
foreach y in energy_va co2_va energy co2 {
    foreach s in A A_lev {
        local xx "`X'"
        if "`s'" == "A_lev" local xx "`X' lev_`y'"
        foreach sy of local sys {
            quietly reghdfe chg_`y' `xx' if use & start_year != `sy', absorb(year sector province) vce(cluster firm_id)
            foreach t of local xx {
                local tn = cond(substr("`t'", 1, 4) == "lev_", "lev", "`t'")
                post `L' ("`y'") ("`s'") ("`tn'") (`sy') (_b[`t'])
            }
        }
    }
}
postclose `L'

* numbers for the notes (read from the data, never typed)
quietly count if use
local n_use = strtrim(string(r(N), "%9.0fc"))
egen byte tagU = tag(firm_id) if use
quietly count if tagU == 1
local f_use = strtrim(string(r(N), "%9.0fc"))
* which pair of years moves (A) the most for own electricity and importers, panel (a)
preserve
use `coefs', clear
keep if spec == "A" & outcome == "energy_va"
keep term b
rename b b_full
tempfile full
save `full'
use `loo', clear
keep if spec == "A" & outcome == "energy_va"
merge m:1 term using `full', keep(match) nogen
gen double dist = abs(b - b_full)
foreach t in own1 imp1 {
    quietly summarize dist if term == "`t'"
    local dmax = r(max)
    quietly summarize left_out if term == "`t'" & dist >= `dmax' - 1e-12
    local yr_`t' = r(min)
    quietly summarize b if term == "`t'" & left_out == `yr_`t''
    local p_`t' = 100 * (exp(r(mean)) - 1)
    local s_`t' = cond(`p_`t'' > 0, "+", "") + strtrim(string(`p_`t'', "%5.1f"))
}
restore
if `yr_own1' == `yr_imp1' local loonote "Without changes starting in `yr_own1': own electricity `s_own1'%, importer `s_imp1'% in (a)."
else local loonote "Without changes starting in `yr_own1': own electricity `s_own1'% in (a); without `yr_imp1': importer `s_imp1'%."
local brknote ""
if "`fdi_skip'" != "" local brknote "Changes starting in `fdi_skip' are left out (foreign-owned share jumps)."
display "   `loonote'"

*---------------------------------------------------------------------------
display "Step 7/9: turn coefficients into % differences -> two CSV files"
*---------------------------------------------------------------------------
* Outcome = one-year change in logs. A yes/no trait with coefficient b means:
* the measure ends the year 100*(exp(b)-1) % higher than for firms without it.
* Workers and starting level are in logs: "twice as much" = 100*(2^b - 1) %.
use `loo', clear
collapse (min) loo_min = b (max) loo_max = b, by(outcome spec term)
tempfile loosum
save `loosum'
use `coefs', clear
merge m:1 outcome spec term using `loosum', nogen keep(master match)
gen double k = cond(inlist(term, "s_lnw", "lev"), ln(2), 1)     // "twice as much" for logs
foreach v in b lo hi loo_min loo_max {
    gen double pct_`v' = 100 * (exp(k * `v') - 1)
}
rename (pct_b pct_lo pct_hi pct_loo_min pct_loo_max) (pct pct_lo pct_hi loo_min_pct loo_max_pct)
gen str40 term_label = ""
replace term_label = "Workers: twice as many"            if term == "s_lnw"
replace term_label = "Exporter (vs non-exporter)"        if term == "exp1"
replace term_label = "Export status not recorded"        if term == "exp_nr"
replace term_label = "Importer (vs non-importer)"        if term == "imp1"
replace term_label = "Foreign-owned 10%+ (vs domestic)"  if term == "fdi1"
replace term_label = "Foreign status not recorded"       if term == "fdi_nr"
replace term_label = "Makes own electricity (vs not)"    if term == "own1"
replace term_label = "Own-electricity status not recorded" if term == "own_nr"
replace term_label = "Starting level twice as high"      if term == "lev"
gen byte in_figure = (inlist(spec, "A", "B", "C") & inlist(term, "s_lnw", "exp1", "imp1", "fdi1", "own1")) ///
                   | (inlist(spec, "A_lev", "B_lev", "C_lev") & term == "lev")
format b se lo hi %9.4f
format pct* loo_* %7.2f
format p %6.4f
sort outcome spec term
export delimited outcome spec term term_label in_figure b se p lo hi pct pct_lo pct_hi changes firms singletons ///
    loo_min_pct loo_max_pct using "tables/04_trait_associations_fe_all_terms.csv", datafmt replace
* early / late (A) next to the main rows
preserve
keep if inlist(spec, "A_early", "A_late")
keep outcome spec term pct
replace spec = subinstr(spec, "A_", "", 1)
reshape wide pct, i(outcome term) j(spec) string
rename (pctearly pctlate) (pct_A_before2016 pct_A_after2016)
tempfile el
save `el'
restore
keep if in_figure
merge m:1 outcome term using `el', nogen keep(master match)
replace pct_A_before2016 = . if spec != "A"
replace pct_A_after2016  = . if spec != "A"
merge m:1 term using `sw', nogen keep(master match)
foreach v in firms_B switch_firms switch_gap_only changes_of_switchers {
    replace `v' = . if !inlist(spec, "B")
}
gen byte row = 1*(term == "s_lnw") + 2*(term == "exp1") + 3*(term == "imp1") + 4*(term == "fdi1") + 5*(term == "own1") + 7*(term == "lev")
gen byte spec_n = 1*inlist(spec, "A", "A_lev") + 2*inlist(spec, "B", "B_lev") + 3*inlist(spec, "C", "C_lev")
gen byte panel = 1*(outcome == "energy_va") + 2*(outcome == "co2_va") + 3*(outcome == "energy") + 4*(outcome == "co2")
sort panel row spec_n
format pct_A_* %7.2f
export delimited outcome spec term term_label pct pct_lo pct_hi b se p changes firms singletons changes_with_trait ///
    switch_firms switch_gap_only changes_of_switchers loo_min_pct loo_max_pct pct_A_before2016 pct_A_after2016 ///
    using "tables/04_trait_associations_fe.csv", datafmt replace
tempfile ctsrc                     // same numbers, full precision, for the companion tables (Step 9)
quietly save `ctsrc'
list outcome spec term pct pct_lo pct_hi changes firms switch_firms loo_min_pct loo_max_pct, noobs sep(0) abbreviate(24)
assert pct_lo <= pct & pct <= pct_hi if !missing(pct_lo)

*---------------------------------------------------------------------------
display "Step 8/9: dot-and-whisker plot, four panels on one shared scale ((C) is in the CSV only)"
*---------------------------------------------------------------------------
* (C) moves no marker visibly from (A): it stays in the CSV, not in the figure
drop if spec_n == 3
* y position: one row per trait; (A) just above, (B) just below the row line
gen double y = row + 0.17 * cond(spec_n == 1, -1, 1)
gen str8   plab = string(pct, "%4.1f") if spec_n == 1
* value label of (A): past the end of its interval or gray bar, on the side away from 0
gen double labx = cond(pct < 0, min(pct_lo, loo_min_pct), max(pct_hi, loo_max_pct)) if spec_n == 1
gen byte   labp = cond(pct < 0, 10, 2)     // slightly above the line, clear of (B) below
label define panel 1 "(a) Energy per unit of VA" 2 "(b) CO2 per unit of VA" 3 "(c) Energy use (GJ)" 4 "(d) CO2 emitted (tonnes)"
label values panel panel
local ylab `"0 "{bf:Trait at the start of the change}" 1 "Workers: twice as many" 2 "Exporter" 3 "Importer" 4 "Foreign-owned (10% or more)" 5 "Makes own electricity" 6.2 "{bf:Partly an automatic fall-back:}" 7 "Starting level twice as high""'
local ymax = 7.5
* dashed zero line in each panel
local n0 = _N
set obs `=_N + 8'
gen double refx = 0 if _n > `n0'
gen double refy = .
forvalues p = 1/4 {
    replace panel = `p' in `=`n0' + 2*`p' - 1'
    replace panel = `p' in `=`n0' + 2*`p''
    replace refy = 0.5 in `=`n0' + 2*`p' - 1'
    replace refy = `ymax' in `=`n0' + 2*`p''
}
* symmetric x range around 0: whiskers, bars and labels, steps of 20
egen double xl = rowmin(pct_lo loo_min_pct)
egen double xh = rowmax(pct_hi loo_max_pct)
quietly summarize xl
local dlo = -r(min)
quietly summarize xh
local dhi = r(max)
local half = 20 * ceil((max(`dlo', `dhi') + 12) / 20)
display "   x range -`half' to `half'"
sort panel refy y

local xs = `half' / 2
twoway (rbar loo_min_pct loo_max_pct y if spec_n == 1, horizontal barwidth(0.2) fcolor(gs13) lcolor(gs13) lwidth(none)) ///
    (rspike pct_lo pct_hi y if spec_n == 1, horizontal lcolor(black) lwidth(thin)) ///
    (rspike pct_lo pct_hi y if spec_n == 2, horizontal lcolor(gs7) lwidth(thin)) ///
    (scatter y pct if spec_n == 1, msymbol(O) mcolor(black) msize(small)) ///
    (scatter y pct if spec_n == 2, msymbol(Th) mcolor(gs4) msize(small)) ///
    (scatter y labx if spec_n == 1, msymbol(none) mlabel(plab) mlabvposition(labp) mlabgap(0.6) mlabsize(vsmall) mlabcolor(black)) ///
    (line refy refx, lpattern(dash) lcolor(gs8) lwidth(thin)), ///
    by(panel, rows(1) graphregion(color(white) lcolor(white) ilcolor(white)) legend(pos(6)) ///
        title("Figure R3-04. Which firm traits go with bigger one-year cuts in energy and CO2, with the other traits held fixed", ///
              size(small) pos(11) span) ///
                note("Notes: Marker = the one-year change of firms with the trait against similar firms without it, in % (below 0 = fell more or rose less)." ///
             "Where a 95% interval crosses 0, there is no clear gap. Gray bar = where (A) moves if any one pair of years is left out. Shows which traits, not why." ///
             "`loonote' `brknote'" ///
             "Traits at the start of each change (`n_use' changes, `f_use' firms); 'not recorded' is its own group, not shown. (B) uses only firms whose trait changes," ///
             "which may be recording shifts. Starting level = the panel's measure at the start; part of its fall is automatic, as a high year tends to be" ///
             "followed by a normal one. VA = value added = output minus materials, energy and services bought (current prices). GJ = gigajoules." ///
             "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6))) ///
    subtitle(, pos(11) nobox fcolor(white) lcolor(white) size(small)) ///
    yscale(reverse noline range(-0.3 `ymax')) ylabel(`ylab', angle(0) noticks tlength(0) nogrid labsize(vsmall)) ytitle("") ///
    xscale(range(-`half' `half') lcolor(gs10)) ///
    xlabel(-`half'(`xs')`half', format(%9.0f) noticks tlength(0) labsize(vsmall) grid glcolor(gs15) glwidth(vthin)) ///
    xtitle("One-year change against similar firms without the trait (%); below 0 = bigger cut", size(vsmall)) ///
    legend(order(4 "(A) Against similar firms: same year, sector and province (main)" 5 "(B) Same firm: its years with the trait against its years without" ///
                 - " " 2 "95% interval" 1 "Range of (A), leaving out one pair of years at a time" 7 "0 = no gap") ///
        cols(2) colfirst region(lcolor(none)) size(vsmall) symxsize(8) keygap(1) colgap(6) rowgap(0.5)) ///
    plotregion(style(none)) xsize(9.5) ysize(7)

graph export "figures/04_trait_associations_fe.png", width(2850) replace
graph export "figures/04_trait_associations_fe.pdf", replace


*---------------------------------------------------------------------------
display "Step 9/9: companion tables: every plotted point, and the regression table"
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
* Source: the figure table saved right after the CSV export, and the
* coefficient file of Step 4 (full precision, the same estimation run).
* (1) Points table: one row per marker, in chart order: panel (a) to (d),
* traits top to bottom, (A) then (B) within each trait. Comparison (C) is in
* the CSV only (no marker) and is in the regression table.
use `ctsrc', clear
keep if spec_n < 3
sort panel row spec_n
local npan = _N / 4
gen str30 t_panel = cond(panel == 1, "(a) Energy per unit of VA", cond(panel == 2, "(b) CO2 per unit of VA", ///
                    cond(panel == 3, "(c) Energy use (GJ)", "(d) CO2 emitted (tonnes)")))
* trait names exactly as on the chart's axis
gen str40 t_trait = ""
replace t_trait = "Workers: twice as many"        if term == "s_lnw"
replace t_trait = "Exporter"                      if term == "exp1"
replace t_trait = "Importer"                      if term == "imp1"
replace t_trait = "Foreign-owned (10% or more)"   if term == "fdi1"
replace t_trait = "Makes own electricity"         if term == "own1"
replace t_trait = "Starting level twice as high"  if term == "lev"
gen str8 t_cmp = cond(spec_n == 1, "(A)", "(B)")
* rounding as the chart labels (one decimal)
gen str12 t_v   = string(pct,    "%9.1f") if !missing(pct)
gen str12 t_lo  = string(pct_lo, "%9.1f") if !missing(pct_lo)
gen str12 t_hi  = string(pct_hi, "%9.1f") if !missing(pct_hi)
gen str12 t_blo = string(loo_min_pct, "%9.1f") if spec_n == 1 & !missing(loo_min_pct)
gen str12 t_bhi = string(loo_max_pct, "%9.1f") if spec_n == 1 & !missing(loo_max_pct)
gen str12 t_ch  = string(changes, "%12.0fc")
gen str12 t_f   = string(firms, "%12.0fc")
gen str40 t_status = cond(spec_n == 1, "drawn: black dot, labelled", "drawn: gray hollow triangle")
replace t_status = "not drawn: term dropped" if missing(pct)
* checks: 12 markers per panel, every drawn one with a number and an interval
assert _N == 4 * 12
assert t_v != "" & t_lo != "" & t_hi != "" if !strpos(t_status, "not drawn")
assert t_blo != "" & t_bhi != "" if spec_n == 1
local ntext "Notes: Marker = the one-year change of firms with the trait against similar firms without it, in % (below 0 = fell more or rose less)."
local ntext "`ntext' Where a 95% interval crosses 0, there is no clear gap. Gray bar = where (A) moves if any one pair of years is left out. Shows which traits, not why."
local ntext "`ntext' `loonote' `brknote'"
local ntext "`ntext' Traits at the start of each change (`n_use' changes, `f_use' firms); 'not recorded' is its own group, not shown. (B) uses only firms whose trait changes,"
local ntext "`ntext' which may be recording shifts. Starting level = the panel's measure at the start; part of its fall is automatic, as a high year tends to be"
local ntext "`ntext' followed by a normal one. VA = value added = output minus materials, energy and services bought (current prices). GJ = gigajoules."
local ntext = itrim(`"`ntext'"')
local tnote "Table: every marker of Figure R3-04 in chart order; rounded as the chart labels. % = 100 × (exp(b) − 1), or 100 × (2^b − 1)"
local tnote "`tnote' for workers and starting level (b = regression table; starting level from columns (4)–(5)). Changes and Firms = the"
local tnote "`tnote' model's sample. Full precision: tables/04_trait_associations_fe.csv."
ctable_pdf t_panel t_trait t_cmp t_v t_lo t_hi t_blo t_bhi t_ch t_f t_status using "tables/04_trait_associations_fe_table.pdf", ///
    title("Table R3-04. Which firm traits go with bigger one-year cuts in energy and CO2, with the other traits held fixed: every plotted point") ///
    header("Panel" "Trait at the start" "Compar-|ison" "%|difference" "95%|low" "95%|high" "Gray bar|low" "Gray bar|high" "Changes" "Firms" "Status") ///
    right(4 5 6 7 8 9 10) norepeat(1 2) fontsize(9) rules(`npan' `=2*`npan'' `=3*`npan'') perpage(`=2*`npan'') ///
    notes("`ntext'" "`tnote'" "`srcnote'" "`devnote'")
display "table -> tables/04_trait_associations_fe_table.pdf"

* (2) Regression table (AER style): one column per comparison, without and with
* the starting level; one block per outcome (panel); rows = the terms drawn (the
* three "not recorded" markers are in every model: all terms are in the
* all-terms CSV). Coefficient in log points on the first line, (standard error)
* on the second. show_pct = 1 adds a third
* line, [%], for every term (the drawn %s are in the points table).
local show_pct 0
use `coefs', clear
keep if inlist(spec, "A", "B", "C", "A_lev", "B_lev", "C_lev")
gen byte m = 1*(spec == "A") + 2*(spec == "B") + 3*(spec == "C") + 4*(spec == "A_lev") + 5*(spec == "B_lev") + 6*(spec == "C_lev")
* check: the coefficients are those in the CSV just written (4 decimals there)
preserve
import delimited using "tables/04_trait_associations_fe_all_terms.csv", clear varnames(1) stringcols(1 2 3)
keep outcome spec term b
rename b b_csv
tempfile csvb
save `csvb'
restore
merge 1:1 outcome spec term using `csvb', keep(master match)
assert _merge == 3
drop _merge
assert abs(b - b_csv) <= 0.00005 + 1e-9 if !missing(b)
assert missing(b_csv) if missing(b)
drop b_csv
* the fixed effects of each column, from the same rules as Step 4
forvalues s = 1/6 {
    local sp : word `s' of A B C A_lev B_lev C_lev
    local ab "year sector province"
    if inlist("`sp'", "B", "B_lev") local ab "firm_id year"
    if inlist("`sp'", "C", "C_lev") local ab "sector#year province#year"
    local fe_f`s'  = cond(strpos(" `ab' ", " firm_id "), "Yes", "No")
    local fe_y`s'  = cond(strpos(" `ab' ", " year "), "Yes", "No")
    local fe_s`s'  = cond(strpos(" `ab' ", " sector "), "Yes", "No")
    local fe_p`s'  = cond(strpos(" `ab' ", " province "), "Yes", "No")
    local fe_sy`s' = cond(strpos(" `ab' ", " sector#year "), "Yes", "No")
    local fe_py`s' = cond(strpos(" `ab' ", " province#year "), "Yes", "No")
}
tempname RG
tempfile R
postfile `RG' str60 t_lab str24(t1 t2 t3 t4 t5 t6) using `R'
local nrow 0
local rl ""
foreach y in energy_va co2_va energy co2 {
    if "`y'" == "energy_va" local pn "(a) Energy per unit of VA"
    if "`y'" == "co2_va"    local pn "(b) CO2 per unit of VA"
    if "`y'" == "energy"    local pn "(c) Energy use (GJ)"
    if "`y'" == "co2"       local pn "(d) CO2 emitted (tonnes)"
    post `RG' ("Outcome `pn'") ("") ("") ("") ("") ("") ("")
    local ++nrow
    foreach t in s_lnw exp1 imp1 fdi1 own1 lev {
        if "`t'" == "s_lnw"  local tl "Workers (log)"
        if "`t'" == "exp1"   local tl "Exporter"
        if "`t'" == "exp_nr" local tl "Export status not recorded"
        if "`t'" == "imp1"   local tl "Importer"
        if "`t'" == "fdi1"   local tl "Foreign-owned 10% or more"
        if "`t'" == "fdi_nr" local tl "Foreign status not recorded"
        if "`t'" == "own1"   local tl "Makes own electricity"
        if "`t'" == "own_nr" local tl "Own-electricity status not recorded"
        if "`t'" == "lev"    local tl "Starting level (log)"
        forvalues s = 1/6 {
            quietly count if outcome == "`y'" & m == `s' & term == "`t'"
            if r(N) == 0 {                        // term not in this model
                local b`s' ""
                local s`s' ""
                local p`s' ""
                continue
            }
            quietly summarize b if outcome == "`y'" & m == `s' & term == "`t'", meanonly
            if r(N) == 0 {                        // term dropped (no one has it)
                local b`s' "—"
                local s`s' ""
                local p`s' ""
                continue
            }
            local b`s' = string(r(mean), "%9.3f")
            local kk = cond(inlist("`t'", "s_lnw", "lev"), ln(2), 1)
            local pp = 100 * (exp(`kk' * r(mean)) - 1)
            local p`s' = "[" + cond(`pp' > 0, "+", "") + string(`pp', "%9.1f") + "%]"
            quietly summarize se if outcome == "`y'" & m == `s' & term == "`t'", meanonly
            local s`s' = "(" + string(r(mean), "%9.3f") + ")"
        }
        post `RG' ("`tl'") ("`b1'") ("`b2'") ("`b3'") ("`b4'") ("`b5'") ("`b6'")
        post `RG' ("")     ("`s1'") ("`s2'") ("`s3'") ("`s4'") ("`s5'") ("`s6'")
        if `show_pct' post `RG' ("") ("`p1'") ("`p2'") ("`p3'") ("`p4'") ("`p5'") ("`p6'")
        local nrow = `nrow' + 2 + `show_pct'
    }
    local rl "`rl' `nrow'"
}
* whole-model rows: one sample per column, the same for the four outcomes (checked)
forvalues s = 1/6 {
    foreach v in changes firms singletons {
        quietly summarize `v' if m == `s'
        assert r(min) == r(max)
        local `v'`s' = string(r(max), "%12.0fc")
    }
}
post `RG' ("Observations (one-year changes)") ("`changes1'") ("`changes2'") ("`changes3'") ("`changes4'") ("`changes5'") ("`changes6'")
post `RG' ("Firms (clusters)")                ("`firms1'") ("`firms2'") ("`firms3'") ("`firms4'") ("`firms5'") ("`firms6'")
post `RG' ("Singleton changes dropped")       ("`singletons1'") ("`singletons2'") ("`singletons3'") ("`singletons4'") ("`singletons5'") ("`singletons6'")
post `RG' ("'Not recorded' markers (export, foreign, own electricity)") ("Yes") ("Yes") ("Yes") ("Yes") ("Yes") ("Yes")
post `RG' ("Firm fixed effects")            ("`fe_f1'") ("`fe_f2'") ("`fe_f3'") ("`fe_f4'") ("`fe_f5'") ("`fe_f6'")
post `RG' ("Year fixed effects")            ("`fe_y1'") ("`fe_y2'") ("`fe_y3'") ("`fe_y4'") ("`fe_y5'") ("`fe_y6'")
post `RG' ("Sector fixed effects")          ("`fe_s1'") ("`fe_s2'") ("`fe_s3'") ("`fe_s4'") ("`fe_s5'") ("`fe_s6'")
post `RG' ("Province fixed effects")        ("`fe_p1'") ("`fe_p2'") ("`fe_p3'") ("`fe_p4'") ("`fe_p5'") ("`fe_p6'")
post `RG' ("Sector × year fixed effects")   ("`fe_sy1'") ("`fe_sy2'") ("`fe_sy3'") ("`fe_sy4'") ("`fe_sy5'") ("`fe_sy6'")
post `RG' ("Province × year fixed effects") ("`fe_py1'") ("`fe_py2'") ("`fe_py3'") ("`fe_py4'") ("`fe_py5'") ("`fe_py6'")
post `RG' ("Weights")                       ("None") ("None") ("None") ("None") ("None") ("None")
post `RG' ("Standard errors clustered by")  ("Firm") ("Firm") ("Firm") ("Firm") ("Firm") ("Firm")
postclose `RG'
use `R', clear
local rsub "Outcome: one-year change in the log of the panel's measure. Log points; standard errors in parentheses"
local rsub = cond(`show_pct', "`rsub'; [% as drawn].", "`rsub'.")
local rnote "Notes: Each column is one regression, per outcome, of the firm's one-year change in the log of the measure on its traits"
local rnote "`rnote' at the start of the change (log workers; exporter, importer, foreign-owned 10% or more, makes own electricity, each"
local rnote "`rnote' with its own 'not recorded' marker); columns (4)–(6) add the log starting level of the measure. (A) year, sector and"
local rnote "`rnote' province effects; (B) firm and year effects, so only firms whose trait changes inform a trait; (C) sector × year and"
local rnote "`rnote' province × year effects (not drawn). Figure R3-04 draws the five traits from columns (1)–(2) and the starting level"
local rnote "`rnote' from (4)–(5), as % = 100 × (exp(b) − 1), or 100 × (2^b − 1) for the two log terms. Sample: `n_use' one-year"
local rnote "`rnote' changes of `f_use' firms. `brknote' Observations exclude singleton changes (one change in a firm or group, which"
local rnote "`rnote' the effects absorb). Other checks (leave out one pair of years, before and after 2016, break year kept, without own"
local rnote "`rnote' electricity, firm effects split at 2016) and the 'not recorded' coefficients: tables/04_trait_associations_fe_all_terms.csv."
local rnote "`rnote' No stars."
local rnote = itrim(`"`rnote'"')
ctable_pdf t_lab t1 t2 t3 t4 t5 t6 using "tables/04_trait_associations_fe_regression.pdf", ///
    title("Table R3-04, regression. Which firm traits go with bigger one-year cuts in energy and CO2: estimates behind the chart") ///
    subtitle("`rsub'") ///
    header("Trait at the start of the change" "(1)|(A)" "(2)|(B)" "(3)|(C)" "(4)|(A) with|starting level" "(5)|(B) with|starting level" "(6)|(C) with|starting level") ///
    right(2 3 4 5 6 7) rules(`rl') portrait fontsize(9) perpage(40) ///
    notes("`rnote'" "`srcnote'" "`devnote'")
display "table -> tables/04_trait_associations_fe_regression.pdf"
* --- end of PART 2 ------------------------------------------------------------

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/04_trait_associations_fe.png (elapsed `elapsed' s)"
quietly log close
