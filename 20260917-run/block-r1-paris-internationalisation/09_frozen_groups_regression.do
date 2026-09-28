/*==========================================================================
  R1-09  Groups frozen before Paris, as a regression. Each firm is put into
         a group ONCE, from its 2013-14 records (exporter or not, importer or
         not, 10%+ foreign-owned or not). After the Paris Agreement (adopted
         December 2015), did each group's energy use, CO2, electricity and
         own electricity change more than those of similar firms (same
         industry and province, same year), each firm measured against its
         own average? And were the groups already moving apart before Paris?
  Answers Deasy R1: "DID"; "Alternative: Freeze internationalisation status
         sebelum Paris, misalnya average 2013-14: pre exporters x year; 2015
         transition year; 2016+ post; Firm FE + industry x year FE +
         province x year FE"; "Did internationally engaged firms change
         their environmental behaviour more strongly after the Paris
         Agreement?"; every listed outcome: "VA/energy use, scope 1, scope 2,
         total; VA/emisi, scope 1, scope 2, total; Energi use, scope 1, 2,
         total; Emisi, scope 1, 2, total; GJ/emisi, scope 1, 2, total;
         Co2/va; Gj/va; Electricity; Self generation".
  Foreign-owned = 10% or more of the firm's capital held abroad
         (fdi_10_flag), the definition used in every R1-R3 exhibit.
  Output : figures/09_frozen_groups_regression.png (+ .pdf)
           tables/09_frozen_groups_regression.csv   (every outcome x group x
           version x period; the figure uses the rows with in_figure = 1)
           tables/09_frozen_groups_regression_table.pdf (every plotted point)
           tables/09_frozen_groups_regression_regression.pdf (the drawn rows, main and
           firm + year versions)
  Needs  : Stata add-ons reghdfe and ftools from SSC (reghdfe 6 also needs
           require), installed once (ssc install reghdfe, ssc install ftools,
           ssc install require); the file never installs anything and stops
           with a plain message if one is missing.
  Runtime: about 1 minute on the development file (about 500 regressions);
           longer on the full files.
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

* ---- THE DESIGN (why: INDEX.md, paragraph "09") ------------------------------------------
local base_yrs  "2013 2014"            // Deasy's "average 2013-14": groups frozen from these years;
                                       // also the comparison years of the main version
local rule_min  0.5                    // in the group if flagged in at least half of its known 2013-14 years (as R1-06)
local pre_yrs   "2010 2011 2012"       // check before Paris: a group moving apart already here was not on
                                       // the same path as the other firms
local trans_yr  2015                   // Deasy's transition year (Paris adopted December 2015): own period
local jump_yrs  "2017"                 // energy records jump for many firms (R1-02 to R1-06): own period
local post_yr   2018                   // the after-Paris year drawn: the one later year whose energy records
                                       // look normal (R1-05, R1-06)
local doubt_yrs "2019 2020 2021 2022"  // many energy records drop far below earlier years: own period
local min_n     30                     // a period is shown only if each of its years (and each comparison
                                       // year) has at least 30 firms of the group and 30 other firms
local og_min    75                     // own-electricity rows use a year only if at least 75% of the frozen
                                       // firms have own electricity recorded (as R1-05)
* -------------------------------------------------------------------------------------------

cap log close
log using "logs/09_frozen_groups_regression.log", replace text
timer clear 1
timer on 1
display _newline "=== [R1-09] STARTING: groups frozen by 2013-14 status, regression before vs after Paris, every outcome ==="

* reghdfe (with ftools) runs regressions that take out many sets of averages at once
foreach p in reghdfe ftools {
    capture which `p'
    if _rc {
        display as error "R1-09 needs the Stata add-on `p'. Install it once: ssc install `p'  - then run this file again."
        log close
        exit 199
    }
}

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

display "Step 1/9: load the group flags, energy, CO2, electricity, value added, workers, industry and province"
* gj_fuel_s1      = energy from nine fuels burned at the plant (GJ)      = scope 1
* gj_electricity  = energy from bought electricity (GJ = kWh x 0.0036)  = scope 2
* total_gj_s1     = the two together; co2_* = the matching CO2 in tonnes (energy x standard factors)
* elec_owngen_kwh = electricity the firm makes itself (kWh); own_gen_unknown = 1 if not recorded
* industry2_reported = two-digit industry; province_code = province (both fixed per firm in this file)
use firm_id year export_flag import_flag fdi_10_flag gj_fuel_s1 gj_electricity total_gj_s1 ///
    co2_scope1_s1 co2_scope2_s1 co2_total_s1 elec_purchased_kwh elec_owngen_kwh own_gen_unknown ///
    value_added_nominal workers industry2_reported province_code using "$DATA", clear
isid firm_id year
assert year != 2016
assert inlist(export_flag, 0, 1, .) & inlist(import_flag, 0, 1, .) & inlist(fdi_10_flag, 0, 1, .)
assert abs(total_gj_s1 - gj_fuel_s1 - gj_electricity) <= 1e-6 * total_gj_s1
assert abs(co2_total_s1 - co2_scope1_s1 - co2_scope2_s1) <= 1e-6 * co2_total_s1
gen int ind = real(industry2_reported)
encode province_code, gen(prov)
local base_in = subinstr("`base_yrs'", " ", ",", .)

display "Step 2/9: freeze each firm's status from its 2013-14 records (R1-06's rule, same code)"
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
    * stricter check (table only): in the group only if flagged in EVERY known 2013-14 year;
    * firms flagged in one of their two known years ("mixed") are left out; other firms are unchanged
    gen byte fzs_`g' = cond(k_`g' == 0, ., cond(s_`g' == k_`g', 1, cond(s_`g' == 0, 0, .)))
    * share check (table only): the 2013-14 average itself (0, 1/2 or 1), Deasy's "average 2013-14"
    gen double fzc_`g' = s_`g' / k_`g' if k_`g' > 0
}
egen byte firm1 = tag(firm_id)
tempname hc
tempfile fcounts
postfile `hc' str12 grouping long(firms_all firms_no_base firms_unknown firms_g1 firms_g0 firms_g1_mixed) using `fcounts', replace
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
    assert `a' == `nb' + `un' + `f1' + `f0'
    post `hc' ("`g'") (`a') (`nb') (`un') (`f1') (`f0') (`mx')
    display "   `g': in group `f1', other firms `f0', left out: no 2013-14 record `nb', unknown answer `un'"
}
postclose `hc'

display "Step 3/9: outcomes per firm and year (logs, so a difference reads as %)"
* "Absent is not zero": each outcome uses only firms whose quantities in it are above zero
* (R1-05's rule): scope-1 rows: fuel energy and fuel CO2 > 0; scope-2 rows: bought electricity > 0;
* total rows: total energy and total CO2 > 0. Value added > 0 in all.
gen byte va_ok = value_added_nominal > 0 & !missing(value_added_nominal)
gen byte s1 = va_ok & gj_fuel_s1 > 0     & co2_scope1_s1 > 0 & !missing(gj_fuel_s1, co2_scope1_s1)
gen byte s2 = va_ok & gj_electricity > 0 & co2_scope2_s1 > 0 & !missing(gj_electricity, co2_scope2_s1)
gen byte st = va_ok & total_gj_s1 > 0    & co2_total_s1 > 0  & !missing(total_gj_s1, co2_total_s1)
gen byte og = st & own_gen_unknown == 0 & !missing(elec_owngen_kwh, elec_purchased_kwh)
* outcome numbers follow R1-05 (same rows, same order: Deasy's list)
gen double y1  = ln(gj_fuel_s1     / value_added_nominal) if s1   // energy per VA, fuels
gen double y2  = ln(gj_electricity / value_added_nominal) if s2   // energy per VA, bought electricity
gen double y3  = ln(total_gj_s1    / value_added_nominal) if st   // energy per VA, total ("Gj/va")
gen double y4  = ln(co2_scope1_s1  / value_added_nominal) if s1   // CO2 per VA, fuels
gen double y5  = ln(co2_scope2_s1  / value_added_nominal) if s2   // CO2 per VA, bought electricity
gen double y6  = ln(co2_total_s1   / value_added_nominal) if st   // CO2 per VA, total ("Co2/va")
gen double y7  = ln(gj_fuel_s1)     if s1                         // energy used (GJ)
gen double y8  = ln(gj_electricity) if s2
gen double y9  = ln(total_gj_s1)    if st
gen double y10 = ln(co2_scope1_s1)  if s1                         // CO2 emitted (tonnes)
gen double y11 = ln(co2_scope2_s1)  if s2
gen double y12 = ln(co2_total_s1)   if st
gen double y13 = ln(gj_fuel_s1     / co2_scope1_s1) if s1         // GJ per tonne of CO2 ("GJ/emisi")
gen double y14 = ln(gj_electricity / co2_scope2_s1) if s2         // one national grid factor: same for all
gen double y15 = ln(total_gj_s1    / co2_total_s1)  if st
* shares in % (0-100): the difference is in percentage points
gen double y16 = 100 * gj_electricity / total_gj_s1 if st           // bought electricity, % of energy
gen double y17 = 100 * (elec_owngen_kwh > 0) if og                  // makes some own electricity (0 or 100)
gen double y18 = 100 * elec_owngen_kwh / (elec_owngen_kwh + elec_purchased_kwh) ///
                 if og & elec_owngen_kwh + elec_purchased_kwh > 0   // own electricity, % of electricity used
gen double y19 = ln(value_added_nominal) if st                      // for comparison: value added
gen double y20 = ln(workers) if st & workers > 0                    // for comparison: workers
* GJ per tonne of CO2 from bought electricity is one number per year (the national grid factor):
* no firm or group difference can exist, so it is not estimated (as R1-05)
bysort year: egen double sd14 = sd(y14)
assert sd14 < 1e-9 | missing(sd14)
* own electricity is recorded for too few firms in some years: those years are not used for rows 17-18
gen byte frozen_any = nbase > 0
preserve
keep if frozen_any & st
collapse (mean) ogshare = og, by(year)
quietly levelsof year if ogshare < `og_min' / 100, local(og_skip)
restore
foreach y of local og_skip {
    replace y17 = . if year == `y'
    replace y18 = . if year == `y'
}
display "   own-electricity rows leave out year(s) with under `og_min'% recorded: `og_skip'"
* records in doubt (R1-03 to R1-05): importers with no export answer that year (check version only)
gen byte dbt = import_flag == 1 & missing(export_flag)
* the periods of the main version (each its own marker; the comparison years are the 2013-14 pair)
foreach p in pre trans jump post doubt {
    gen byte p_`p' = 0
}
foreach y of local pre_yrs {
    replace p_pre = 1 if year == `y'
}
replace p_trans = 1 if year == `trans_yr'
foreach y of local jump_yrs {
    replace p_jump = 1 if year == `y'
}
replace p_post = 1 if year == `post_yr'
foreach y of local doubt_yrs {
    replace p_doubt = 1 if year == `y'
}
gen byte p_all = year > `trans_yr'            // Deasy's "2016+": every year after the transition year
assert p_pre + base + p_trans + p_jump + p_post + p_doubt == 1   // every year sits in exactly one period
keep firm_id year ind prov fz_* fzs_* fzc_* y1-y20 dbt base p_* nbase
compress
tempfile basedata
save `basedata'

* Program: the smallest number of firms of the group (g = 1) and of the other firms (g = 0) in any
* year of a list, among the rows the last regression used (es = 1). Years with no rows at all
* (e.g. own-electricity years left out on purpose) are skipped.
capture program drop r109min
program define r109min, rclass
    args yrs
    local m1 = .
    local m0 = .
    foreach y of local yrs {
        quietly count if es & year == `y'
        if r(N) > 0 {
            quietly count if es & year == `y' & gcnt == 1
            local m1 = min(`m1', r(N))
            quietly count if es & year == `y' & gcnt == 0
            local m0 = min(`m0', r(N))
        }
    }
    return scalar m1 = `m1'
    return scalar m0 = `m0'
end

display "Step 4/9: regressions: every outcome x group x version (firm-clustered 95% intervals)"
* Model (main version): outcome = firm's own average + one average per industry and year + one per
* province and year + the group's extra change in each period, against 2013-14:
*   b_period = (group's change from 2013-14 to that period) - (other firms' change), in log points.
* Versions (all but "fe1" use Deasy's industry x year and province x year averages):
*   main      periods 2010-12 / 2015 / 2017 / 2018 / 2019-22 against 2013-14   (figure: 2018 and 2010-12)
*   fe1       same, firm average + one average per year only (figure: hollow circle, 2018)
*   d2016     Deasy's literal: 2015 + "2016+" (every year from 2017) against 2010-14; also with fe1
*   strict    main, group = flagged in EVERY known 2013-14 year (mixed firms left out)
*   share     main, group = the 2013-14 average itself (0, 1/2, 1): a firm flagged in both years vs neither
*   nodoubt   main, without importers' records that have no export answer that year
*   window    main, but only the 2013-14 and 2018 records (each firm's average from these years alone)
*   yearly    one marker per year against 2013-14 (event-study version)
local fe2 "firm_id ind#year prov#year"
local fe1 "firm_id year"
local ylist "1 2 3 4 5 6 7 8 9 10 11 12 13 15 16 17 18 19 20"
local versions "main fe1 d2016 d2016_fe1 strict share nodoubt window yearly"
quietly levelsof year, local(allyrs)
local trans_txt "`trans_yr'"
local post_txt  "`post_yr'"
local all_txt ""
foreach y of local allyrs {
    if `y' > `trans_yr' local all_txt "`all_txt' `y'"
}
local ref_long "`pre_yrs' `base_yrs'"
tempname P
tempfile res
postfile `P' str12 grouping str10 version int outcome_id str8 term double(b se df_r) ///
    long(rows firms singletons n_g1_min n_g0_min ref_g1_min ref_g0_min) using `res', replace
local gi 0
foreach g in export_flag import_flag fdi_10_flag {
    local ++gi
    display "   `g': 19 outcomes x 8 versions"
    use `basedata', clear
    keep if !missing(fz_`g')               // frozen firms only (all years of each)
    foreach v of local versions {
        capture drop X
        capture drop gcnt
        capture drop t_*
        if "`v'" == "strict" gen double X = fzs_`g'
        else if "`v'" == "share" gen double X = fzc_`g'
        else gen double X = fz_`g'
        gen byte gcnt = cond("`v'" == "strict", fzs_`g', fz_`g')    // who counts as "the group" for the counts
        local smp "!missing(X)"
        if "`v'" == "nodoubt" local smp "!missing(X) & !dbt"
        if "`v'" == "window"  local smp "!missing(X) & (base | p_post)"
        local ab "`fe2'"
        if inlist("`v'", "fe1", "d2016_fe1") local ab "`fe1'"
        if inlist("`v'", "d2016", "d2016_fe1") {
            gen double t_trans = X * p_trans
            gen double t_all   = X * p_all
            local terms "t_trans t_all"
        }
        else if "`v'" == "window" {
            gen double t_post = X * p_post
            local terms "t_post"
        }
        else if "`v'" == "yearly" {
            local terms ""
            foreach y of local allyrs {
                if !inlist(`y', `base_in') {
                    gen double t_e`y' = X * (year == `y')
                    local terms "`terms' t_e`y'"
                }
            }
        }
        else {
            foreach p in pre trans jump post doubt {
                gen double t_`p' = X * p_`p'
            }
            local terms "t_pre t_trans t_jump t_post t_doubt"
        }
        local ks "`ylist'"
        if "`v'" == "yearly" local ks "3 6"                // event-study version: the two headline rows
        foreach k of local ks {
            capture drop es
            quietly reghdfe y`k' `terms' if `smp', absorb(`ab') vce(cluster firm_id)
            gen byte es = e(sample)
            local N  = e(N)
            local G  = e(N_clust)
            local df = e(df_r)
            local S  = e(num_singletons)
            if "`S'" == "" local S 0
            * the comparison years: 2013-14 (main versions) or 2010-14 (Deasy's literal version)
            local ryrs "`base_yrs'"
            if inlist("`v'", "d2016", "d2016_fe1") local ryrs "`ref_long'"
            r109min "`ryrs'"
            local r1 = r(m1)
            local r0 = r(m0)
            foreach t of local terms {
                local tn = substr("`t'", 3, .)
                if "`tn'" == "pre"   local tyrs "`pre_yrs'"
                if "`tn'" == "trans" local tyrs "`trans_yr'"
                if "`tn'" == "jump"  local tyrs "`jump_yrs'"
                if "`tn'" == "post"  local tyrs "`post_yr'"
                if "`tn'" == "doubt" local tyrs "`doubt_yrs'"
                if "`tn'" == "all"   local tyrs "`all_txt'"
                if substr("`tn'", 1, 1) == "e" local tyrs = substr("`tn'", 2, .)
                r109min "`tyrs'"
                local n1 = r(m1)
                local n0 = r(m0)
                * a period with no rows (e.g. 2015 for own electricity) is dropped by reghdfe: left empty
                capture local sechk = _se[`t']
                if _rc local sechk = .
                if `sechk' == 0 | missing(`sechk') {
                    post `P' ("`g'") ("`v'") (`k') ("`tn'") (.) (.) (`df') (`N') (`G') (`S') (`n1') (`n0') (`r1') (`r0')
                }
                else {
                    post `P' ("`g'") ("`v'") (`k') ("`tn'") (_b[`t']) (_se[`t']) (`df') (`N') (`G') (`S') (`n1') (`n0') (`r1') (`r0')
                }
            }
        }
    }
    * row 14 (GJ per tonne of CO2, bought electricity): the same for every firm, no regression
    foreach v in main fe1 {
        foreach tn in pre trans jump post doubt {
            post `P' ("`g'") ("`v'") (14) ("`tn'") (0) (.) (.) (.) (.) (.) (.) (.) (.) (.)
        }
    }
}
postclose `P'

display "Step 5/9: share of each frozen group still so recorded in `post_yr' (for the notes)"
tempname hs
tempfile still
postfile `hs' str12 grouping long(still_n still_known) double still_pct using `still', replace
use firm_id year export_flag import_flag fdi_10_flag using "$DATA", clear
merge 1:1 firm_id year using `basedata', keepusing(fz_*) nogenerate assert(match)
foreach g in export_flag import_flag fdi_10_flag {
    quietly count if fz_`g' == 1 & year == `post_yr' & !missing(`g')
    local kn = r(N)
    quietly count if fz_`g' == 1 & year == `post_yr' & `g' == 1
    local st = r(N)
    post `hs' ("`g'") (`st') (`kn') (100 * `st' / `kn')
}
postclose `hs'

display "Step 6/9: table -> CSV (numbers written before drawing)"
use `res', clear
merge m:1 grouping using `fcounts', nogenerate assert(match)
merge m:1 grouping using `still', nogenerate assert(match)
* scope-2 CO2 = bought electricity x one national factor a year, so with year averages in every
* version its rows repeat the scope-2 energy rows exactly: check it, then say so in the notes
preserve
keep if inlist(outcome_id, 2, 5, 8, 11) & !missing(b)
gen byte pair = cond(inlist(outcome_id, 2, 5), 1, 2)
sort grouping version term pair outcome_id
by grouping version term pair: assert _N == 2
by grouping version term pair: assert reldif(b[1], b[2]) < 1e-6
restore
* support rule: every year of the period and of the comparison years needs min_n firms in each group
gen byte shown = n_g1_min >= `min_n' & n_g0_min >= `min_n' & ref_g1_min >= `min_n' & ref_g0_min >= `min_n' ///
    & !missing(b, se)
replace shown = 1 if outcome_id == 14
gen double tcrit = invttail(df_r, 0.025)
gen double lo = b - tcrit * se if shown
gen double hi = b + tcrit * se if shown
gen double p  = 2 * ttail(df_r, abs(b / se)) if shown & se > 0
* the difference in %: 100 x (exp(b) - 1) for log rows; shares (rows 16-18) are already in points
gen byte share_row = inlist(outcome_id, 16, 17, 18)
gen double diff    = cond(share_row, b,  100 * (exp(b)  - 1)) if shown
gen double diff_lo = cond(share_row, lo, 100 * (exp(lo) - 1)) if shown
gen double diff_hi = cond(share_row, hi, 100 * (exp(hi) - 1)) if shown
gen str20 diff_unit = cond(share_row, "percentage points", "%")
* Deasy's "VA/energy use" and "VA/emisi" are rows 1-6 upside down: in logs exactly -b
gen double mirror_diff    = 100 * (exp(-b)  - 1) if shown & inrange(outcome_id, 1, 6)
gen double mirror_diff_lo = 100 * (exp(-hi) - 1) if shown & inrange(outcome_id, 1, 6)
gen double mirror_diff_hi = 100 * (exp(-lo) - 1) if shown & inrange(outcome_id, 1, 6)
gen byte clear = diff_lo > 0 | diff_hi < 0 if !missing(diff_lo)
* labels
gen str30 grp1_label = cond(grouping == "export_flag", "Exporters", cond(grouping == "import_flag", "Importers", "Foreign-owned (10%+)"))
gen str40 grp0_label = cond(grouping == "export_flag", "Not exporters in 2013-14", cond(grouping == "import_flag", "Not importers in 2013-14", "Not foreign-owned in 2013-14"))
gen str40 section = ""
gen str50 row_label = ""
local sec1 "Energy (GJ) per unit of VA"
local sec2 "CO2 (tonnes) per unit of VA"
local sec3 "Energy used (GJ)"
local sec4 "CO2 emitted (tonnes)"
local sec5 "Energy (GJ) per tonne of CO2"
local sec6 "Electricity (difference in points)"
local sec7 "For comparison"
forvalues k = 1/15 {
    local s = ceil(`k' / 3)
    local j = `k' - 3 * (`s' - 1)
    replace section = "`sec`s''" if outcome_id == `k'
    replace row_label = word("Scope_1_(fuels) Scope_2_(bought_electricity) Total", `j') if outcome_id == `k'
}
replace row_label = subinstr(row_label, "_", " ", .)
replace row_label = "Scope 2 (same for all firms)" if outcome_id == 14
replace section = "`sec6'" if inrange(outcome_id, 16, 18)
replace row_label = "Bought, % of energy used"   if outcome_id == 16
replace row_label = "Firms making their own, %"  if outcome_id == 17
replace row_label = "Own, % of electricity used" if outcome_id == 18
replace section = "`sec7'" if inrange(outcome_id, 19, 20)
replace row_label = "Value added (current prices)" if outcome_id == 19
replace row_label = "Workers" if outcome_id == 20
gen str70 deasy_item = ""
replace deasy_item = "Gj/va (scope parts); VA/energy use = mirror_* columns"  if inrange(outcome_id, 1, 3)
replace deasy_item = "Co2/va (scope parts); VA/emisi = mirror_* columns"      if inrange(outcome_id, 4, 6)
replace deasy_item = "Energi use, scope 1, 2, total"                          if inrange(outcome_id, 7, 9)
replace deasy_item = "Emisi, scope 1, 2, total"                               if inrange(outcome_id, 10, 12)
replace deasy_item = "GJ/emisi, scope 1, 2, total"                            if inrange(outcome_id, 13, 15)
replace deasy_item = "Electricity"                                            if outcome_id == 16
replace deasy_item = "Self generation"                                        if inlist(outcome_id, 17, 18)
replace deasy_item = "(reference, not in Deasy's list)"                       if inlist(outcome_id, 19, 20)
gen str90 version_label = ""
replace version_label = "Main: firm + industry x year + province x year averages; against 2013-14" if version == "main"
replace version_label = "Firm + year averages only; against 2013-14"                              if version == "fe1"
replace version_label = "Deasy's literal: 2015 transition, 2016+ = every year from 2017; against 2010-14" if version == "d2016"
replace version_label = "Deasy's literal with firm + year averages only"                          if version == "d2016_fe1"
replace version_label = "Stricter group: flagged in every known 2013-14 year (mixed firms left out)" if version == "strict"
replace version_label = "Group = 2013-14 average (0, 1/2, 1): flagged in both years vs neither"   if version == "share"
replace version_label = "Main without importers' records with no export answer that year"         if version == "nodoubt"
replace version_label = "Main, using only the `base_yrs' and `post_yr' records (other years left out)" if version == "window"
replace version_label = "One marker per year against 2013-14 (event-study version)"               if version == "yearly"
gen str60 period = ""
replace period = "before Paris: " + "`pre_yrs'" if term == "pre"
replace period = "transition year: `trans_yr'" if term == "trans"
replace period = "records jump: `jump_yrs'" if term == "jump"
replace period = "after Paris: `post_yr'" if term == "post"
replace period = "records in doubt: `doubt_yrs'" if term == "doubt"
replace period = "2016+ (no 2016 file):" + "`all_txt'" if term == "all"
replace period = "year " + substr(term, 2, .) if substr(term, 1, 1) == "e"
gen str30 compared_with = cond(inlist(version, "d2016", "d2016_fe1"), "`ref_long'", "`base_yrs'")
* own-electricity rows: the comparison years without the years left out for them
foreach r in base_yrs ref_long {
    local keep_`r' ""
    foreach y of local `r' {
        local isin : list y in og_skip
        if !`isin' local keep_`r' "`keep_`r'' `y'"
    }
}
replace compared_with = strtrim("`keep_base_yrs'") if inlist(outcome_id, 17, 18) & !inlist(version, "d2016", "d2016_fe1")
replace compared_with = strtrim("`keep_ref_long'") if inlist(outcome_id, 17, 18) & inlist(version, "d2016", "d2016_fe1")
gen byte in_figure = (version == "main" & inlist(term, "pre", "post")) | (version == "fe1" & term == "post")
gen str120 note = ""
replace note = "Same for every firm in a year (electricity GJ / grid factor): no firm or group difference can exist; not estimated" if outcome_id == 14
replace note = "Repeats the scope-2 energy row (bought electricity x one national factor a year)" if inlist(outcome_id, 5, 11)
replace note = "Period not estimable: own electricity not used in year(s) `og_skip'" if missing(b) & inlist(outcome_id, 17, 18)
replace note = "Fewer than `min_n' firms of a group in a year of this period or of the comparison years: left empty" ///
    if !shown & !missing(b)
gen byte gi = cond(grouping == "export_flag", 1, cond(grouping == "import_flag", 2, 3))
gen byte vorder = 1*(version == "main") + 2*(version == "fe1") + 3*(version == "d2016") + 4*(version == "d2016_fe1") ///
    + 5*(version == "strict") + 6*(version == "share") + 7*(version == "nodoubt") + 8*(version == "window") ///
    + 9*(version == "yearly")
gen int torder = cond(term == "pre", 1, cond(term == "trans", 2, cond(term == "jump", 3, cond(term == "post", 4, ///
    cond(term == "doubt", 5, cond(term == "all", 6, real(substr(term, 2, .))))))))
* empty 2016 row in the yearly version (no annual file)
preserve
keep if version == "yearly" & term == "e`trans_yr'"
replace term = "e2016"
replace torder = 2016
foreach v in b se lo hi p diff diff_lo diff_hi mirror_diff mirror_diff_lo mirror_diff_hi clear n_g1_min n_g0_min {
    replace `v' = .
}
replace shown = 0
replace period = "year 2016"
replace note = "No annual file"
tempfile y16
save `y16'
restore
append using `y16'
* structural checks
assert diff_lo <= diff + 1e-9 & diff <= diff_hi + 1e-9 if !missing(diff_lo)
assert diff == 0 if outcome_id == 14
assert n_g1_min <= firms_g1 if !missing(n_g1_min) & version != "strict"
sort gi vorder outcome_id torder
order grouping grp1_label grp0_label version version_label outcome_id section row_label deasy_item term period ///
      compared_with in_figure shown b se df_r p lo hi diff diff_lo diff_hi diff_unit clear ///
      mirror_diff mirror_diff_lo mirror_diff_hi rows firms singletons n_g1_min n_g0_min ref_g1_min ref_g0_min ///
      firms_all firms_no_base firms_unknown firms_g1 firms_g0 firms_g1_mixed still_n still_known still_pct note
format b se lo hi %9.4f
format p %6.4f
format diff diff_lo diff_hi mirror_* still_pct %8.2f
format df_r rows firms singletons n_g* ref_g* firms_* still_n still_known %9.0f
export delimited grouping-note using "tables/09_frozen_groups_regression.csv", datafmt replace
tempfile ctsrc                     // same numbers, full precision, for the companion table(s) (Step 9)
quietly save `ctsrc'
list grouping outcome_id term diff diff_lo diff_hi clear n_g1_min firms if version == "main" & inlist(term, "pre", "post"), ///
    noobs sepby(grouping) abbreviate(24)
list grouping outcome_id version diff diff_lo diff_hi clear n_g1_min if inlist(version, "fe1", "strict", "share", "nodoubt", "window") ///
    & term == "post" & inlist(outcome_id, 3, 6, 9, 12), noobs sepby(grouping) abbreviate(24)
list grouping outcome_id version term diff diff_lo diff_hi clear if inlist(version, "d2016") & inlist(outcome_id, 3, 6, 9, 12), ///
    noobs sepby(grouping) abbreviate(24)

display "Step 7/9: numbers for the notes, read from the table (never typed)"
local base_n : word count `base_yrs'
local b1 : word 1 of `base_yrs'
local bl : word `base_n' of `base_yrs'
local base_txt = cond(`base_n' == 1, "`b1'", "`b1'–" + substr("`bl'", 3, 2))
local pre_n : word count `pre_yrs'
local q1 : word 1 of `pre_yrs'
local ql : word `pre_n' of `pre_yrs'
local pre_txt = cond(`pre_n' == 1, "`q1'", "`q1'–" + substr("`ql'", 3, 2))
local all_n : word count `all_txt'
local a1 : word 1 of `all_txt'
local al : word `all_n' of `all_txt'
local all_rng = cond(`all_n' == 1, "`a1'", "`a1'–" + substr("`al'", 3, 2))
* rows 5 and 11 repeat rows 2 and 8 exactly, and row 14 cannot differ: they are not counted
gen byte cnt = !inlist(outcome_id, 5, 11, 14)
quietly count if version == "main" & term == "post" & shown & cnt & !missing(clear)
local nall = r(N)
quietly count if version == "main" & term == "post" & clear == 1 & cnt
local nclr = r(N)
quietly count if version == "main" & term == "pre" & clear == 1 & cnt
local nclr_pre = r(N)
quietly count if version == "strict" & term == "post" & shown & cnt & !missing(clear)
local sall = r(N)
quietly count if version == "strict" & term == "post" & clear == 1 & cnt
local sclr = r(N)
local still ""
foreach g in export_flag import_flag fdi_10_flag {
    quietly summarize still_pct if grouping == "`g'"
    local still "`still' `=string(r(mean), "%9.0f")'%,"
}
local still = strtrim(substr("`still'", 1, length("`still'") - 1))
local still = subinstr("`still'", ",", " and", 2)
local still = subinstr("`still'", " and", ",", 1)
display "   clear after: `nclr' of `nall'; clear before: `nclr_pre'; stricter groups clear after: `sclr' of `sall'; still recorded: `still'"

display "Step 8/9: dot-and-whisker plot: one row per outcome, three panels on one shared scale"
keep if in_figure
* scope-2 CO2 rows repeat the scope-2 energy rows exactly (checked in Step 6): say so on the row
replace row_label = "Scope 2 (same as energy row)" if inlist(outcome_id, 5, 11)
gen byte panel = gi
label define panel 1 "(a) Exporters" 2 "(b) Importers" 3 "(c) Foreign-owned (10%+)"
label values panel panel
* y position: 7 sections (heading line + up to 3 rows), in Deasy's order (R1-05's layout);
* after-Paris markers just above the row line, the before-Paris check below (apart, so they do not overlap)
gen byte s = cond(outcome_id <= 18, ceil(outcome_id / 3), 7)
gen byte j = cond(outcome_id <= 18, outcome_id - 3 * (s - 1), outcome_id - 18)
gen double yrow = 4 * (s - 1) + j
gen double y = yrow + cond(term == "pre", 0.24, -0.18)
local ylab ""
forvalues s = 1/7 {
    local h = 4 * (`s' - 1)
    local ylab `"`ylab' `h' "{bf:`sec`s''}""'
}
sort panel version term yrow
forvalues i = 1/`=_N' {
    if panel[`i'] == 1 & version[`i'] == "main" & term[`i'] == "post" {
        local yy = yrow[`i']
        local ll = row_label[`i']
        local ylab `"`ylab' `yy' "`ll'""'
    }
}
local ymax = 26.6
* marker sets
gen double xa = diff    if version == "main" & term == "post"    // after Paris, main
gen double xb = diff    if version == "main" & term == "pre"     // before-Paris check
gen double xc = diff    if version == "fe1"  & term == "post"    // after, firm + year averages only
gen double la = diff_lo if version == "main" & term == "post" & outcome_id != 14
gen double ha = diff_hi if version == "main" & term == "post" & outcome_id != 14
gen double lb = diff_lo if version == "main" & term == "pre"  & outcome_id != 14
gen double hb = diff_hi if version == "main" & term == "pre"  & outcome_id != 14
replace xb = . if outcome_id == 14         // row 14: one marker at 0 (no difference can exist)
replace xc = . if outcome_id == 14
* shared x scale: a round range (steps of 50) around every marker and interval
egen double xl = rowmin(xa xb xc la lb)
egen double xh = rowmax(xa xb xc ha hb)
quietly summarize xl
local xlo = 50 * floor(min(r(min), -50) / 50)
quietly summarize xh
local xhi = 50 * ceil(max(r(max), 50) / 50)
display "   x range `xlo' to `xhi'"
* the number at the right of every row: the after-Paris difference (main), whole %/points,
* gray when its 95% interval includes 0
gen str8 lab = cond(round(xa) == 0, "0", cond(xa > 0, "+", "") + string(round(xa), "%9.0f")) if !missing(xa)
local labx = `xhi' + 0.3 * (`xhi' - `xlo')
gen double labx = `labx' if !missing(xa)
gen double laby = y if !missing(xa)
* dashed 0 line in each panel and the number-column heading
local n0 = _N
set obs `=_N + 9'
gen double refx = 0 if _n > `n0'
gen double refy = .
gen double hx = .
gen double hy = .
gen str10 htxt = ""
forvalues p = 1/3 {
    replace panel = `p' in `=`n0' + 2*`p' - 1'
    replace panel = `p' in `=`n0' + 2*`p''
    replace refy = 0.5 in `=`n0' + 2*`p' - 1'
    replace refy = `ymax' in `=`n0' + 2*`p''
    local r = `n0' + 6 + `p'
    replace panel = `p' in `r'
    replace hx = `labx' in `r'
    replace hy = 0 in `r'
    replace htxt = "`post_yr'" in `r'
}
sort panel refy y
* Notes: one text, wrapped here into lines of at most 100 characters (PDF text runs wider than the PNG)
local ntext "Notes: Firms are grouped once, by their `base_txt' records (in the group if so recorded in either year; no record or answer = left out). ●~=~the group's change from `base_txt' to `post_yr' minus that of firms in the same industry and province, each firm against its own average (line = 95% interval; gray number: it includes 0, no clear difference). `post_yr' = the one later year whose energy records look normal. △~=~the same for `pre_txt': away from 0 = already moving apart before Paris (adopted December 2015). Counting only firms so recorded in every `base_txt' year they answered, `sclr'~of~`sall'~● are clear, not~`nclr'. A shrinking group uses less energy: read with the value added and workers rows. VA~=~value added = output value minus materials, energy and services bought, current prices. Table: `trans_yr' (transition), `all_rng' (Deasy's '2016+'), checks. Firm links are fictional: in `post_yr' only `still' of each group's answering firms are still so recorded. Association, not the effect of Paris."
local notelines ""
local line ""
foreach w of local ntext {
    if ustrlen("`line' `w'") > 100 & "`line'" != "" {
        local notelines `"`notelines' "`line'""'
        local line "`w'"
    }
    else local line = strtrim("`line' `w'")
}
local notelines `"`notelines' "`line'""'
* "~" keeps a number with its words on one line; it prints as a space
local notelines : subinstr local notelines "~" " ", all
display `"   note lines: `notelines'"'

* Stata draws markers about twice as large in the PNG as in the PDF, so each file gets its own
* marker size (same data, same layout)
foreach out in png pdf {
    local msz = cond("`out'" == "png", "vsmall", "small")
    twoway (rspike lb hb y, horizontal lcolor(gs10) lwidth(thin)) ///
        (rspike la ha y, horizontal lcolor(black) lwidth(medthin)) ///
        (scatter y xb, msymbol(Th) mcolor(gs7) mlwidth(thin) msize(`msz')) ///
        (scatter y xc, msymbol(O) mfcolor(white) mlcolor(black) mlwidth(medthin) msize(`msz')) ///
        (scatter y xa, msymbol(O) mcolor(black) msize(`msz')) ///
        (line refy refx, lpattern(dash) lcolor(gs8) lwidth(thin)) ///
        (scatter laby labx if clear == 1, msymbol(none) mlabel(lab) mlabpos(0) mlabsize(vsmall) mlabcolor(black)) ///
        (scatter laby labx if clear != 1, msymbol(none) mlabel(lab) mlabpos(0) mlabsize(vsmall) mlabcolor(gs9)) ///
        (scatter hy hx, msymbol(none) mlabel(htxt) mlabpos(0) mlabsize(vsmall) mlabcolor(black)), ///
        by(panel, rows(1) imargin(tiny) graphregion(color(white) lcolor(white) ilcolor(white) margin(r+3)) legend(pos(6)) ///
            title("Figure R1-09. Energy, CO2 and electricity: groups fixed before Paris vs similar firms", ///
                  size(small) pos(11) span) ///
            note(`notelines' "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6))) ///
        subtitle(, pos(11) nobox fcolor(white) lcolor(white) size(small)) ///
        yscale(reverse noline range(-0.3 `ymax')) ylabel(`ylab', angle(0) noticks tlength(0) nogrid labsize(vsmall)) ytitle("") ///
        xscale(range(`xlo' `=`labx' + 0.06 * (`xhi' - `xlo')') noline) ///
        xlabel(`xlo'(100)`xhi', format(%9.0f) noticks tlength(0) labsize(vsmall) grid glcolor(gs15) glwidth(vthin)) ///
        xmtick(`xlo'(50)`xhi', noticks tlength(0) grid glcolor(gs15) glwidth(vthin)) ///
        xtitle("Change from `base_txt': group minus similar firms, % (electricity rows: points)", size(vsmall)) ///
        legend(order(5 "After Paris: `post_yr' vs `base_txt'" 2 "95% interval, after" ///
                     3 "Before Paris (check): `pre_txt' vs `base_txt'" 1 "95% interval, before" ///
                     4 "After Paris, compared with all other firms" 6 "0 = no difference") ///
            cols(2) region(lcolor(none)) size(vsmall) symxsize(8) keygap(1) colgap(6) rowgap(0.5)) ///
        plotregion(style(none)) xsize(8) ysize(11)
    if "`out'" == "png" graph export "figures/09_frozen_groups_regression.png", width(2400) replace
    else graph export "figures/09_frozen_groups_regression.pdf", replace
}

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
* Source: the table saved right after the CSV export in Step 6 (full precision,
* same estimation run as the chart).
* The chart's symbols are named in words here (the table font has no such symbols).
local ntext_t : subinstr local ntext "~" " ", all
local ntext_t = usubinstr(`"`ntext_t'"', "●", "black dot", .)
local ntext_t = usubinstr(`"`ntext_t'"', "△", "triangle", .)
local ntext_t = itrim(`"`ntext_t'"')

* (1) Points table: one row per marker, panels (a) to (c), outcome rows top to
* bottom as on the chart (a heading row per section, as on the chart's axis), in
* each row: after Paris (black dot), the before-Paris check (triangle), after Paris
* against all other firms (hollow circle).
use `ctsrc', clear
keep if in_figure
local ncsv = _N
gen byte mk = cond(version == "main" & term == "post", 1, cond(version == "main", 2, 3))
sort gi outcome_id mk
gen str30 t_panel = cond(gi == 1, "(a) Exporters", cond(gi == 2, "(b) Importers", "(c) Foreign-owned (10%+)"))
gen str60 t_row = row_label
replace t_row = "Scope 2 (same as energy row)" if inlist(outcome_id, 5, 11)
replace t_row = uchar(160) + uchar(160) + uchar(160) + t_row      // indent under the section heading
gen str40 t_mk = cond(mk == 1, "After: `post_yr'", cond(mk == 2, "Before: `pre_txt'", "After, all firms"))
* the plotted difference (%, electricity rows in points), one decimal with a sign; the chart's
* whole-number label of each black dot is repeated in the status column
gen str12 t_v  = cond(round(diff, 0.1) > 0, "+", "") + string(diff, "%9.1f") if !missing(diff)
gen str12 t_lo = cond(round(diff_lo, 0.1) > 0, "+", "") + string(diff_lo, "%9.1f") if !missing(diff_lo)
gen str12 t_hi = cond(round(diff_hi, 0.1) > 0, "+", "") + string(diff_hi, "%9.1f") if !missing(diff_hi)
replace t_v = "0.0" if t_v == "-0.0"
gen str12 t_n = string(firms, "%12.0fc") if !missing(firms)
gen str12 t_r = string(rows,  "%12.0fc") if !missing(rows)
* status, with the black dot's label exactly as drawn (gray when the interval includes 0)
gen str12 lab = cond(round(diff) == 0, "0", cond(diff > 0, "+", "") + string(round(diff), "%9.0f")) if mk == 1 & !missing(diff)
gen str80 t_status = ""
replace t_status = "black dot, " + cond(clear == 1, "", "gray ") + "label " + lab if mk == 1 & shown
replace t_status = "gray triangle"  if mk == 2 & shown
replace t_status = "hollow circle"  if mk == 3 & shown
replace t_status = "not drawn: cannot differ" if outcome_id == 14 & mk > 1
replace t_status = "not drawn: too few firms" if !shown & t_status == ""
* two no-break spaces keep the status text off the numbers to its left
replace t_status = uchar(160) + uchar(160) + t_status if t_status != ""
* checks: one row per CSV figure row; every drawn marker has a number
assert t_status != ""
assert t_v != "" if !strpos(t_status, "not drawn")
assert _N == `ncsv'
quietly count if !strpos(t_status, "not drawn")
local npts = r(N)
display "   points drawn: `npts' of `ncsv' figure rows"
* a heading row before each section of each panel (not a point: no status)
gen long ord = 10 * _n
preserve
bysort gi section (ord): keep if _n == 1
replace ord = ord - 5
replace t_row = section
foreach v in t_mk t_v t_lo t_hi t_n t_r t_status {
    replace `v' = ""
}
tempfile hd
save `hd'
restore
append using `hd'
sort ord
quietly count if t_status != ""
assert r(N) == `ncsv'
* thin rules at the end of each section and panel
gen long rr = _n
gen byte endsec = section != section[_n + 1] | gi != gi[_n + 1]
quietly levelsof rr if endsec & _n < _N, local(rl)
local tnote "Table: every marker of Figure R1-09, panel by panel, rows as on the chart. Difference = group minus similar firms,"
local tnote "`tnote' change from `base_txt': 100 × (exp(b) − 1) % for log outcomes, b in points for the electricity rows; b and its"
local tnote "`tnote' standard error are in the regression table. Firms (clusters) and firm-years in the regression behind the point."
local tnote "`tnote' Marker: After = `post_yr' vs `base_txt' (main); Before = `pre_txt' vs `base_txt' (main, the check); After, all firms = `post_yr'"
local tnote "`tnote' vs `base_txt' with firm + year averages only. Status: the symbol drawn, and the black dot's label as printed (gray: the 95%"
local tnote "`tnote' interval includes 0). Full precision and every other version and period: tables/09_frozen_groups_regression.csv."
ctable_pdf t_panel t_row t_mk t_v t_lo t_hi t_n t_r t_status using "tables/09_frozen_groups_regression_table.pdf", ///
    title("Table R1-09. Energy, CO2 and electricity: groups fixed before Paris vs similar firms: every plotted point") ///
    header("Panel" "Row" "Marker" "Difference|(% or points)" "95%|low" "95%|high" "Firms" "Firm-|years" "Status") ///
    right(4 5 6 7 8) norepeat(1 2) fontsize(8) rules(`rl') perpage(32) subtitle("`tnote'") ///
    notes("`ntext_t'" "`srcnote'" "`devnote'")
display "table -> tables/09_frozen_groups_regression_table.pdf"

* (2) Regression table (AER style): the drawn rows, for each group; columns (1)-(2) the main
* model, (3)-(4) firm + year averages only; coefficient on the first line, (standard error) on
* the second. show_pct = 1 adds a third line, [% difference]; off here (the drawn %s are in
* the points table).
local show_pct 0
use `ctsrc', clear
keep if inlist(version, "main", "fe1") & inlist(term, "pre", "post")
* check: the coefficients are those in the CSV just written (4 decimals there)
preserve
import delimited using "tables/09_frozen_groups_regression.csv", clear varnames(1) stringcols(1 4 10)
keep if inlist(version, "main", "fe1") & inlist(term, "pre", "post")
keep grouping version outcome_id term b se
rename (b se) (b_csv se_csv)
tempfile csvb
save `csvb'
restore
merge 1:1 grouping version outcome_id term using `csvb', assert(match) nogenerate
assert abs(b - b_csv) <= 0.00005 + 1e-9 if !missing(b)
assert abs(se - se_csv) <= 0.00005 + 1e-9 if !missing(se)
drop b_csv se_csv
* one regression per group x version x outcome: pre and post share its counts
bysort grouping version outcome_id (term): assert rows[1] == rows[2] & firms[1] == firms[2]
tempname P
tempfile R
postfile `P' str120 t_lab str24(t1 t2 t3 t4 t5 t6 t7 t8) using `R'
local nterm 0
local grl ""
local frz ""
local ind = uchar(160) + uchar(160) + uchar(160)     // indent: kept by the writer (not an ASCII space)
forvalues g = 1/3 {
    quietly summarize firms_g1 if gi == `g', meanonly
    local f1 = string(r(mean), "%12.0fc")
    quietly summarize firms_g0 if gi == `g', meanonly
    local f0 = string(r(mean), "%12.0fc")
    local gl = word("A B C", `g')
    local gn = cond(`g' == 1, "Exporters", cond(`g' == 2, "Importers", "Foreign-owned (10%+)"))
    post `P' ("Panel `gl'. `gn'") ("") ("") ("") ("") ("") ("") ("") ("")
    local frz "`frz'`gn' `f1' (other firms `f0'), "
    local ++nterm
    forvalues s = 1/7 {
        post `P' ("`sec`s''") ("") ("") ("") ("") ("") ("") ("") ("")
        local ++nterm
        quietly levelsof outcome_id if gi == `g' & section == "`sec`s''", local(ks)
        foreach k of local ks {
            quietly levelsof row_label if outcome_id == `k', local(rlab) clean
            if inlist(`k', 5, 11) local rlab "Scope 2 (same as energy row)"
            local j 0
            foreach v in main fe1 {
                foreach t in pre post {
                    local ++j
                    quietly summarize b if gi == `g' & outcome_id == `k' & version == "`v'" & term == "`t'", meanonly
                    local bb = r(mean)
                    quietly summarize se if gi == `g' & outcome_id == `k' & version == "`v'" & term == "`t'", meanonly
                    local ss = r(mean)
                    quietly summarize diff if gi == `g' & outcome_id == `k' & version == "`v'" & term == "`t'", meanonly
                    local dd = r(mean)
                    quietly summarize shown if gi == `g' & outcome_id == `k' & version == "`v'" & term == "`t'", meanonly
                    local sh = r(mean)
                    if missing(`ss') | !`sh' {
                        local c`j' "—"
                        local e`j' ""
                        local p`j' ""
                    }
                    else {
                        local c`j' = string(`bb', "%9.3f")
                        local e`j' = "(" + string(`ss', "%9.3f") + ")"
                        local p`j' = "[" + cond(`dd' > 0, "+", "") + string(`dd', "%9.1f") + cond(inlist(`k', 16, 17, 18), "]", "%]")
                    }
                }
                quietly summarize rows if gi == `g' & outcome_id == `k' & version == "`v'", meanonly
                local o_`v' = cond(missing(r(mean)), "—", string(r(mean), "%12.0fc"))
                quietly summarize firms if gi == `g' & outcome_id == `k' & version == "`v'", meanonly
                local f_`v' = cond(missing(r(mean)), "—", string(r(mean), "%12.0fc"))
            }
            post `P' ("`ind'`rlab'") ("`c1'") ("`c2'") ("`o_main'") ("`f_main'") ("`c3'") ("`c4'") ("`o_fe1'") ("`f_fe1'")
            if "`e1'`e2'`e3'`e4'" != "" {          // row 14 (not estimated) has no second line
                post `P' ("")       ("`e1'") ("`e2'") ("")         ("")         ("`e3'") ("`e4'") ("")        ("")
                local ++nterm
                if `show_pct' post `P' ("") ("`p1'") ("`p2'") ("") ("") ("`p3'") ("`p4'") ("") ("")
                if `show_pct' local ++nterm
            }
            local ++nterm
        }
    }
    local grl "`grl' `nterm'"
}
* whole-model rows: the fixed effects read from the absorb() lists used in Step 4
foreach v in 2 1 {
    local fef`v' = cond(strpos(" `fe`v'' ", " firm_id "),   "Yes", "No")
    local fei`v' = cond(strpos(" `fe`v'' ", " ind#year "),  "Yes", "No")
    local fep`v' = cond(strpos(" `fe`v'' ", " prov#year "), "Yes", "No")
    local fey`v' = cond(strpos(" `fe`v'' ", " year "),      "Yes", cond(strpos(" `fe`v'' ", "#year "), "Absorbed", "No"))
}
post `P' ("Firm fixed effects")              ("`fef2'") ("`fef2'") ("") ("") ("`fef1'") ("`fef1'") ("") ("")
post `P' ("Industry × year fixed effects")   ("`fei2'") ("`fei2'") ("") ("") ("`fei1'") ("`fei1'") ("") ("")
post `P' ("Province × year fixed effects")   ("`fep2'") ("`fep2'") ("") ("") ("`fep1'") ("`fep1'") ("") ("")
post `P' ("Year fixed effects")              ("`fey2'") ("`fey2'") ("") ("") ("`fey1'") ("`fey1'") ("") ("")
post `P' ("Weights")                         ("None") ("None") ("") ("") ("None") ("None") ("") ("")
post `P' ("Standard errors clustered by")    ("Firm") ("Firm") ("") ("") ("Firm") ("Firm") ("") ("")
post `P' ("Compared with (reference years)") ("`base_txt'") ("`base_txt'") ("") ("") ("`base_txt'") ("`base_txt'") ("") ("")
postclose `P'
use `R', clear
local grl = strtrim("`grl'")
local rsub "Coefficient b: the group's change from `base_txt' minus that of similar firms, log points (electricity rows: percentage points);"
local rsub "`rsub' standard errors in parentheses. (1)–(2): main model; (3)–(4): firm + year averages only."
local rnote "Notes: Each outcome and group is one regression of the outcome on the frozen group marker × one marker per period"
local rnote "`rnote' (years `pre_yrs' / `trans_yr' / `jump_yrs' / `post_yr' / `doubt_yrs'; `base_txt' = reference, set to 0), with the fixed effects shown;"
local rnote "`rnote' the `pre_txt' and `post_yr' coefficients are shown (drawn in Figure R1-09: (1) and (2) as triangle and black dot,"
local rnote "`rnote' (4) as hollow circle); the other periods and versions are in tables/09_frozen_groups_regression.csv. Obs. = firm-years;"
local rnote "`rnote' Firms = clusters; they differ by outcome because each outcome uses only firms with its quantities above zero."
local rnote "`rnote' Own-electricity rows leave out `og_skip' (under `og_min'% recorded), so their reference years are `=strtrim("`keep_base_yrs'")'."
local rnote "`rnote' Scope 2 GJ per tonne of CO2 is the same for every firm in a year (one grid factor): not estimated (—; the chart"
local rnote "`rnote' draws 0). Scope-2 CO2 rows repeat the scope-2 energy rows exactly. Year fixed effects absorbed = inside industry × year."
local frz = substr("`frz'", 1, length("`frz'") - 2)
local rnote "`rnote' Frozen groups (firms): `frz'. % difference = 100 × (exp(b) − 1). No stars."
ctable_pdf t_lab t1 t2 t3 t4 t5 t6 t7 t8 using "tables/09_frozen_groups_regression_regression.pdf", ///
    title("Table R1-09, regression. Energy, CO2 and electricity: groups fixed before Paris vs similar firms") ///
    subtitle("`rsub'") ///
    header("Outcome" "(1)|`pre_txt'|× group" "(2)|`post_yr'|× group" "Obs.|(1)–(2)" "Firms|(1)–(2)" ///
           "(3)|`pre_txt'|× group" "(4)|`post_yr'|× group" "Obs.|(3)–(4)" "Firms|(3)–(4)") ///
    right(2 3 4 5 6 7 8 9) rules(`grl') fontsize(9) perpage(50) portrait ///
    notes("`rnote'" "`srcnote'" "`devnote'")
display "table -> tables/09_frozen_groups_regression_regression.pdf"
* --- end of PART 2 ------------------------------------------------------------

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/09_frozen_groups_regression.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
