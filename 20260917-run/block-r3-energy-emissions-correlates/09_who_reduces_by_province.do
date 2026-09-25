/*==========================================================================
  R3-09  In which provinces did energy use and CO2 (per unit of value added,
         and in total) fall more often than at the typical firm that year?
  Answers Deasy R3: "Siapa yang reduce energy use and emisi? ... determinan
         motivasi ..." - "Bukan kausal, tp mengetahui firms mana yg respond"
         (this shows WHERE, not WHY). Province counterpart of R3-03 (sector):
         same measure, same intervals, same chart form.
  Output : figures/09_who_reduces_by_province.png (+ .pdf)
           tables/09_who_reduces_by_province.csv            (one-year changes, main unit)
           tables/09_who_reduces_by_province_firm_flag.csv  (firm-level reducer flag, companion)
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
global OUTDIR "/Users/natanaelmassie/Downloads/2026-kolega-den-bps-repo/20260917-run/block-r3-energy-emissions-correlates"
* ---------------------------------------------------------------------------
if `"`data_arg'"'   != "" global DATA   `"`data_arg'"'
if `"`outdir_arg'"' != "" global OUTDIR `"`outdir_arg'"'
cd "$OUTDIR"
foreach d in figures tables logs {
    capture mkdir "`d'"
}
cap log close
log using "logs/09_who_reduces_by_province.log", replace text
timer clear 1
timer on 1
display _newline "=== [R3-09] STARTING: which provinces cut energy and CO2 more often than the typical firm ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."
local minchg 100                 // a province is drawn on its own only with at least this many one-year changes

*---------------------------------------------------------------------------
display "Step 1/8: load; province code as a number; island group; each province's share of all energy and CO2"
*---------------------------------------------------------------------------
* province_code = two-digit province code as recorded (text). The file has no
* province names, so the exhibit shows codes. Island group = first digit of the
* code (BPS numbering): 1-2 Sumatra (21 = Riau Islands), 3 Java, 5-9 other
* islands (Bali and Nusa Tenggara, Kalimantan, Sulawesi, Maluku, Papua).
* industry2_reported = two-digit sector, used only to hold sector fixed (table).
use firm_id year province_code industry2_reported total_gj_s1 co2_total_s1 value_added_nominal using "$DATA", clear
isid firm_id year
gen int prov = real(province_code)
quietly count if missing(prov)
display "   rows with no readable province code (their own group, 'Province not recorded'): " r(N)
assert inlist(substr(province_code, 1, 1), "1", "2", "3", "5", "6", "7", "8", "9") if !missing(prov)
gen byte isl = cond(inlist(substr(province_code, 1, 1), "1", "2"), 1, cond(substr(province_code, 1, 1) == "3", 2, 3))
replace isl = 4 if missing(prov)
replace prov = 99 if missing(prov)              // 99 is not a province code: "not recorded"
gen int sector = real(industry2_reported)
replace sector = 99 if missing(sector)          // unreadable sector = its own group
preserve
collapse (sum) gj = total_gj_s1 tco2 = co2_total_s1 (count) rows = firm_id, by(prov)
quietly summarize gj
gen double pct_all_energy = 100 * gj / r(sum)
quietly summarize tco2
gen double pct_all_co2 = 100 * tco2 / r(sum)
keep prov rows pct_all_energy pct_all_co2
rename prov code
tempfile shares
save `shares'
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
display "Step 3/8: did each change beat the typical firm? province, sector and starting level at the start"
*---------------------------------------------------------------------------
* beat = the change was below the typical (median) change that year: it fell more or rose less.
foreach v in energy_va co2_va energy co2 {
    gen byte beat_`v' = (rel_chg_`v' < 0) if cmp
    quietly count if cmp & rel_chg_`v' == 0
    display "   `v': changes exactly at the typical change (counted as not beating it) = " r(N)
}
quietly summarize beat_energy_va
assert inrange(r(mean), 0.49, 0.51)            // about half beat the median by construction
gen int  g_prov = L.prov   if cmp               // province in the first year of the change
gen byte g_isl  = L.isl    if cmp
gen int  g_sec  = L.sector if cmp
gen int  start  = L.year   if cmp               // start year of the change
quietly count if cmp & g_prov != prov
display "   changes whose province differs between the two years: " r(N)
assert !missing(g_prov, g_isl, g_sec) if cmp
quietly count if cmp
local n_cmp_num = r(N)
local n_cmp = strtrim(string(r(N), "%9.0fc"))
* Starting level (checks in the table only): fifth of each measure's starting
* level among all changes starting in the same year. High starts tend to fall back.
foreach v in energy_va co2_va energy co2 {
    gen double ls_`v' = ln(L.`v') if cmp
    gen byte q5_`v' = .
}
quietly levelsof year if cmp, local(yy)
foreach v in energy_va co2_va energy co2 {
    foreach y of local yy {
        quietly xtile t_q = ls_`v' if cmp & year == `y', nq(5)
        quietly replace q5_`v' = t_q if cmp & year == `y'
        drop t_q
    }
}
assert !missing(q5_energy_va, q5_co2_va, q5_energy, q5_co2) if cmp
* typical starting energy relative to the typical firm starting that year (table: start_energy_ratio)
bysort year: egen double med_ls_energy = pctile(ls_energy), p(50)
gen double rel_ls_energy = ls_energy - med_ls_energy
xtset firm_id year
* fall-back numbers for the notes (read from the data, never typed)
quietly summarize beat_energy if cmp & q5_energy == 1
local q1pct = string(100 * r(mean), "%4.0f")
quietly summarize beat_energy if cmp & q5_energy == 5
local q5pct = string(100 * r(mean), "%4.0f")
display "   energy use: lowest fifth of starting energy beats the typical change in `q1pct'%, highest fifth in `q5pct'%"

*---------------------------------------------------------------------------
display "Step 4/8: drawing groups - provinces with enough changes, the rest together per island group"
*---------------------------------------------------------------------------
bysort g_prov: egen long n_prov_chg = count(beat_energy_va)
gen int grp = cond(n_prov_chg >= `minchg', g_prov, 900 + g_isl) if cmp   // 901-904 = smaller provinces together
xtset firm_id year
* list the province codes that sit in each "together" row (kept in the table)
forvalues i = 1/4 {
    local codes_90`i' ""
    local np_90`i' 0
    quietly levelsof g_prov if cmp & grp == 900 + `i', local(pp)
    foreach p of local pp {
        local codes_90`i' = strtrim("`codes_90`i'' `p'")
        local ++np_90`i'
    }
    display "   island group `i': smaller provinces shown together: `np_90`i'' (`codes_90`i'')"
}

*---------------------------------------------------------------------------
display "Step 5/8: share per row with 95% intervals (clustered by firm); checks without 2017 and early/late"
*---------------------------------------------------------------------------
* The interval allows for the same firm appearing in several years. Rows:
* 1 = island group (all its provinces), 2 = one province, 3 = smaller provinces together.
tempname P
tempfile rows
postfile `P' byte row_type int code byte island long(changes firms) ///
    double(pct_energy_va lo_energy_va hi_energy_va pct_co2_va lo_co2_va hi_co2_va ///
           pct_energy lo_energy hi_energy pct_co2 lo_co2 hi_co2 ///
           pct_energy_va_no2017) long changes_2017 double pct_energy_va_early long changes_early ///
    double pct_energy_va_late long changes_late double start_energy_ratio using `rows', replace
forvalues t = 1/3 {
    if `t' == 1 local gv g_isl
    if `t' == 2 local gv g_prov
    if `t' == 3 local gv grp
    quietly levelsof `gv' if cmp, local(ss)
    foreach s of local ss {
        if `t' == 3 & `s' < 900 continue        // grp holds provinces too; only the "together" rows here
        local vals ""
        foreach v in energy_va co2_va energy co2 {
            capture quietly mean beat_`v' if cmp & `gv' == `s', vce(cluster firm_id)
            if _rc == 0 {
                matrix T = r(table)
                local p  = 100 * T[1,1]
                local lo = 100 * T[5,1]
                local hi = 100 * T[6,1]
                local nn = e(N)
                local nf = e(N_clust)
            }
            if _rc != 0 | `nf' < 2 {                // one firm only: share, no interval
                quietly summarize beat_`v' if cmp & `gv' == `s'
                local p  = 100 * r(mean)
                local nn = r(N)
                local nf = 1
                local lo .
                local hi .
            }
            local vals `vals' (`p') (`lo') (`hi')
        }
        quietly summarize beat_energy_va if cmp & `gv' == `s' & start != 2017
        local p7 = 100 * r(mean)
        quietly count if cmp & `gv' == `s' & start == 2017
        local n7 = r(N)
        quietly summarize beat_energy_va if cmp & `gv' == `s' & year < 2016
        local pe = 100 * r(mean)
        local ne = r(N)
        quietly summarize beat_energy_va if cmp & `gv' == `s' & year > 2016
        local pl = 100 * r(mean)
        local nl = r(N)
        quietly summarize rel_ls_energy if cmp & `gv' == `s', detail
        local sr = exp(r(p50))
        quietly summarize g_isl if cmp & `gv' == `s'
        local is = r(min)
        post `P' (`t') (`s') (`is') (`nn') (`nf') `vals' (`p7') (`n7') (`pe') (`ne') (`pl') (`nl') (`sr')
    }
}
postclose `P'

*---------------------------------------------------------------------------
display "Step 6/8: same shares holding sector fixed, and holding the starting level fixed (table only)"
*---------------------------------------------------------------------------
* Sector fixed: share predicted from a linear model of 'beat' on the row and the
* sector, averaged over all changes = the row's share if its changes had the
* sector mix of all firms. Starting level fixed: the same with the fifth of the
* starting level (within the start year) instead of the sector.
foreach v in energy_va co2_va energy co2 {
    foreach a in sec q5 {
        local ctl = cond("`a'" == "sec", "i.g_sec", "i.q5_`v'")
        quietly regress beat_`v' i.grp `ctl' if cmp, vce(cluster firm_id)
        quietly testparm i.grp
        display "   `v', `a' held fixed: do rows differ? F(" r(df) ", " r(df_r) ") = " %6.2f r(F) ", p = " %6.4f r(p)
        quietly margins grp
        matrix G_`v'_`a' = r(table)
        quietly regress beat_`v' i.g_isl `ctl' if cmp, vce(cluster firm_id)
        quietly margins g_isl
        matrix I_`v'_`a' = r(table)
    }
    quietly regress beat_`v' i.grp if cmp, vce(cluster firm_id)
    quietly testparm i.grp
    display "   `v', as drawn: do rows differ? F(" r(df) ", " r(df_r) ") = " %6.2f r(F) ", p = " %6.4f r(p)
}
tempname A
tempfile adj
postfile `A' byte row_type int code double(sf_pct_energy_va sf_lo_energy_va sf_hi_energy_va ///
    sf_pct_co2_va sf_lo_co2_va sf_hi_co2_va sf_pct_energy sf_lo_energy sf_hi_energy sf_pct_co2 sf_lo_co2 sf_hi_co2 ///
    st_pct_energy_va st_lo_energy_va st_hi_energy_va st_pct_co2_va st_lo_co2_va st_hi_co2_va ///
    st_pct_energy st_lo_energy st_hi_energy st_pct_co2 st_lo_co2 st_hi_co2) using `adj', replace
foreach k in G I {
    local gv = cond("`k'" == "G", "grp", "g_isl")
    quietly levelsof `gv' if cmp, local(ss)
    local j 0
    foreach s of local ss {                         // margins columns come in ascending level order
        local ++j
        local vals ""
        foreach a in sec q5 {
            foreach v in energy_va co2_va energy co2 {
                local vals `vals' (100 * `k'_`v'_`a'[1,`j']) (100 * `k'_`v'_`a'[5,`j']) (100 * `k'_`v'_`a'[6,`j'])
            }
        }
        if "`k'" == "I" post `A' (1) (`s') `vals'
        else if `s' >= 900 post `A' (3) (`s') `vals'
        else post `A' (2) (`s') `vals'
    }
}
postclose `A'

*---------------------------------------------------------------------------
display "Step 7/8: firm-level companion (the R3 reducer flag), by the same rows"
*---------------------------------------------------------------------------
preserve
bysort firm_id: egen int first_cmp = min(cond(cmp, year, .))
bysort firm_id: egen int f_grp = max(cond(year == first_cmp, grp, .))
bysort firm_id: egen int f_isl = max(cond(year == first_cmp, g_isl, .))
bysort firm_id: keep if _n == 1
keep if !missing(reducer_adj_energy_va)         // firms with at least two changes
tempname F
tempfile firmrows
postfile `F' byte row_type int code long(firms changes reducer_adj_firms) double(pct_reducer_adj lo hi) using `firmrows', replace
forvalues t = 1/2 {
    local gv = cond(`t' == 1, "f_isl", "f_grp")
    quietly levelsof `gv', local(fs)
    foreach s of local fs {
        local rt = cond(`t' == 1, 1, cond(`s' >= 900, 3, 2))
        quietly count if `gv' == `s' & reducer_adj_energy_va == 1
        local nr = r(N)
        quietly summarize n_chg_energy_va if `gv' == `s'
        local nch = r(sum)
        local nf  = r(N)
        if `nf' >= 2 {
            quietly ci proportions reducer_adj_energy_va if `gv' == `s', wilson
            post `F' (`rt') (`s') (`nf') (`nch') (`nr') (100 * r(proportion)) (100 * r(lb)) (100 * r(ub))
        }
        else post `F' (`rt') (`s') (`nf') (`nch') (`nr') (100 * `nr' / `nf') (.) (.)
    }
}
postclose `F'
restore

*---------------------------------------------------------------------------
display "Step 8/8: names, drawing order -> CSVs (numbers written before drawing), then the dot plot"
*---------------------------------------------------------------------------
use `rows', clear
merge 1:1 row_type code using `adj', nogen
merge m:1 code using `shares', keep(master match) nogen      // rows and energy shares: province rows only
foreach v in rows pct_all_energy pct_all_co2 {
    replace `v' = . if row_type != 2
}
label define islname 1 "Sumatra" 2 "Java" 3 "Other islands" 4 "Province not recorded"
label values island islname
decode island, gen(island_name)
label values island
gen str244 codes_in_row = string(code) if row_type == 2
gen int n_provinces = 1 if row_type == 2
forvalues i = 1/4 {
    replace codes_in_row = "`codes_90`i''" if row_type == 3 & code == 900 + `i'
    replace n_provinces = `np_90`i'' if row_type == 3 & code == 900 + `i'
}
bysort island: egen int n_prov_isl = total(row_type == 2)
replace n_provinces = n_prov_isl if row_type == 1
drop n_prov_isl
forvalues i = 1/4 {
    quietly levelsof code if row_type == 2 & island == `i', local(cc)
    replace codes_in_row = "`cc'" if row_type == 1 & code == `i'
}
gen str80 row_label = ""
replace row_label = island_name + ", all provinces (" + strtrim(string(changes, "%9.0fc")) + ")" if row_type == 1
replace row_label = "Province " + string(code) + " (" + strtrim(string(changes, "%9.0fc")) + ")" if row_type == 2
replace row_label = "Province not recorded (" + strtrim(string(changes, "%9.0fc")) + ")" if row_type == 2 & code == 99
replace row_label = string(n_provinces) + " smaller provinces together (" + strtrim(string(changes, "%9.0fc")) + ")" ///
    if row_type == 3 & n_provinces > 1
replace row_label = "Smaller province " + codes_in_row + " (" + strtrim(string(changes, "%9.0fc")) + ")" ///
    if row_type == 3 & n_provinces == 1
label define rtype 1 "island group" 2 "province" 3 "smaller provinces together"
label values row_type rtype
decode row_type, gen(row_kind)
label values row_type
* drawn: island rows, provinces with enough changes, "together" rows with enough changes
gen byte in_figure = (row_type == 1) | (row_type == 2 & changes >= `minchg') | (row_type == 3 & changes >= `minchg')
* checks: every change sits in exactly one island row and in exactly one province row
quietly summarize changes if row_type == 1
assert r(sum) == `n_cmp_num'
quietly summarize changes if row_type == 2
assert r(sum) == `n_cmp_num'
quietly summarize changes if row_type == 3 | (row_type == 2 & changes >= `minchg')
assert r(sum) == `n_cmp_num'
* a province with under `minchg' changes is shown only inside its "together" row: its own
* share stays in the table, without an interval (with a handful of changes it would be meaningless)
foreach v in energy_va co2_va energy co2 {
    replace lo_`v' = . if row_type == 2 & changes < `minchg'
    replace hi_`v' = . if row_type == 2 & changes < `minchg'
}
assert lo_energy_va <= pct_energy_va & pct_energy_va <= hi_energy_va if in_figure
assert !missing(sf_pct_energy_va, st_pct_energy_va) if in_figure
preserve                                        // row names for the firm-level companion
keep row_type code row_kind island_name row_label
tempfile labs
save `labs'
restore
* drawing order: island group, its island row, its provinces by panel (a), its "together" row
gen byte sub = cond(row_type == 1, 1, cond(row_type == 2, 2, 3))
gen byte notdrawn = !in_figure
gsort notdrawn island sub -pct_energy_va code
gen int row_order = _n if in_figure
order row_order in_figure row_kind island_name code row_label codes_in_row n_provinces changes firms rows ///
    pct_all_energy pct_all_co2
drop row_type sub notdrawn island
rename code row_code
format pct_* lo_* hi_* sf_* st_* %6.2f
format start_energy_ratio %8.3f
export delimited using "tables/09_who_reduces_by_province.csv", datafmt replace
list row_order row_kind row_code changes firms pct_energy_va lo_energy_va hi_energy_va sf_pct_energy_va ///
    st_pct_energy_va pct_energy pct_co2 st_pct_energy, noobs sep(0) abbreviate(24)
* largest shifts from the checks, over drawn rows (log and INDEX, not the figure)
gen double d_sf = abs(sf_pct_energy_va - pct_energy_va) if in_figure
gen double d_17 = abs(pct_energy_va_no2017 - pct_energy_va) if in_figure
quietly summarize d_sf
display "   largest move in panel (a) when sector is held fixed: " %4.1f r(max) " points"
quietly summarize d_17
display "   largest move in panel (a) without changes starting in 2017: " %4.1f r(max) " points"
drop d_sf d_17

preserve
use `firmrows', clear
merge 1:1 row_type code using `labs', keep(master match) nogen
* the label in brackets counts one-year changes (main table); firms and changes are in their own columns
replace row_label = substr(row_label, 1, strrpos(row_label, " (") - 1) if strpos(row_label, " (")
sort row_type code
drop row_type
rename code row_code
order row_kind island_name row_code row_label firms changes reducer_adj_firms pct_reducer_adj lo hi
format pct_reducer_adj lo hi %6.2f
export delimited using "tables/09_who_reduces_by_province_firm_flag.csv", datafmt replace
list, noobs sep(0) abbreviate(24)
restore

* ---- figure ----
* "together" rows with too few changes are named under the plot, not drawn (none on this file)
local few ""
quietly count if row_kind == "smaller provinces together" & !in_figure
local nfew = r(N)
if `nfew' > 0 {
    quietly levelsof row_label if row_kind == "smaller provinces together" & !in_figure, local(few)
}
keep if in_figure
gen byte rtype = cond(row_kind == "island group", 1, cond(row_kind == "province", 2, 3))
* y positions: header row 0; a blank line between island groups
sort row_order
gen double y = .
local pos 0
local ylab `"0 "Province code (number of one-year changes)""'
local previsl ""
forvalues i = 1/`=_N' {
    if "`previsl'" != "" & island_name[`i'] != "`previsl'" local ++pos
    local ++pos
    quietly replace y = `pos' in `i'
    local lab = row_label[`i']
    if row_kind[`i'] == "island group" local lab "{bf:`lab'}"
    local ylab `"`ylab' `pos' "`lab'""'
    local previsl = island_name[`i']
}
local ymax = `pos' + 0.5
local lastrow = `pos'
if `nfew' > 0 {
    local pos = `pos' + 2
    local ylab `"`ylab' `pos' "{bf:Too few changes to draw (under `minchg'):}""'
    foreach f of local few {
        local ++pos
        local ylab `"`ylab' `pos' "`f'""'
    }
    local ymax = `pos' + 0.5
}
* numbers for the notes (read from the data, never typed): province and "together" rows only
quietly count if rtype != 1 & !missing(lo_energy_va, hi_energy_va)
local K = r(N)
quietly count if rtype != 1 & !missing(lo_energy_va, hi_energy_va) & (lo_energy_va > 50 | hi_energy_va < 50)
local nmiss = r(N)
local nexp = max(1, round(`K' / 20))
quietly count if rtype == 3
local has3 = r(N) > 0
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
    replace refy = `lastrow' + 0.5 in `=`n0' + 2*`p''
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
* layers: 1 interval, 2 province, 3 island group, [4 together], labels, dashed line
local l3 ""
local k3 ""
local lref 5
if `has3' {
    * white-filled circle, thin black edge: stays hollow in the PDF and hides the interval line behind it
    local l3 "(scatter y pct if rtype == 3, msymbol(O) mfcolor(white) mlcolor(black) mlwidth(thin) msize(small))"
    local k3 `"4 "Smaller provinces together (each under `minchg' changes)""'
    local lref 6
}
twoway (rspike lo hi y, horizontal lcolor(black) lwidth(thin)) ///
    (scatter y pct if rtype == 2, msymbol(O) mcolor(black) msize(vsmall)) ///
    (scatter y pct if rtype == 1, msymbol(D) mcolor(black) msize(vsmall)) ///
    `l3' ///
    (scatter y labx, msymbol(none) mlabel(plab) mlabvposition(labp) mlabgap(0.6) mlabsize(vsmall) mlabcolor(gs5)) ///
    (line refy refx, lpattern(dash) lcolor(gs8) lwidth(thin)), ///
    by(panel, rows(1) graphregion(color(white) lcolor(white) ilcolor(white)) legend(pos(6)) scale(0.8125) ///
        title("Figure R3-09. Share of yearly changes in which energy and CO2 fell more (or rose less) than at the typical firm," ///
              "by province (codes only: the file has no names), grouped by island and sorted by panel (a)", size(small) pos(11) span) ///
        note("Notes: Each dot = share of the province's one-year changes that fell more or rose less than the typical (median) change of all firms that year." ///
             "50% = same as the typical firm; where the 95% interval crosses the dashed line, the row is not clearly different. Shows where, not why." ///
             "In (a), `nmiss' of `K' province rows are clearly different, against about `nexp' by chance. Island group = first digit: Sumatra 1–2, Java 3, other islands 5–9." ///
             "Firms that start high tend to fall back: in (c), `q5pct'% of changes from the top fifth of starting energy beat the typical change, `q1pct'% from the bottom fifth;" ///
             "so provinces whose firms start high look better, partly automatically (the table holds sector or starting level fixed). GJ = gigajoules." ///
             "VA = value added = output minus materials, energy and services bought (current prices). Province = code at the start of each change." ///
             "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6))) ///
    subtitle(, pos(11) nobox fcolor(white) lcolor(white) size(small)) ///
    yscale(reverse noline range(-0.3 `ymax')) ylabel(`ylab', angle(0) noticks tlength(0) nogrid labsize(vsmall)) ytitle("") ///
    xscale(range(`xlo' `xhi') lcolor(gs10)) ///
    xlabel(`=50 - `xs''(10)`=50 + `xs'', noticks tlength(0) labsize(vsmall) grid glcolor(gs15) glwidth(vthin)) ///
    xtitle("Changes that fell more or rose less than the typical firm's that year (% of the province's changes)", size(vsmall)) ///
    legend(order(2 "Province" 3 "Island group, all its provinces" `k3' 1 "95% interval" `lref' "50% = same as the typical firm") ///
        cols(3) region(lcolor(none)) size(vsmall) symxsize(8) keygap(1) colgap(6)) ///
    plotregion(style(none)) xsize(9.5) ysize(8)

graph export "figures/09_who_reduces_by_province.png", width(2850) replace
graph export "figures/09_who_reduces_by_province.pdf", replace
timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/09_who_reduces_by_province.png (elapsed `elapsed' s)"
quietly log close
