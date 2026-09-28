/*==========================================================================
  R1-06  Groups frozen before Paris, followed year by year. Each firm is put
         into a group ONCE, from its 2013-14 records (exporter or not,
         importer or not, 10%+ foreign-owned or not). How do the energy and
         CO2 per unit of value added of each frozen group move from 2010 to
         2022, measured against the group's own 2013-14 level (= 100), and
         did the internationalised groups move differently after the Paris
         Agreement (December 2015)?
  Answers Deasy R1: "Alternative: Freeze internationalisation status
         sebelum Paris, misalnya average 2013-14: pre exporters x year;
         2015 transition year; 2016+ post"; "Did internationally engaged
         firms change their environmental behaviour more strongly after the
         Paris Agreement?"; outcomes "Gj/va", "Co2/va" (drawn) and
         "Energi use ... total" (table only).
  Foreign-owned = 10% or more of the firm's capital held abroad
         (fdi_10_flag), the definition used in every R1-R3 exhibit.
  Output : figures/06_frozen_pre_paris_groups.png (+ .pdf)
           tables/06_frozen_pre_paris_groups.csv
           tables/06_frozen_pre_paris_groups_table.pdf (every plotted point)
  Runtime: about 2 minutes (999 random redraws of firms for each grouping, main and stricter groups).
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

* ---- THE DESIGN (why: INDEX.md, paragraph "06") ------------------------------------------
local base_yrs "2013 2014"   // Deasy's "average 2013-14": status frozen from these years; also the base (= 100)
local rule_min 0.5           // in the group if flagged in at least half of its known 2013-14 years
local post_yr  2018          // the after-Paris year printed on the chart: the one later year whose energy
                             // records look normal (R1-02 to R1-05); every later year is in the table
local skip_yrs "2017"        // not drawn: energy records jump that year (numbers stay in the table)
local flag_yrs "2019 2020 2021 2022"   // drawn light gray: many energy records drop far below earlier years
local min_n    30            // a group-year median is used only if at least 30 firms have it
local reps     999           // random redraws of firms (each firm with all its years), for the 95% ranges
* -------------------------------------------------------------------------------------------

cap log close
log using "logs/06_frozen_pre_paris_groups.log", replace text
timer clear 1
timer on 1
display _newline "=== [R1-06] STARTING: groups frozen by their 2013-14 status, followed 2010-2022 ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

display "Step 1/8: load the three group flags, energy, CO2 and value added"
* total_gj_s1 = energy in GJ (nine fuels + bought electricity); co2_total_s1 = CO2 in tonnes
* value_added_nominal = value added, current prices (masked money unit)
use firm_id year export_flag import_flag fdi_10_flag total_gj_s1 co2_total_s1 value_added_nominal ///
    using "$DATA", clear
isid firm_id year
assert year != 2016
assert inlist(export_flag, 0, 1, .) & inlist(import_flag, 0, 1, .) & inlist(fdi_10_flag, 0, 1, .)
local base_in = subinstr("`base_yrs'", " ", ",", .)

display "Step 2/8: freeze each firm's status from its 2013-14 records"
* A firm's frozen status uses ONLY its 2013 and 2014 records:
*   in the group  = flagged (1) in at least half of the 2013-14 years whose answer is known
*                   (so one of two years is enough; a firm seen in one year keeps that year's answer);
*   other firms   = never flagged in its known 2013-14 years;
*   left out      = no 2013 or 2014 record at all, or no known answer in them (counted, never "no").
gen byte base = inlist(year, `base_in')
bysort firm_id: egen byte nbase = total(base)            // 0, 1 or 2 records in 2013-14
foreach g in export_flag import_flag fdi_10_flag {
    bysort firm_id: egen byte k_`g' = total(base & !missing(`g'))    // known answers in 2013-14
    bysort firm_id: egen byte s_`g' = total(base & `g' == 1)         // of which "yes"
    gen byte fz_`g' = s_`g' / k_`g' >= `rule_min' if k_`g' > 0
    * stricter check (table and notes only): in the group only if flagged in EVERY known 2013-14 year;
    * firms flagged in one of their two known years ("mixed") are left out; other firms are unchanged
    gen byte fzs_`g' = cond(k_`g' == 0, ., cond(s_`g' == k_`g', 1, cond(s_`g' == 0, 0, .)))
}
* firm counts per grouping, for the table and the notes
egen byte firm1 = tag(firm_id)
tempname hc
tempfile fcounts
postfile `hc' str12 grouping long(firms_all firms_no_base firms_unknown firms_g1 firms_g0 firms_g1_mixed ///
    firms_g1_one_year) using `fcounts', replace
foreach g in export_flag import_flag fdi_10_flag {
    quietly count if firm1
    local a = r(N)
    quietly count if firm1 & nbase == 0
    local nb = r(N)
    quietly count if firm1 & nbase > 0 & k_`g' == 0
    local un = r(N)
    quietly count if firm1 & fz_`g' == 1
    local f1 = r(N)
    quietly count if firm1 & fz_`g' == 0
    local f0 = r(N)
    quietly count if firm1 & fz_`g' == 1 & s_`g' < k_`g'
    local mx = r(N)
    quietly count if firm1 & fz_`g' == 1 & k_`g' == 1
    local oy = r(N)
    assert `a' == `nb' + `un' + `f1' + `f0'
    post `hc' ("`g'") (`a') (`nb') (`un') (`f1') (`f0') (`mx') (`oy')
    display "   `g': in group `f1', other firms `f0', left out: no 2013-14 record `nb', unknown answer `un'"
}
postclose `hc'

display "Step 3/8: outcomes per firm and year"
* One sample for all outcomes: energy, CO2 and value added above zero (as R1-02 to R1-04).
gen byte cs = total_gj_s1 > 0 & co2_total_s1 > 0 & value_added_nominal > 0 ///
            & !missing(total_gj_s1, co2_total_s1, value_added_nominal)
gen double o1 = 1e6 * total_gj_s1  / value_added_nominal if cs     // GJ per million of value added ("Gj/va")
gen double o2 = 1e6 * co2_total_s1 / value_added_nominal if cs     // tonnes CO2 per million of VA ("Co2/va")
gen double o3 = total_gj_s1 if cs                                  // energy used, GJ (table only)
* check column: each firm against its OWN 2013-14 level (geometric mean of its 2013-14 values)
forvalues k = 1/3 {
    bysort firm_id: egen double lb`k' = mean(cond(base, ln(o`k'), .))
    gen double w`k' = 100 * exp(ln(o`k') - lb`k')
}
* records in doubt (R1-03 to R1-05): importers with no export answer that year
gen byte dbt = import_flag == 1 & missing(export_flag)
gen byte one = 1
keep firm_id year base nbase fz_* fzs_* export_flag import_flag fdi_10_flag cs o1-o3 w1-w3 dbt one
tempfile basedata
save `basedata'
* evidence for the years not drawn / drawn light gray (log only): among firms with a 2013-14 record,
* the share whose energy per value added is above 5 times, or below one fifth of, the base-years median
quietly summarize o1 if base & nbase > 0 & cs, detail
local m0 = r(p50)
preserve
keep if nbase > 0 & cs
gen double above5x = 100 * (o1 > 5 * `m0')
gen double below5th = 100 * (o1 < `m0' / 5)
collapse (mean) above5x below5th (count) firms = o1, by(year)
format above5x below5th %5.1f
display "   % of firms far above / far below the `base_yrs' median energy per value added, by year:"
list year firms above5x below5th, noobs sep(0) abbreviate(24)
restore

* program: from firm-year data in memory (fz, year, o1-o3), each frozen group's yearly
* median, as % of the average of its base-year medians; posts the group-minus-other difference and the group counts
capture program drop r106diff
program define r106diff
    args h rep baseyrs minn
    quietly {
        collapse (p50) o1 o2 o3 (count) c1 = o1 c2 = o2 c3 = o3, by(fz year)
        gen byte isb = 0
        foreach y of local baseyrs {
            replace isb = 1 if year == `y'
        }
        forvalues k = 1/3 {
            replace o`k' = . if c`k' < `minn'
            bysort fz: egen double b`k' = mean(cond(isb, o`k', .))
            gen double ix`k' = 100 * o`k' / b`k'
        }
        sort year fz
        forvalues k = 1/3 {
            by year: gen double d`k' = ix`k'[_N] - ix`k'[1] if _N == 2
        }
        keep if fz == 1
        forvalues i = 1/`=_N' {
            post `h' (`rep') (year[`i']) (d1[`i']) (d2[`i']) (d3[`i']) (c1[`i']) (c2[`i']) (c3[`i'])
        }
    }
end

display "Step 4/8: yearly medians, indices and differences per grouping, with `reps' redraws"
local groupings "export_flag import_flag fdi_10_flag"
local gi 0
foreach g of local groupings {
    local ++gi
    use `basedata', clear
    keep if !missing(fz_`g')              // frozen firms only (all years of each)
    gen byte fz = fz_`g'
    gen byte cur = `g'                    // the firm's answer in the current year (table only)
    * (1) point values
    preserve
    collapse (count) obs = one n1 = o1 n2 = o2 n3 = o3 wn1 = w1 wn2 = w2 wn3 = w3 curn = cur ///
             (p50) o1 o2 o3 w1 w2 w3 (mean) cur dbt, by(fz year)
    gen byte isb = inlist(year, `base_in')
    forvalues k = 1/3 {
        replace o`k' = . if n`k' < `min_n'
        replace w`k' = . if wn`k' < `min_n'
        bysort fz: egen double b`k' = mean(cond(isb, o`k', .))
        gen double ix`k' = 100 * o`k' / b`k'
    }
    drop isb
    reshape wide obs n1 n2 n3 wn1 wn2 wn3 curn o1 o2 o3 w1 w2 w3 cur dbt b1 b2 b3 ix1 ix2 ix3, i(year) j(fz)
    gen str12 grouping = "`g'"
    tempfile pt`gi'
    save `pt`gi''
    restore
    * (2) redraws: whole firms (all their years) drawn with replacement within each frozen group
    keep if cs
    gen byte fzs = fzs_`g'
    keep firm_id year fz fzs o1 o2 o3
    tempfile bdata
    save `bdata'
    * (3) the same for the stricter check: mixed firms left out of the group
    keep if !missing(fzs)
    replace fz = fzs
    tempfile sdata
    save `sdata'
    foreach set in main strict {
        local src = cond("`set'" == "main", "`bdata'", "`sdata'")
        local pf  = cond("`set'" == "main", "bs", "ss")
        quietly use `src', clear
        tempname h
        tempfile `pf'`gi'
        postfile `h' int rep int year double(d1 d2 d3) long(c1 c2 c3) using ``pf'`gi'', replace
        r106diff `h' 0 "`base_yrs'" `min_n'
        display "   `g' (`set' groups): redrawing firms `reps' times"
        set seed 20260925
        forvalues r = 1/`reps' {
            quietly use `src', clear     // quietly: otherwise the data label fills the log
            bsample, cluster(firm_id) strata(fz)
            r106diff `h' `r' "`base_yrs'" `min_n'
            if mod(`r', 250) == 0 display "      `r' of `reps' done"
        }
        postclose `h'
        use ``pf'`gi'', clear
        gen str12 grouping = "`g'"
        save ``pf'`gi'', replace
    }
}

display "Step 5/8: 95% ranges of the differences (middle 95% of the redrawn values)"
foreach pf in bs ss {
    use ``pf'1', clear
    append using ``pf'2' ``pf'3'
    tempfile allbs
    save `allbs'
    keep if rep >= 1
    forvalues k = 1/3 {
        egen double d`k'_lo95 = pctile(d`k'), by(grouping year) p(2.5)
        egen double d`k'_hi95 = pctile(d`k'), by(grouping year) p(97.5)
    }
    bysort grouping year (rep): keep if _n == 1
    keep grouping year d*_lo95 d*_hi95
    tempfile ci
    save `ci'
    use `allbs', clear
    keep if rep == 0
    keep grouping year d1 d2 d3 c1 c2 c3
    merge 1:1 grouping year using `ci', nogenerate keep(master match)
    if "`pf'" == "ss" {
        * stricter check: prefix s (sd = difference, sn = firms in the stricter group with the outcome)
        rename (d1 d2 d3 d1_lo95 d2_lo95 d3_lo95 d1_hi95 d2_hi95 d3_hi95 c1 c2 c3) ///
               (sd1 sd2 sd3 sd1_lo95 sd2_lo95 sd3_lo95 sd1_hi95 sd2_hi95 sd3_hi95 sn1 sn2 sn3)
    }
    else drop c1 c2 c3
    tempfile dd_`pf'
    save `dd_`pf''
}
use `dd_bs', clear
merge 1:1 grouping year using `dd_ss', nogenerate keep(master match)   // a year with no stricter-group firm stays empty
tempfile dd
save `dd'

display "Step 6/8: table -> CSV (numbers written before drawing)"
use `pt1', clear
append using `pt2' `pt3'
merge 1:1 grouping year using `dd', nogenerate assert(match)
merge m:1 grouping using `fcounts', nogenerate assert(match)
* the point differences from the program must equal those from the medians above
forvalues k = 1/3 {
    assert reldif(d`k', ix`k'1 - ix`k'0) < 1e-9 if !missing(d`k')
}
* one row per grouping x outcome x year (long), plus an empty 2016 row per grouping x outcome
local keepv "obs1 obs0 curn1 curn0 cur1 cur0 dbt1 dbt0"
forvalues k = 1/3 {
    rename (n`k'1 n`k'0 o`k'1 o`k'0 b`k'1 b`k'0 ix`k'1 ix`k'0 w`k'1 w`k'0 wn`k'1 wn`k'0) ///
           (n_g1_`k' n_g0_`k' med_g1_`k' med_g0_`k' base_g1_`k' base_g0_`k' ix_g1_`k' ix_g0_`k' wix_g1_`k' wix_g0_`k' wn_g1_`k' wn_g0_`k')
    rename (d`k' d`k'_lo95 d`k'_hi95) (diff_pts_`k' diff_lo95_`k' diff_hi95_`k')
    rename (sd`k' sd`k'_lo95 sd`k'_hi95 sn`k') (sdiff_pts_`k' sdiff_lo95_`k' sdiff_hi95_`k' sn_g1_`k')
}
reshape long n_g1_ n_g0_ med_g1_ med_g0_ base_g1_ base_g0_ ix_g1_ ix_g0_ wix_g1_ wix_g0_ wn_g1_ wn_g0_ ///
        diff_pts_ diff_lo95_ diff_hi95_ sdiff_pts_ sdiff_lo95_ sdiff_hi95_ sn_g1_, i(grouping year) j(outcome_id)
rename *_ *
* an empty 2016 row per grouping and outcome (no annual file): only the labels and firm counts are filled
preserve
keep if year == 2015
keep grouping outcome_id firms_*
gen int year = 2016
tempfile y16
save `y16'
restore
append using `y16'
gen byte annual_file = year != 2016
gen double rel_pct = 100 * (ix_g1 / ix_g0 - 1)
gen double wdiff_pts = wix_g1 - wix_g0
* no range where the point itself is missing (fewer than min_n firms; some redraws can still reach min_n)
foreach p in diff sdiff {
    replace `p'_lo95 = . if missing(`p'_pts)
    replace `p'_hi95 = . if missing(`p'_pts)
}
gen byte clear = diff_lo95 > 0 | diff_hi95 < 0 if !missing(diff_lo95)
gen byte sclear = sdiff_lo95 > 0 | sdiff_hi95 < 0 if !missing(sdiff_lo95)   // stricter check
* where each year sits in the design and how it is drawn
gen str12 period = cond(year < 2013, "before", cond(year <= 2014, "base", cond(year == 2015, "transition", "after")))
replace period = "" if year == 2016
gen str40 plot_status = cond(outcome_id == 3, "table only", "solid")
foreach y of local skip_yrs {
    replace plot_status = "not drawn: energy records jump" if year == `y' & outcome_id < 3
}
foreach y of local flag_yrs {
    replace plot_status = "light gray: energy records in doubt" if year == `y' & outcome_id < 3
}
replace plot_status = "no annual file" if year == 2016
* labels
gen str30 grp1_label = cond(grouping == "export_flag", "Exporters", cond(grouping == "import_flag", "Importers", "Foreign-owned (10%+)"))
gen str30 grp0_label = cond(grouping == "export_flag", "Not exporters in 2013-14", cond(grouping == "import_flag", "Not importers in 2013-14", "Not foreign-owned in 2013-14"))
gen str40 outcome = word("Energy_per_VA CO2_per_VA Energy_used", outcome_id)
replace outcome = subinstr(outcome, "_", " ", .)
gen str45 unit = cond(outcome_id == 1, "GJ per million of value added", cond(outcome_id == 2, "tonnes CO2 per million of value added", "GJ"))
gen str40 deasy_item = cond(outcome_id == 1, "Gj/va (total)", cond(outcome_id == 2, "Co2/va (total)", "Energi use, total"))
rename (obs1 obs0 curn1 curn0 cur1 cur0 dbt1 dbt0) (obs_g1 obs_g0 known_now_g1 known_now_g0 share_flag_now_g1 share_flag_now_g0 share_doubt_g1 share_doubt_g0)
replace share_flag_now_g1 = 100 * share_flag_now_g1
replace share_flag_now_g0 = 100 * share_flag_now_g0
replace share_doubt_g1 = 100 * share_doubt_g1
replace share_doubt_g0 = 100 * share_doubt_g0
gen str100 note = ""
replace note = "No annual file" if year == 2016
replace note = "Base years: each group's index averages 100 over them" if period == "base"
replace note = "Transition year (Paris adopted December 2015)" if period == "transition"
replace note = "Not drawn: many firms' recorded energy jumps this year" if plot_status == "not drawn: energy records jump"
replace note = "Drawn light gray: many firms' recorded energy drops far below earlier years" if plot_status == "light gray: energy records in doubt"
gen byte gi = cond(grouping == "export_flag", 1, cond(grouping == "import_flag", 2, 3))
gen byte panel_order = 3 * (gi - 1) + outcome_id
sort panel_order year
* structural checks
assert abs((ix_g1 + ix_g1[_n+1]) / 2 - 100) < 1e-9 if year == 2013 & !missing(ix_g1) & year[_n+1] == 2014
assert diff_lo95 <= diff_pts + 1e-9 & diff_pts <= diff_hi95 + 1e-9 if !missing(diff_lo95)
assert obs_g1 <= firms_g1 & obs_g0 <= firms_g0 if annual_file
assert n_g1 <= obs_g1 & n_g0 <= obs_g0 if annual_file
assert sn_g1 <= n_g1 if annual_file & !missing(sn_g1)
order grouping grp1_label grp0_label outcome_id outcome unit deasy_item year annual_file period plot_status ///
      firms_all firms_no_base firms_unknown firms_g1 firms_g0 firms_g1_mixed firms_g1_one_year ///
      obs_g1 obs_g0 n_g1 n_g0 med_g1 med_g0 base_g1 base_g0 ix_g1 ix_g0 diff_pts diff_lo95 diff_hi95 clear rel_pct ///
      sn_g1 sdiff_pts sdiff_lo95 sdiff_hi95 sclear ///
      wn_g1 wn_g0 wix_g1 wix_g0 wdiff_pts known_now_g1 known_now_g0 share_flag_now_g1 share_flag_now_g0 ///
      share_doubt_g1 share_doubt_g0 note
format firms_* obs_* n_g* sn_g1 wn_* known_now_* %9.0f
format med_* base_* %14.4f
format ix_* diff_* sdiff_* rel_pct wix_* wdiff_pts share_* %8.2f
export delimited grouping-note using "tables/06_frozen_pre_paris_groups.csv", datafmt replace
tempfile ctsrc                     // same numbers, full precision, for the companion table (Step 8)
quietly save `ctsrc'
list grouping outcome_id year obs_g1 obs_g0 ix_g1 ix_g0 diff_pts diff_lo95 diff_hi95 sdiff_pts sn_g1 wdiff_pts ///
    if outcome_id < 3 & annual_file, noobs sepby(grouping outcome_id) abbreviate(24)
display "   CHECK ON REAL DATA: skip_yrs (`skip_yrs') and flag_yrs (`flag_yrs') were chosen on the development files (see the far above / far below list in Step 3); confirm those years still look wrong before publishing"

display "Step 7/8: draw: one row per grouping (exporters, importers, foreign-owned), energy left, CO2 right, one shared scale"
* numbers for the notes, read from the table (never typed)
local attr ""
foreach g in export_flag import_flag fdi_10_flag {
    quietly summarize obs_g1 if grouping == "`g'" & year == `post_yr' & outcome_id == 1
    local o = r(mean)
    quietly summarize firms_g1 if grouping == "`g'" & outcome_id == 1
    local f = r(mean)
    * share of the group still recorded as in it that year (of those with a known answer)
    quietly summarize share_flag_now_g1 if grouping == "`g'" & year == `post_yr' & outcome_id == 1
    local sh = r(mean)
    local nm = cond("`g'" == "export_flag", "exporters", cond("`g'" == "import_flag", "importers", "foreign-owned"))
    local st = cond("`g'" == "export_flag", "exporting", cond("`g'" == "import_flag", "importing", "foreign-owned"))
    quietly summarize known_now_g1 if grouping == "`g'" & year == `post_yr' & outcome_id == 1
    local ans = cond(r(mean) < `o', " of those answering", "")      // some records give no answer that year
    local attr "`attr'; `nm' `=string(`o', "%9.0fc")' of `=string(`f', "%9.0fc")' (`=string(`sh', "%9.0f")'%`ans' still `st')"
}
local attr = substr("`attr'", 3, .)
* stricter check for the notes: panels whose printed difference is clear once mixed firms are left out
local sclr ""
foreach p in 1 2 3 4 5 6 {
    local gg = ceil(`p' / 2)
    local oo = 2 - mod(`p', 2)
    quietly count if gi == `gg' & outcome_id == `oo' & year == `post_yr' & sclear == 1
    if r(N) > 0 local sclr "`sclr' (`=word("a b c d e f", `p')')"
}
local sclr = strtrim("`sclr'")
local nw : word count `sclr'
if `nw' > 1 local sclr = subinstr("`sclr'", " " + word("`sclr'", `nw'), " and " + word("`sclr'", `nw'), 1)
if "`sclr'" == "" local stxt "it is clear in no panel"
else local stxt = "it is clear in " + cond(`nw' == 1, "panel ", "panels ") + "`sclr'"
* the base years as text, "2013–14" style (first year, en dash, last two digits of the last year)
local nb : word count `base_yrs'
local b1 : word 1 of `base_yrs'
local bl : word `nb' of `base_yrs'
local base_txt = cond(`nb' == 1, "`b1'", "`b1'–" + substr("`bl'", 3, 2))
keep if outcome_id < 3
gen byte panel = 2 * (gi - 1) + outcome_id
label define panel 1 "(a) Exporters: energy per value added"     2 "(b) Exporters: CO2 per value added" ///
                   3 "(c) Importers: energy per value added"     4 "(d) Importers: CO2 per value added" ///
                   5 "(e) Foreign-owned: energy per value added" 6 "(f) Foreign-owned: CO2 per value added"
label values panel panel
gen byte drawn   = plot_status == "solid"
gen byte flagged = plot_status == "light gray: energy records in doubt"
gen double y1  = ix_g1 if drawn
gen double y0  = ix_g0 if drawn
gen double y1f = ix_g1 if flagged
gen double y0f = ix_g0 if flagged
gen double ref = 100          // fixed reference, drawn through the 2016 band like R1-02 to R1-04
* one shared scale for all six panels: a round number above the highest mark
egen double pmax = rowmax(y1 y0 y1f y0f)
quietly summarize pmax
local top = 50 * ceil(1.08 * r(max) / 50)
display "   shared y scale: 0 to `top'"
* endpoint labels: first and last drawn year (last is light gray when that year is in doubt)
gen byte any = drawn | flagged
bysort panel: egen fy = min(cond(any, year, .))
bysort panel: egen ly = max(cond(any, year, .))
gen str8 l1  = string(y1,  "%9.0f") if year == fy & drawn
gen str8 l0  = string(y0,  "%9.0f") if year == fy & drawn
gen str8 l1f = string(y1f, "%9.0f") if year == ly & flagged
gen str8 l0f = string(y0f, "%9.0f") if year == ly & flagged
replace l1 = string(y1, "%9.0f") if year == ly & drawn
replace l0 = string(y0, "%9.0f") if year == ly & drawn
gen double hi1 = cond(drawn, y1, y1f)
gen double hi0 = cond(drawn, y0, y0f)
gen byte p1 = cond(year == fy, cond(hi1 >= hi0, 10, 8), cond(hi1 >= hi0, 2, 4))
gen byte p0 = cond(year == fy, cond(hi0 >  hi1, 10, 8), cond(hi0 >  hi1, 2, 4))
* the after-Paris difference, printed top right in each panel (two short lines)
gen str40 t1 = ""
gen str40 t2 = ""
replace t1 = "`post_yr' difference: " + cond(diff_pts >= 0.5, "+", "") + string(round(diff_pts), "%9.0f") + " points" if year == `post_yr'
replace t2 = "95% range " + string(round(diff_lo95), "%9.0f") + " to " + cond(diff_hi95 >= 0.5, "+", "") + string(round(diff_hi95), "%9.0f") if year == `post_yr'
gen double tx  = 2016.6 if year == `post_yr'
gen double ty1 = 0.95 * `top' if year == `post_yr'
gen double ty2 = 0.80 * `top' if year == `post_yr'
* 2016 band and Paris line (end of 2015)
gen double band = `top' if year == 2016
gen double px  = 2015.5 if year == 2016
gen double plo = 0 if year == 2016
gen double phi = `top' if year == 2016
* one gray line under the x axis, centred on the 2016 gap: the transition year and the years not drawn
local sub "2015 transition"
foreach y of local skip_yrs {
    local sub "`sub', `y' not drawn"
}
local skipopt `"xmlabel(2016 "`sub'", noticks tlength(0) labsize(vsmall) labcolor(gs6) labgap(3.5))"'
* Notes: one text, wrapped here into lines of at most 105 characters (PDF text runs wider than the PNG)
local ntext "Notes: Each firm is grouped once, by its `base_txt' records: in the group if so recorded in either year; firms with no `base_txt' record or no known answer are left out. Lines = the group's middle (median) firm each year as % of its own `base_txt' level: they compare changes, not levels. Energy = fuels plus bought electricity; value added = output value minus materials, energy and services bought, at current prices. Number = group line minus other firms' line in `post_yr' (95% range; gray = range includes 0, no clear difference); leaving out firms in the group in only one of the two years, `stxt' (table). 2015 = transition year (Paris adopted in December). `skip_yrs' and light gray years: many firms' recorded energy jumps or drops, likely a recording problem. Foreign-owned = 10%+ of capital held abroad. Still in the `post_yr' files: `attr'. Firm links across years are fictional here (later records may be other firms): a pipeline exercise showing change, not its cause."
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

sort panel year
twoway (bar band year, barwidth(0.8) color(gs14) lwidth(none) base(0)) ///
    (rspike phi plo px, lcolor(gs4) lpattern(shortdash) lwidth(thin)) ///
    (line ref year, lcolor(gs8) lwidth(thin) lpattern(solid)) ///
    (connected y1 year, cmissing(n) lcolor(black) lpattern(solid) lwidth(medthin) msymbol(O) msize(small) mcolor(black) ///
        mlabel(l1) mlabvposition(p1) mlabsize(vsmall) mlabcolor(black)) ///
    (connected y0 year, cmissing(n) lcolor(gs6) lpattern(shortdash) lwidth(medthin) msymbol(Sh) msize(small) mcolor(gs6) ///
        mlabel(l0) mlabvposition(p0) mlabsize(vsmall) mlabcolor(gs6)) ///
    (connected y1f year, cmissing(n) lcolor(gs8) lpattern(solid) lwidth(thin) msymbol(Oh) msize(small) mcolor(gs8) ///
        mlabel(l1f) mlabvposition(p1) mlabsize(vsmall) mlabcolor(gs6)) ///
    (connected y0f year, cmissing(n) lcolor(gs10) lpattern(shortdash) lwidth(thin) msymbol(Sh) msize(small) mcolor(gs11) ///
        mlabel(l0f) mlabvposition(p0) mlabsize(vsmall) mlabcolor(gs8)) ///
    (scatter ty1 tx if clear == 1, msymbol(none) mlabel(t1) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter ty2 tx if clear == 1, msymbol(none) mlabel(t2) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter ty1 tx if clear == 0, msymbol(none) mlabel(t1) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(gs9)) ///
    (scatter ty2 tx if clear == 0, msymbol(none) mlabel(t2) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(gs9)), ///
    by(panel, cols(2) graphregion(color(white) lcolor(white) ilcolor(white)) legend(pos(6)) ///
        title("Figure R1-06. Energy and CO2 per unit of value added, groups fixed before Paris", size(small) pos(11) span) ///
        note(`notelines' "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6))) ///
    subtitle(, pos(11) nobox fcolor(white) lcolor(white) size(small)) ///
    ylabel(0(50)`top', angle(0) noticks tlength(0) grid glcolor(gs15) glwidth(vthin) labsize(vsmall) format(%9.0f)) ///
    yscale(noline range(0 `top')) ytitle("% of own `base_txt' level", size(vsmall)) ///
    xlabel(2010(2)2022, noticks tlength(0) labsize(vsmall)) `skipopt' xscale(range(2008.6 2023.6) lcolor(gs10)) xtitle("") ///
    legend(order(4 "Group named in the panel title" 5 "Other firms: not in that group in `base_txt'" ///
                 6 "Group: energy records in doubt (see notes)" 7 "Other firms: energy records in doubt" ///
                 3 "100 = the group's own `base_txt' level" 1 "No annual file" ///
                 2 "Paris Agreement adopted (December 2015)") ///
        cols(2) region(lcolor(none)) size(vsmall) symxsize(6) keygap(1) colgap(4) rowgap(0.3)) ///
    plotregion(style(none)) xsize(8) ysize(11.5)

graph export "figures/06_frozen_pre_paris_groups.png", width(2400) replace
graph export "figures/06_frozen_pre_paris_groups.pdf", replace

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
* as the chart). One row per point, in chart order: panels (a)-(f) (exporters,
* importers, foreign-owned; energy left, CO2 right); within a panel the group's
* line, then the other firms' line, every year of the axis (years not drawn
* included, with the reason), then the `post_yr' difference printed top right.
use `ctsrc', clear
keep if outcome_id < 3
gen byte panel = 2 * (gi - 1) + outcome_id
sort panel year
by panel: gen byte ny_p = _N
quietly summarize ny_p
assert r(min) == r(max)
local ny = r(max)                      // axis years per panel, 2016 included
expand 2
bysort panel year: gen byte series = _n                       // 1 = group, 2 = other firms
expand 2 if series == 2 & year == `post_yr', generate(dcopy)
replace series = 3 if dcopy                                     // 3 = the printed difference
drop dcopy
sort panel series year
local npp = 2 * `ny' + 1
assert _N == 6 * `npp'
gen str45 t_panel = ""
replace t_panel = "(a) Exporters: energy per value added"     if panel == 1
replace t_panel = "(b) Exporters: CO2 per value added"        if panel == 2
replace t_panel = "(c) Importers: energy per value added"     if panel == 3
replace t_panel = "(d) Importers: CO2 per value added"        if panel == 4
replace t_panel = "(e) Foreign-owned: energy per value added" if panel == 5
replace t_panel = "(f) Foreign-owned: CO2 per value added"    if panel == 6
gen str60 t_series = cond(series == 1, grp1_label, cond(series == 2, grp0_label, "`post_yr' difference, group minus other (points)"))
gen str8 t_year = string(year)
* index lines: whole numbers as the chart labels; the difference exactly as printed
gen double v = cond(series == 1, ix_g1, cond(series == 2, ix_g0, diff_pts))
gen str12 t_v = string(v, "%9.0f") if !missing(v) & series < 3
replace t_v = cond(diff_pts >= 0.5, "+", "") + string(round(diff_pts), "%9.0f") if series == 3 & !missing(diff_pts)
gen str12 t_lo = string(round(diff_lo95), "%9.0f") if series == 3 & !missing(diff_lo95)
gen str12 t_hi = cond(diff_hi95 >= 0.5, "+", "") + string(round(diff_hi95), "%9.0f") if series == 3 & !missing(diff_hi95)
* firms with the outcome that year: the group's, the other firms'; for the difference both
gen double nf = cond(series == 1, n_g1, cond(series == 2, n_g0, n_g1 + n_g0))
gen str12 t_n = string(nf, "%12.0fc") if !missing(nf)
* status: how (and whether) the point is drawn
gen str90 t_status = ""
replace t_status = "drawn" if plot_status == "solid"
replace t_status = cond(series == 1, "hollow gray", "light gray") + ": records in doubt (see notes)" if plot_status == "light gray: energy records in doubt"
replace t_status = "not drawn: energy records jump" if plot_status == "not drawn: energy records jump"
replace t_status = "not drawn: no annual file" if year == 2016
replace t_status = "not drawn: under `min_n' firms in a group" if missing(v) & inlist(plot_status, "solid", "light gray: energy records in doubt")
replace t_status = cond(clear == 1, "printed top right, black: range excludes 0", "printed top right, gray: range includes 0") if series == 3
replace t_status = "not printed: under `min_n' firms in a group" if series == 3 & missing(clear)
* two no-break spaces keep the status text off the numbers to its left
replace t_status = uchar(160) + uchar(160) + t_status if t_status != ""
* checks: every drawn point is one row with a number; the drawn count equals the chart's marks
quietly count if inlist(plot_status, "solid", "light gray: energy records in doubt") & !missing(v) & series < 3
local nmarks = r(N)
quietly count if series == 3 & !missing(clear)
local nmarks = `nmarks' + r(N)
quietly count if !strpos(t_status, "not drawn") & !strpos(t_status, "not printed")
assert r(N) == `nmarks'
assert t_v != "" if !strpos(t_status, "not drawn") & !strpos(t_status, "not printed")
assert t_lo != "" & t_hi != "" if series == 3 & !missing(clear)
local ntext_t = itrim(`"`ntext'"')
local tnote "Table: every point of Figure R1-06 in chart order, with the years not drawn and why (their numbers are shown). Lines: the median firm as"
local tnote "`tnote' % of the group's own `base_txt' level, whole numbers as the chart labels; Firms = firms with the outcome that year."
local tnote "`tnote' Difference: as printed in each panel, with its 95% range from `reps' redraws of whole firms; Firms counts both"
local tnote "`tnote' groups. Stricter groups and energy used: tables/06_frozen_pre_paris_groups.csv (full precision)."
local r ""
forvalues p = 1/5 {
    local r "`r' `=(`p' - 1) * `npp' + `ny'' `=(`p' - 1) * `npp' + 2 * `ny'' `=`p' * `npp''"
}
local r "`r' `=5 * `npp' + `ny'' `=5 * `npp' + 2 * `ny''"
ctable_pdf t_panel t_series t_year t_v t_lo t_hi t_n t_status using "tables/06_frozen_pre_paris_groups_table.pdf", ///
    title("Table R1-06. Energy and CO2 per unit of value added, groups fixed before Paris: every plotted point") ///
    header("Panel" "Series" "Year" "Plotted|value" "95%|low" "95%|high" "Firms" "Status") ///
    right(3 4 5 6 7) norepeat(1 2) fontsize(8) rules(`r') perpage(`npp') subtitle("`tnote'") ///
    notes("`ntext_t'" "`srcnote'" "`devnote'")
display "table -> tables/06_frozen_pre_paris_groups_table.pdf"
* --- end of PART 2 ------------------------------------------------------------

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/06_frozen_pre_paris_groups.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
