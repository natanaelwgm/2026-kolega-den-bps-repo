/*==========================================================================
  R1-08  Year by year, each group compared only with SIMILAR firms: firms of
         the same year, the same industry (2-digit code) and the same size
         band (workers). Do exporters, importers and foreign-owned firms use
         less energy and emit less CO2 per unit of value added than similar
         other firms, and does that gap change after the Paris Agreement
         (December 2015)? Drawn next to the same gap without matching, so the
         reader sees what matching changes.
  Answers Deasy R1: "Matching per year: export vs non export, import vs non
         import, fdi vs non fdi"; notes "karena kita gak bs tau first time
         exporting/importing/fdi nya, kita bs coba dengan method matching
         yearly.. dan dicompare bagaimana behaviour mereka toward energy use,
         emisi"; "Did internationally engaged firms change their
         environmental behaviour more strongly after the Paris Agreement?";
         outcomes "Gj/va", "Co2/va" (drawn) and "VA/energy use ... total",
         "VA/emisi ... total" (their reciprocals, in the table).
  Method : exact matching in cells. A cell = one year x one industry x one
         size band. Only cells holding both group firms and other firms are
         used. Each group firm is compared with the average of the other
         firms in its cell; these comparisons are averaged over the group's
         firms (so the answer is about the group's own firms). The 95% range
         comes from 999 redraws of whole firms, matching again every time.
         Foreign-owned = 10% or more of capital held abroad (fdi_10_flag),
         as in every R1-R3 exhibit.
  Output : figures/08_matched_gaps_by_year.png (+ .pdf)
           tables/08_matched_gaps_by_year.csv
  Runtime: under a minute (999 redraws for each of the three groupings).
  Built-in Stata only (the redraw arithmetic runs in Mata for speed), no add-ons.
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
global OUTDIR "/Users/natanaelmassie/Downloads/2026-kolega-den-bps-repo/20260917-run/block-r1-paris-internationalisation"
* ---------------------------------------------------------------------------
if `"`data_arg'"'   != "" global DATA   `"`data_arg'"'
if `"`outdir_arg'"' != "" global OUTDIR `"`outdir_arg'"'
cd "$OUTDIR"
foreach d in figures tables logs {
    capture mkdir "`d'"
}

* ---- THE DESIGN (why: INDEX.md, paragraph "08") ------------------------------------------
local bands      "50 100 250 500"          // size bands by workers: under 50, 50-99, 100-249, 250-499, 500+
local fine_bands "30 50 100 250 500 1000"  // finer bands, for a check column only
local before_yrs "2013 2014"   // "before Paris" = average of these years' gaps (as in R1-05 and R1-06)
local after_yr   2018          // "after Paris" = the one later year whose energy records look normal (R1-02 to R1-06)
local min_n      30            // a year's gap is shown only if 30+ group firms and 30+ other firms are matched
local reps       999           // redraws of whole firms (all their years) for the 95% ranges
* Years not drawn, and years drawn light gray, per grouping: the same years as R1-03 and R1-04
* (numbers stay in the table). Exporters: 2022 has no known non-exporters, found from the data.
local skip_export_flag ""
local flag_export_flag ""
local skip_import_flag "2017"
local skip_why_import_flag "importers' recorded energy jumps that year"
local flag_import_flag "2019 2020 2021 2022"
local skip_fdi_10_flag "2020"
local skip_why_fdi_10_flag "far more firms marked foreign-owned that year (likely a recording change)"
local flag_fdi_10_flag "2017 2019 2021 2022"
* -------------------------------------------------------------------------------------------

cap log close
log using "logs/08_matched_gaps_by_year.log", replace text
timer clear 1
timer on 1
display _newline "=== [R1-08] STARTING: each group vs similar firms (same year, industry and size), by year ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

display "Step 1/7: load the group flags, energy, CO2, value added, workers, industry and province"
* total_gj_s1 = energy in GJ (nine fuels + bought electricity); co2_total_s1 = CO2 in tonnes
* value_added_nominal = value added, current prices (masked money unit); workers = persons employed
use firm_id year export_flag import_flag fdi_10_flag total_gj_s1 co2_total_s1 value_added_nominal ///
    workers industry2_reported province_code using "$DATA", clear
isid firm_id year
assert year != 2016
assert inlist(export_flag, 0, 1, .) & inlist(import_flag, 0, 1, .) & inlist(fdi_10_flag, 0, 1, .)

display "Step 2/7: common sample, size bands and the two outcomes"
* One sample for both ratios (as in R1-02 to R1-04): energy, CO2 and value added above zero.
* A zero is dropped, not read as "no energy" (the energy fields cover only some fuels).
* Matching also needs the number of workers (above zero) and the industry code.
gen byte cs = total_gj_s1 > 0 & co2_total_s1 > 0 & value_added_nominal > 0 ///
            & !missing(total_gj_s1, co2_total_s1, value_added_nominal)
gen byte drop_zero = !cs
gen byte drop_size = cs & (missing(workers) | workers <= 0 | industry2_reported == "")
gen byte one = 1
preserve
collapse (sum) firms_in_year = one n_dropped_zero = drop_zero n_dropped_no_size = drop_size, by(year)
tempfile yearcounts
save `yearcounts'
restore
keep if cs & !drop_size
* size band 1 = under the first cut-off, 2 = next band, ...; the fine bands are only for a check column
gen byte size_band = 1
foreach c of local bands {
    replace size_band = size_band + 1 if workers >= `c'
}
gen byte size_fine = 1
foreach c of local fine_bands {
    replace size_fine = size_fine + 1 if workers >= `c'
}
gen double lw = ln(workers)
* Outcomes in logs of "per million of value added": a difference in logs is a ratio between firms,
* so one very large firm cannot dominate the average.
gen double y1 = ln(1e6 * total_gj_s1  / value_added_nominal)     // energy (GJ) per million of value added
gen double y2 = ln(1e6 * co2_total_s1 / value_added_nominal)     // CO2 (tonnes) per million of value added
gen byte knownx = !missing(export_flag)                          // export status known (check column)
keep firm_id year export_flag import_flag fdi_10_flag industry2_reported province_code size_band size_fine lw y1 y2 knownx
tempfile base
save `base'

* ---- the matched gap, in plain Stata (the redraws repeat it in Mata, further below) ----
* r108pt: one definition of "similar" (variable cell; missing = row not used) and one outcome y.
* For each year: every group firm (t = 1) minus the average of the other firms (t = 0) in its cell,
* averaged over the group firms whose cell also holds other firms (= the matched gap, in logs).
capture program drop r108pt
program define r108pt
    args y cell
    quietly {
        capture drop _in _n1 _n0 _s0 _m _d _gap _k1 _k0 _m1 _m0 _first _mc
        gen byte _in = !missing(`y', `cell')
        sort year `cell'
        by year `cell': gen double _n1 = sum(_in * t)
        by year `cell': gen double _n0 = sum(_in * (1 - t))
        by year `cell': gen double _s0 = sum(cond(_in & t == 0, `y', 0))
        by year `cell': replace _n1 = _n1[_N]
        by year `cell': replace _n0 = _n0[_N]
        by year `cell': replace _s0 = _s0[_N]
        gen byte _m = _in & _n1 > 0 & _n0 > 0                 // row in a cell that holds both kinds of firm
        gen double _d = `y' - _s0 / _n0 if _m & t == 1         // group firm minus its cell's other-firm average
        by year: egen double _gap = mean(_d)
        by year: egen _k1 = total(_in * t)                     // group firms with a known answer and the outcome
        by year: egen _k0 = total(_in * (1 - t))
        by year: egen _m1 = total(_m * t)                      // ... of which matched
        by year: egen _m0 = total(_m * (1 - t))
        by year `cell': gen byte _first = _n == 1 & _m
        by year: egen _mc = total(_first)                      // cells used
    }
end
* The 95% ranges need the matched gap about 1,000 times per grouping, so that arithmetic is
* written once more in Mata (built into Stata) for speed. It is the same calculation as r108pt:
* redraw 0 (the actual data) is checked against r108pt in Step 4.
mata:
// Matched and unmatched gaps (in logs) for every year, given weights fw (times each row counts).
// Rows are sorted by c_main (cell = year x industry x size band), so also by year.
real matrix r108gaps(real colvector fw, real colvector t, real colvector y1, real colvector y2,
                     real colvector c, real matrix ci, real matrix yi)
{
    real colvector w1, w0, n0, a0, b0, ok, k, da, db
    real matrix out
    w1 = fw :* t                          // weight of each group firm
    w0 = fw :* (1 :- t)                   // weight of each other firm
    n0 = panelsum(w0, ci)[c]              // other firms in the row's cell
    a0 = panelsum(w0 :* y1, ci)[c]        // ... their summed outcome 1
    b0 = panelsum(w0 :* y2, ci)[c]        // ... their summed outcome 2
    ok = n0 :> 0                          // the cell also holds other firms
    n0 = n0 + (1 :- ok)                   // no division by zero (those rows get weight 0 below)
    k  = w1 :* ok                         // matched group firms
    da = k :* (y1 - a0 :/ n0)             // group firm minus its cell's other-firm average
    db = k :* (y2 - b0 :/ n0)
    out = J(rows(yi), 4, .)
    out[., 1] = panelsum(da, yi) :/ panelsum(k, yi)
    out[., 2] = panelsum(db, yi) :/ panelsum(k, yi)
    out[., 3] = panelsum(w1 :* y1, yi) :/ panelsum(w1, yi) - panelsum(w0 :* y1, yi) :/ panelsum(w0, yi)
    out[., 4] = panelsum(w1 :* y2, yi) :/ panelsum(w1, yi) - panelsum(w0 :* y2, yi) :/ panelsum(w0, yi)
    return(out)
}
// Redraw 0 = the actual data. Redraws 1..reps: as many firms as there are, drawn at random with
// replacement; each firm brings all its years (what -bsample, cluster(firm_id)- does).
// Result (rep, year, matched energy, matched CO2, unmatched energy, unmatched CO2) -> R108RES.
void r108boot(real scalar reps)
{
    external real matrix R108RES
    real colvector t, y1, y2, c, yr, f, fw, d, cnt
    real matrix ci, yi
    real scalar F, r, i, ny
    t  = st_data(., "t")
    y1 = st_data(., "y1")
    y2 = st_data(., "y2")
    c  = st_data(., "c_main")
    yr = st_data(., "year")
    f  = st_data(., "fid")
    ci = panelsetup(c, 1)
    yi = panelsetup(yr, 1)
    ny = rows(yi)
    F  = max(f)
    R108RES = J((reps + 1) * ny, 6, .)
    for (r = 0; r <= reps; r++) {
        if (r == 0) fw = J(rows(f), 1, 1)
        else {
            d = ceil(runiform(F, 1) :* F)                    // the firms drawn
            cnt = J(F, 1, 0)
            for (i = 1; i <= F; i++) cnt[d[i]] = cnt[d[i]] + 1
            fw = cnt[f]                                      // each row counts as often as its firm was drawn
        }
        R108RES[(r * ny + 1)::((r + 1) * ny), .] = (J(ny, 1, r), yr[yi[., 1]], r108gaps(fw, t, y1, y2, c, ci, yi))
    }
}
end

display "Step 3/7: matched and unmatched gaps for every year, with counts and checks"
tempfile pts draws d_export_flag d_import_flag d_fdi_10_flag
tempname hp hd
postfile `hp' str12 grouping byte outcome_id str10 design int year double gap ///
    long(n_grp_known n_other_known n_grp_matched n_other_matched n_cells_matched) ///
    double(n_other_effective wk_grp_all wk_other_all wk_grp_matched wk_other_matched) using `pts', replace
foreach g in export_flag import_flag fdi_10_flag {
    use `base', clear
    keep if !missing(`g')                   // unknown status left out
    gen byte t = `g'
    * the cells for every meaning of "similar" (the main one first; the others are checks)
    egen long c_main = group(year industry2_reported size_band)
    gen  long c_unm  = year                                          // not matched: all firms of the year
    egen long c_ind  = group(year industry2_reported)                // check: industry only
    egen long c_size = group(year size_band)                         // check: size only
    egen long c_prov = group(year industry2_reported size_band province_code)   // check: also same province
    egen long c_fine = group(year industry2_reported size_fine)      // check: finer size bands
    egen long c_knownx = group(year industry2_reported size_band) if knownx     // check: known export status only
    foreach o in 1 2 {
        foreach d in main unm ind size prov fine knownx {
            r108pt y`o' c_`d'
            * main design only: how many other firms really count (uneven weights) and typical sizes
            foreach v in ne wg wa w1 w0 {
                quietly gen double _`v' = .
            }
            if "`d'" == "main" {
                quietly gen double _w = cond(t == 1, 1, _n1 / _n0) if _m   // other firms share their cell's group weight
                quietly by year: egen double _sw  = total(cond(t == 0 & _m, _w, 0))
                quietly by year: egen double _sw2 = total(cond(t == 0 & _m, _w^2, 0))
                quietly by year: egen double _swl = total(cond(t == 0 & _m, _w * lw, 0))
                quietly by year: egen double _sl1 = total(cond(t == 1 & _m, lw, 0))
                quietly by year: egen double _slg = total(cond(t == 1 & _in, lw, 0))
                quietly by year: egen double _slo = total(cond(t == 0 & _in, lw, 0))
                quietly replace _ne = _sw^2 / _sw2            // effective number of other firms
                quietly replace _wg = exp(_slg / _k1)         // typical (geometric-mean) workers: all group firms
                quietly replace _wa = exp(_slo / _k0)         // ... all other firms
                quietly replace _w1 = exp(_sl1 / _m1)         // ... matched group firms
                quietly replace _w0 = exp(_swl / _sw)         // ... their similar firms (weighted)
                drop _w _sw _sw2 _swl _sl1 _slg _slo
            }
            preserve
            quietly collapse (first) _gap _k1 _k0 _m1 _m0 _mc _ne _wg _wa _w1 _w0, by(year)
            forvalues i = 1/`=_N' {
                * a gap is kept only if both kinds of firm reach min_n after matching
                local gp = cond(_m1[`i'] >= `min_n' & _m0[`i'] >= `min_n', _gap[`i'], .)
                post `hp' ("`g'") (`o') ("`d'") (year[`i']) (`gp') (_k1[`i']) (_k0[`i']) (_m1[`i']) (_m0[`i']) ///
                    (_mc[`i']) (_ne[`i']) (_wg[`i']) (_wa[`i']) (_w1[`i']) (_w0[`i'])
            }
            restore
            drop _ne _wg _wa _w1 _w0
        }
    }
    * ---- 95% ranges: redraw whole firms (with all their years) and match again, reps times ----
    quietly keep firm_id year t y1 y2 c_main
    egen long fid = group(firm_id)                  // firm number 1, 2, ... for the redraws
    sort c_main firm_id                             // cells in order (so also years)
    set seed 20260925
    mata: r108boot(`reps')
    preserve
    clear
    getmata (rep year gm1 gm2 gu1 gu2) = R108RES
    gen str12 grouping = "`g'"
    save `d_`g'', replace
    restore
    display "   `g' done"
}
postclose `hp'
use `d_export_flag', clear
append using `d_import_flag' `d_fdi_10_flag'
save `draws'

display "Step 4/7: 95% ranges and the before/after-Paris change from the redraws"
use `draws', clear
* rep 0 (the actual data) must equal the point estimates of Step 3 (two separate calculations)
preserve
use `pts', clear
keep if inlist(design, "main", "unm")
keep grouping outcome_id design year gap
reshape wide gap, i(grouping outcome_id year) j(design) string
reshape wide gapmain gapunm, i(grouping year) j(outcome_id)
tempfile p0
save `p0'
restore
merge m:1 grouping year using `p0', nogenerate
assert reldif(gm1, gapmain1) < 1e-9 & reldif(gm2, gapmain2) < 1e-9 if rep == 0 & !missing(gapmain1)
assert reldif(gu1, gapunm1)  < 1e-9 & reldif(gu2, gapunm2)  < 1e-9 if rep == 0 & !missing(gapunm1)
* years whose gap is not shown (too few matched firms) have no range either
foreach v in gm1 gm2 {
    replace `v' = . if missing(gapmain`=substr("`v'", 3, 1)')
}
foreach v in gu1 gu2 {
    replace `v' = . if missing(gapunm`=substr("`v'", 3, 1)')
}
drop gapmain* gapunm*
tempfile dr
save `dr'
* (a) the yearly ranges: 2.5th and 97.5th percentiles of the redraws (percentile method)
drop if rep == 0
foreach v in m1 m2 u1 u2 {
    bysort grouping year: egen double lo_`v' = pctile(g`v'), p(2.5)
    by grouping year: egen double hi_`v' = pctile(g`v'), p(97.5)
}
collapse (first) lo_* hi_*, by(grouping year)
reshape long lo_m hi_m lo_u hi_u, i(grouping year) j(outcome_id)
tempfile ranges
save `ranges'
* (b) before vs after Paris, per redraw: gap = 100 x exp(average log gap over the years of each window)
use `dr', clear
gen byte pre_main = 0
foreach yr of local before_yrs {
    replace pre_main = 1 if year == `yr'
}
gen byte post_main = year == `after_yr'
gen byte pre_all  = year < 2015
* solid later years for each grouping: not skipped, not light gray, with a gap
gen byte post_all = year > 2015 & !missing(gm1)
foreach g in export_flag import_flag fdi_10_flag {
    foreach yr in `skip_`g'' `flag_`g'' {
        replace post_all = 0 if grouping == "`g'" & year == `yr'
    }
}
tempfile ba
tempname hb
postfile `hb' str12 grouping byte outcome_id str8 window str60 before_yrs str60 after_yrs ///
    double(before_pct after_pct change_pts change_lo95 change_hi95 before_pct_unm after_pct_unm ///
    change_pts_unm change_lo95_unm change_hi95_unm) using `ba', replace
foreach g in export_flag import_flag fdi_10_flag {
    foreach win in main all {
        quietly levelsof year if grouping == "`g'" & rep == 0 & pre_`win' & !missing(gm1), local(byrs)
        quietly levelsof year if grouping == "`g'" & rep == 0 & post_`win' & !missing(gm1), local(ayrs)
        foreach o in 1 2 {
            preserve
            quietly keep if grouping == "`g'" & (pre_`win' | post_`win') & !missing(gm`o')
            quietly gen byte after = post_`win'
            quietly collapse (mean) m = gm`o' u = gu`o', by(rep after)
            quietly reshape wide m u, i(rep) j(after)
            quietly gen double chm = 100 * exp(m1) - 100 * exp(m0)      // change in points, matched
            quietly gen double chu = 100 * exp(u1) - 100 * exp(u0)      // change in points, not matched
            quietly _pctile chm if rep > 0, p(2.5 97.5)
            local ml = r(r1)
            local mh = r(r2)
            quietly _pctile chu if rep > 0, p(2.5 97.5)
            local ul = r(r1)
            local uh = r(r2)
            post `hb' ("`g'") (`o') ("`win'") ("`byrs'") ("`ayrs'") (100 * exp(m0[1])) (100 * exp(m1[1])) (chm[1]) ///
                (`ml') (`mh') (100 * exp(u0[1])) (100 * exp(u1[1])) (chu[1]) (`ul') (`uh')
            restore
        }
    }
}
postclose `hb'

display "Step 5/7: table -> CSV (numbers written before drawing)"
use `pts', clear
keep grouping outcome_id design year gap n_* wk_*
reshape wide gap n_grp_known n_other_known n_grp_matched n_other_matched n_cells_matched ///
    n_other_effective wk_grp_all wk_other_all wk_grp_matched wk_other_matched, i(grouping outcome_id year) j(design) string
rename (gapmain gapunm) (lgap lgap_unm)
rename (n_grp_knownmain n_other_knownmain n_grp_matchedmain n_other_matchedmain n_cells_matchedmain) ///
       (n_grp_known n_other_known n_grp_matched n_other_matched n_cells_matched)
rename (n_other_effectivemain wk_grp_allmain wk_other_allmain wk_grp_matchedmain wk_other_matchedmain) ///
       (n_other_effective wk_grp_all wk_other_all wk_grp_matched wk_other_matched)
rename n_grp_matchedknownx n_grp_matched_knownx
foreach d in ind size prov fine knownx {
    gen double chk_`d'_pct = 100 * exp(gap`d')
}
merge 1:1 grouping year outcome_id using `ranges', nogenerate
* from logs to "group as % of similar firms" (100 = same)
gen double gap_pct      = 100 * exp(lgap)
gen double gap_lo95     = 100 * exp(lo_m) if !missing(lgap)
gen double gap_hi95     = 100 * exp(hi_m) if !missing(lgap)
gen double gap_unm_pct  = 100 * exp(lgap_unm)
gen double gap_unm_lo95 = 100 * exp(lo_u) if !missing(lgap_unm)
gen double gap_unm_hi95 = 100 * exp(hi_u) if !missing(lgap_unm)
gen double gap_va_per_unit_pct = 1e4 / gap_pct   // Deasy's "VA/energy use", "VA/emisi": the same gap upside down
gen byte clear = gap_lo95 > 100 | gap_hi95 < 100 if !missing(gap_pct)
gen double pct_grp_matched = 100 * n_grp_matched / n_grp_known
keep grouping outcome_id year gap_pct gap_lo95 gap_hi95 clear gap_va_per_unit_pct gap_unm_pct gap_unm_lo95 ///
     gap_unm_hi95 chk_*_pct n_grp_known n_other_known n_grp_matched pct_grp_matched n_other_matched ///
     n_other_effective n_cells_matched n_grp_matched_knownx wk_grp_all wk_other_all wk_grp_matched wk_other_matched
* empty 2016 rows (no annual file), one per grouping x outcome
preserve
keep grouping outcome_id
duplicates drop
gen int year = 2016
tempfile y16
save `y16'
restore
append using `y16'
merge m:1 year using `yearcounts', nogenerate
gen byte annual_file = year != 2016
* what is drawn: solid / light gray / not drawn / no comparison
gen str40 plot_status = ""
replace plot_status = "no annual file" if !annual_file
replace plot_status = "no comparison" if annual_file & missing(gap_pct)
replace plot_status = "solid" if annual_file & !missing(gap_pct)
foreach g in export_flag import_flag fdi_10_flag {
    foreach yr of local skip_`g' {
        replace plot_status = "not drawn" if grouping == "`g'" & year == `yr' & plot_status == "solid"
    }
    foreach yr of local flag_`g' {
        replace plot_status = "light gray: records in doubt" if grouping == "`g'" & year == `yr' & plot_status == "solid"
    }
}
gen str100 note = ""
replace note = "No annual file" if !annual_file
replace note = "No comparison: no known other firms" if plot_status == "no comparison" & n_other_known == 0
replace note = "No comparison: fewer than `min_n' matched firms in a group" if plot_status == "no comparison" & n_other_known > 0
foreach g in import_flag fdi_10_flag {
    replace note = "Not drawn: `skip_why_`g''" if grouping == "`g'" & plot_status == "not drawn"
}
replace note = "Drawn light gray: many firms' energy records jump or drop far from other years" ///
    if plot_status == "light gray: records in doubt"
gen str12 row_type = "year"
append using `ba'
replace row_type = "before_after" if row_type == ""
gen byte change_clear     = change_lo95 > 0 | change_hi95 < 0 if row_type == "before_after"
gen byte change_clear_unm = change_lo95_unm > 0 | change_hi95_unm < 0 if row_type == "before_after"
replace note = "Before = average of the yearly gaps (in logs) over before_yrs; after = same over after_yrs; change = after minus before, in points" ///
    if row_type == "before_after"
* labels
gen str30 grp1_label = cond(grouping == "export_flag", "Exporters", cond(grouping == "import_flag", "Importers", "Foreign-owned (10%+)"))
gen str30 grp0_label = cond(grouping == "export_flag", "Non-exporters", cond(grouping == "import_flag", "Non-importers", "Other firms"))
gen str60 outcome = cond(outcome_id == 1, "Energy (GJ) per million of value added, total", ///
                                          "CO2 (tonnes) per million of value added, total")
gen str60 deasy_item = cond(outcome_id == 1, "Gj/va; VA/energy use total (reciprocal)", "Co2/va; VA/emisi total (reciprocal)")
gen byte gi = cond(grouping == "export_flag", 1, cond(grouping == "import_flag", 2, 3))
gen byte ri = row_type == "before_after"
sort gi outcome_id ri year window
* structural checks
assert gap_lo95 <= gap_pct & gap_pct <= gap_hi95 if !missing(gap_pct)
assert gap_unm_lo95 <= gap_unm_pct & gap_unm_pct <= gap_unm_hi95 if !missing(gap_unm_pct)
assert n_grp_matched <= n_grp_known & n_other_matched <= n_other_known if row_type == "year" & annual_file
assert n_grp_matched_knownx <= n_grp_matched if row_type == "year" & annual_file
assert reldif(change_pts, after_pct - before_pct) < 1e-9 if row_type == "before_after"
assert plot_status != "solid" if n_other_known == 0 & row_type == "year" & annual_file
order grouping grp1_label grp0_label outcome_id outcome deasy_item row_type year annual_file plot_status ///
      firms_in_year n_dropped_zero n_dropped_no_size n_grp_known n_other_known n_grp_matched pct_grp_matched ///
      n_other_matched n_other_effective n_cells_matched gap_pct gap_lo95 gap_hi95 clear gap_va_per_unit_pct ///
      gap_unm_pct gap_unm_lo95 gap_unm_hi95 chk_ind_pct chk_size_pct chk_prov_pct chk_fine_pct chk_knownx_pct ///
      n_grp_matched_knownx wk_grp_all wk_other_all wk_grp_matched wk_other_matched ///
      window before_yrs after_yrs before_pct after_pct change_pts change_lo95 change_hi95 change_clear ///
      before_pct_unm after_pct_unm change_pts_unm change_lo95_unm change_hi95_unm change_clear_unm note
format firms_in_year n_dropped_* n_grp_* n_other_known n_other_matched n_cells_matched %9.0f
format n_other_effective wk_* %9.1f
format gap_* chk_* pct_grp_matched before_pct* after_pct* change_pts* change_lo* change_hi* %8.2f
export delimited grouping-note using "tables/08_matched_gaps_by_year.csv", datafmt replace
list grouping outcome_id year n_grp_matched gap_pct gap_lo95 gap_hi95 gap_unm_pct if row_type == "year" & annual_file, ///
    noobs sepby(grouping outcome_id) abbreviate(24)
list grouping outcome_id window before_pct after_pct change_pts change_lo95 change_hi95 change_pts_unm ///
    change_lo95_unm change_hi95_unm if row_type == "before_after", noobs sepby(grouping) abbreviate(24)
display "   CHECK ON REAL DATA: the years not drawn / light gray (design block) were chosen on the development files (R1-03, R1-04); confirm they still look wrong before publishing"

display "Step 6/7: numbers for the notes, read from the table (never typed)"
* share of each group's firms that find similar firms, over the years drawn
quietly summarize pct_grp_matched if row_type == "year" & outcome_id == 1 & inlist(plot_status, "solid", "light gray: records in doubt")
local m_lo = floor(r(min))
local m_hi = floor(r(max))
local mrate = cond(`m_lo' == `m_hi', "`m_lo'%", "`m_lo'–`m_hi'%")
local nbd : word count `bands'
local c1 : word 1 of `bands'
local band_txt "under `c1'"
forvalues i = 2/`nbd' {
    local lo : word `=`i'-1' of `bands'
    local hi : word `i' of `bands'
    local band_txt "`band_txt', `lo'–`=`hi'-1'"
}
local cl : word `nbd' of `bands'
local band_txt "`band_txt', `cl'+ workers"
* the before years as text, "2013–14" style
local nb : word count `before_yrs'
local b1 : word 1 of `before_yrs'
local bl : word `nb' of `before_yrs'
local before_txt = cond(`nb' == 1, "`b1'", "`b1'–" + substr("`bl'", 3, 2))
* the wider before/after window (every year before 2015 vs every solid later year): panels where the change is clear
local aclr ""
forvalues p = 1/6 {
    local gg = word("export_flag import_flag fdi_10_flag", ceil(`p' / 2))
    local oo = 2 - mod(`p', 2)
    quietly count if row_type == "before_after" & window == "all" & grouping == "`gg'" & outcome_id == `oo' & change_clear == 1
    if r(N) > 0 local aclr "`aclr' (`=word("a b c d e f", `p')')"
}
local nw : word count `aclr'
local alist ""
forvalues i = 1/`nw' {
    local sep = cond(`i' == 1, "", cond(`i' == `nw', " and ", ", "))
    local alist "`alist'`sep'`=word("`aclr'", `i')'"
}
local aclr "`alist'"
if "`aclr'" == "" local atxt "it is clear in no panel"
else local atxt = "it is clear in " + cond(`nw' == 1, "panel ", "panels ") + "`aclr'"
* a check, not a headline: printed here and kept in the table (window "all"), not in the figure notes
display "   check: comparing all years before 2015 with all solid later years, `atxt'"
local ntext "Notes: Each year, each exporter (importer, foreign-owned firm) is compared only with other firms of the same industry (2-digit code) and size (`band_txt'); `mrate' of each group's firms have such firms. Diamond = the typical group firm's energy or CO2 per unit of value added as % of its similar firms' (line = 95% range; crossing 100 = no clear difference). Typical = an average in which a firm at half and one at double cancel out, not the middle firm used in R1-02 to R1-04, so the circles can differ from those charts. Top right: the diamond before Paris (average of `before_txt') and in `after_yr'; change in points (95% range; gray = not clear). Energy = GJ of fuels and bought electricity; value added = output value minus materials, energy and services bought, at current prices. Importers `skip_import_flag' (energy records jump) and foreign-owned `skip_fdi_10_flag' (far more firms so marked) not drawn; light gray = many firms' energy records jump or drop, likely a recording problem. Foreign-owned = 10%+ of capital held abroad; unknown status is left out. Firms differ each year (none is followed) and matching evens out only size and industry: this shows differences, not their cause."
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

display "Step 7/7: draw: one row per grouping, energy left, CO2 right, one shared scale"
* the before/after text for each panel (matched, main window)
preserve
keep if row_type == "before_after" & window == "main" & outcome_id <= 2
gen str40 t1 = "`before_txt': " + string(before_pct, "%9.0f") + "; `after_yr': " + string(after_pct, "%9.0f")
* hyphen-minus, not U+2212: the PDF font may not carry the minus sign
gen str60 t2 = "change " + cond(round(change_pts) > 0, "+", "") + string(round(change_pts), "%9.0f") + " (" ///
    + string(round(change_lo95), "%9.0f") + " to " + cond(round(change_hi95) > 0, "+", "") + string(round(change_hi95), "%9.0f") + ")"
rename change_clear tclear
keep grouping outcome_id t1 t2 tclear
tempfile txt
save `txt'
restore
keep if row_type == "year" & outcome_id <= 2
merge m:1 grouping outcome_id using `txt', nogenerate
gen byte panel = 2 * (gi - 1) + outcome_id
label define panel 1 "(a) Exporters: energy per value added"     2 "(b) Exporters: CO2 per value added" ///
                   3 "(c) Importers: energy per value added"     4 "(d) Importers: CO2 per value added" ///
                   5 "(e) Foreign-owned: energy per value added" 6 "(f) Foreign-owned: CO2 per value added"
label values panel panel
gen byte drawn   = plot_status == "solid"
gen byte flagged = plot_status == "light gray: records in doubt"
gen double g   = gap_pct     if drawn
gen double glo = gap_lo95    if drawn
gen double ghi = gap_hi95    if drawn
gen double u   = gap_unm_pct if drawn
gen double gf   = gap_pct     if flagged
gen double glof = gap_lo95    if flagged
gen double ghif = gap_hi95    if flagged
gen double uf   = gap_unm_pct if flagged
gen double ref = 100
* one shared scale for all six panels; the top leaves room for two lines of text above the highest mark
egen double pmax = rowmax(ghi ghif u uf)
quietly summarize pmax
local top  = 25 * ceil(max(r(max) + 45, r(max) / 0.8) / 25)   // text sits at 87-97% of the top, so keep 20% free
local ytop = 50 * floor(`top' / 50)          // highest labelled tick
display "   shared y scale: 0 to `top'"
* endpoint labels: first and last year drawn (solid or light gray), higher mark labelled above
gen byte any = drawn | flagged
bysort panel: egen fy = min(cond(any, year, .))
bysort panel: egen ly = max(cond(any, year, .))
gen double gg = cond(drawn, g, gf)
gen double uu = cond(drawn, u, uf)
gen str8 lg  = string(gg, "%9.0f") if inlist(year, fy, ly) & drawn
gen str8 lu  = string(uu, "%9.0f") if inlist(year, fy, ly) & drawn
gen str8 lgf = string(gg, "%9.0f") if inlist(year, fy, ly) & flagged
gen str8 luf = string(uu, "%9.0f") if inlist(year, fy, ly) & flagged
gen byte pg = cond(year == fy, cond(gg >= uu, 10, 8), cond(gg >= uu, 2, 4))
gen byte pu = cond(year == fy, cond(uu >  gg, 10, 8), cond(uu >  gg, 2, 4))
* before/after text, top right of each panel, after the Paris line (black = clear change, gray = not clear)
gen double tx  = 2016.6 if year == 2010
gen double ty1 = 0.965 * `top' if year == 2010
gen double ty2 = 0.87 * `top' if year == 2010
* top left: years with no comparison or not drawn, for that row (two short lines at most)
gen str40 lt1 = ""
gen str40 lt2 = ""
forvalues p = 1/6 {
    local r1 ""
    local r2 ""
    quietly levelsof year if panel == `p' & plot_status == "not drawn", local(nd)
    foreach yr of local nd {
        local r1 = strtrim("`r1' `yr' not drawn")
    }
    quietly levelsof grp0_label if panel == `p', local(g0l) clean
    quietly levelsof year if panel == `p' & plot_status == "no comparison" & n_other_known == 0, local(nc)
    foreach yr of local nc {
        local r1 = strtrim("`r1' `yr': no known")
        local r2 = lower("`g0l'")
    }
    replace lt1 = "`r1'" if panel == `p' & year == 2010
    replace lt2 = "`r2'" if panel == `p' & year == 2010
}
gen double lx  = 2008.8 if year == 2010
gen double ly1 = 0.965 * `top' if year == 2010
gen double ly2 = 0.87 * `top' if year == 2010
* 2016 band and Paris line (end of 2015)
gen double band = `top' if year == 2016
gen double px  = 2015.5 if year == 2016
gen double plo = 0 if year == 2016
gen double phi = `top' if year == 2016

sort panel year
twoway (bar band year, barwidth(0.8) color(gs14) lwidth(none) base(0)) ///
    (rspike phi plo px, lcolor(gs4) lpattern(shortdash) lwidth(thin)) ///
    (line ref year, lcolor(gs8) lwidth(thin) lpattern(solid)) ///
    (connected u year, cmissing(n) lcolor(gs10) lpattern(shortdash) lwidth(thin) msymbol(Oh) msize(small) mcolor(gs7) ///
        mlabel(lu) mlabvposition(pu) mlabsize(vsmall) mlabcolor(gs7)) ///
    (rspike ghi glo year, lcolor(black) lwidth(thin)) ///
    (scatter g year, msymbol(D) msize(small) mcolor(black) mlabel(lg) mlabvposition(pg) mlabsize(vsmall) mlabcolor(black)) ///
    (rspike ghif glof year, lcolor(gs11) lwidth(thin)) ///
    (scatter gf year, msymbol(Dh) msize(small) mcolor(gs9) mlabel(lgf) mlabvposition(pg) mlabsize(vsmall) mlabcolor(gs8)) ///
    (scatter uf year, msymbol(Oh) msize(small) mcolor(gs12) mlabel(luf) mlabvposition(pu) mlabsize(vsmall) mlabcolor(gs10)) ///
    (scatter ty1 tx if tclear == 1, msymbol(none) mlabel(t1) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter ty2 tx if tclear == 1, msymbol(none) mlabel(t2) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter ty1 tx if tclear == 0, msymbol(none) mlabel(t1) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(gs9)) ///
    (scatter ty2 tx if tclear == 0, msymbol(none) mlabel(t2) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(gs9)) ///
    (scatter ly1 lx, msymbol(none) mlabel(lt1) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(gs6)) ///
    (scatter ly2 lx, msymbol(none) mlabel(lt2) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(gs6)), ///
    by(panel, cols(2) graphregion(color(white) lcolor(white) ilcolor(white)) legend(pos(6)) ///
        title("Figure R1-08. Energy and CO2 per unit of value added, each group vs similar firms", size(small) pos(11) span) ///
        note(`notelines' "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6))) ///
    subtitle(, pos(11) nobox fcolor(white) lcolor(white) size(small)) ///
    ylabel(0(50)`ytop', angle(0) noticks tlength(0) grid glcolor(gs15) glwidth(vthin) labsize(vsmall) format(%9.0f)) ///
    yscale(noline range(0 `top')) ytitle("Group as % of the firms compared (100 = same)", size(vsmall)) ///
    xlabel(2010(2)2022, noticks tlength(0) labsize(vsmall)) xscale(range(2008.6 2023.6) lcolor(gs10)) xtitle("") ///
    legend(order(6 "Matched with similar firms (line = 95% range)" 4 "Not matched: all other firms" ///
                 8 "Matched: records in doubt (see notes)" 9 "Not matched: records in doubt" ///
                 2 "Paris Agreement adopted (December 2015)" 3 "100 = same as the firms compared" 1 "No annual file") ///
        cols(2) region(lcolor(none)) size(vsmall) symxsize(6) keygap(1) colgap(4) rowgap(0.3)) ///
    plotregion(style(none)) xsize(8) ysize(11.5)

graph export "figures/08_matched_gaps_by_year.png", width(2400) replace
graph export "figures/08_matched_gaps_by_year.pdf", replace
timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/08_matched_gaps_by_year.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
