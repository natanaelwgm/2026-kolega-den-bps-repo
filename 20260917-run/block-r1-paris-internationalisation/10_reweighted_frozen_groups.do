/*==========================================================================
  R1-10  Groups frozen before Paris, again, but with the other firms
         reweighted so that in 2013-14 they look like each group: the same
         average size (workers, value added), energy and CO2 per unit of
         value added, share of bought electricity, own electricity, industry
         mix and island. Do R1-09's answers hold when the comparison firms
         are made alike before Paris (adopted December 2015)?
  Answers Deasy R1: "Matching/entropy balancing dapat digunakan sebagai
         robustness untuk membuat pre-Paris groups comparable"; run on R1-09's
         design ("Freeze internationalisation status sebelum Paris, misalnya
         average 2013-14 ...; Firm FE + industry x year FE + province x year
         FE") for every listed outcome (table; the main rows drawn).
  Method : entropy balancing (Hainmueller 2012), written out in Mata below,
         so the add-on ebalance is not needed. Each other firm gets one
         weight, as close to equal weights as possible, such that the
         weighted 2013-14 averages of the other firms equal the group's
         exactly. R1-09's regression is then run with these weights.
         Foreign-owned = 10% or more of the firm's capital held abroad
         (fdi_10_flag), the definition used in every R1-R3 exhibit.
  Output : figures/10_reweighted_frozen_groups.png (+ .pdf)
           tables/10_reweighted_frozen_groups.csv          (every outcome x group x
                  version x period; the figure uses the rows with in_figure = 1)
           tables/10_reweighted_frozen_groups_balance.csv  (the 2013-14 gaps before
                  and after weighting, also among the firms recorded in 2018, and what
                  the weighted other firms are worth)
  Needs  : Stata add-ons reghdfe and ftools from SSC (reghdfe 6 also needs
           require), installed once (ssc install reghdfe, ssc install ftools,
           ssc install require); the file never installs anything and stops
           with a plain message if one is missing.
  Runtime: about 1 minute on the development file (about 400 regressions);
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

* ---- THE DESIGN (why: INDEX.md, paragraph "10") ------------------------------------------
* Periods, group rule and support rules are R1-09's, unchanged:
local base_yrs  "2013 2014"            // groups frozen from these years; the comparison years; and the
                                       // ONLY years the balancing measures come from (before Paris)
local rule_min  0.5                    // in the group if flagged in at least half of its known 2013-14 years
local pre_yrs   "2010 2011 2012"       // check before Paris
local trans_yr  2015                   // transition year: own period
local jump_yrs  "2017"                 // energy records jump for many firms: own period
local post_yr   2018                   // the after-Paris year drawn (the one later year whose records look normal)
local doubt_yrs "2019 2020 2021 2022"  // many energy records drop far below earlier years: own period
local min_n     30                     // a period is shown only with 30+ group firms and 30+ other firms in
                                       // each of its years and each comparison year ...
local min_worth 30                     // ... and weighted other firms worth 30+ firms in each of those years
local og_min    75                     // own-electricity rows use a year only if 75%+ of frozen firms have it recorded
* Reweighting (new in R1-10):
local eb_tol    1e-6                   // balance is reached when every weighted gap is below a millionth of a spread
local eb_maxit  500                    // at most this many Newton steps
* -------------------------------------------------------------------------------------------

cap log close
log using "logs/10_reweighted_frozen_groups.log", replace text
timer clear 1
timer on 1
display _newline "=== [R1-10] STARTING: groups frozen by 2013-14 status, other firms reweighted to match them ==="

* reghdfe (with ftools; reghdfe 6 also needs require) runs regressions that take out many sets
* of averages at once
foreach p in reghdfe ftools require {
    capture which `p'
    if _rc {
        display as error "R1-10 needs the Stata add-on `p'. Install it once: ssc install `p'  - then run this file again."
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
* island group from the province code's first digit (BPS numbering): 1-2 = Sumatra (21 = Riau
* Islands), 3 = Java, 5-9 = the other islands (Bali and Nusa Tenggara, Kalimantan, Sulawesi, Maluku, Papua)
* (a firm with no province code gets no island and is left out of the reweighting, counted)
assert inlist(substr(province_code, 1, 1), "1", "2", "3", "5", "6", "7", "8", "9", "")
gen byte island = cond(inlist(substr(province_code, 1, 1), "1", "2"), 1, cond(substr(province_code, 1, 1) == "3", 2, 3)) ///
    if province_code != ""
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
}

display "Step 3/9: the balancing measures: each firm's own 2013-14 averages (before Paris only)"
* Only 2013-14 records with value added, energy, CO2 and workers above zero are used (cv = 1).
* A frozen firm with no such record cannot be reweighted and is left out of this exhibit (counted).
* Logs, so that a few very large firms do not dominate the averages.
gen byte cv = base & value_added_nominal > 0 & total_gj_s1 > 0 & co2_total_s1 > 0 & workers > 0 ///
    & !missing(value_added_nominal, total_gj_s1, co2_total_s1, workers)
bysort firm_id: egen double m1 = mean(cond(cv, ln(workers), .))                            // workers (log)
bysort firm_id: egen double m2 = mean(cond(cv, ln(value_added_nominal), .))                // value added (log)
bysort firm_id: egen double m3 = mean(cond(cv, ln(total_gj_s1 / value_added_nominal), .))  // energy per VA (log)
bysort firm_id: egen double m4 = mean(cond(cv, ln(co2_total_s1 / value_added_nominal), .)) // CO2 per VA (log)
bysort firm_id: egen double m5 = mean(cond(cv, 100 * gj_electricity / total_gj_s1, .))     // bought electricity, % of energy
* own electricity from the 2013-14 records where it is recorded (in 2014 it often is not)
gen byte ogk = base & own_gen_unknown == 0 & !missing(elec_owngen_kwh)
bysort firm_id: egen byte n_ogk = total(ogk)
bysort firm_id: egen byte n_ogp = total(ogk & elec_owngen_kwh > 0)
gen double m6 = 100 * (n_ogp > 0)           // made some own electricity in a recorded 2013-14 year (0/100)
gen double m7 = 100 * (n_ogk == 0)          // own electricity not recorded in any of its 2013-14 years (0/100)
* firms also recorded in the drawn later year with value added, energy and CO2 above zero: only
* they carry the drawn after-Paris comparison (checked for balance; re-weighted as a check)
gen byte r18 = year == `post_yr' & value_added_nominal > 0 & total_gj_s1 > 0 & co2_total_s1 > 0 ///
    & !missing(value_added_nominal, total_gj_s1, co2_total_s1)
bysort firm_id: egen byte h18 = max(r18)
* one row per frozen firm with its measures, industry, island and frozen status
egen byte firm1 = tag(firm_id)
preserve
keep if firm1 & nbase > 0
keep firm_id ind island m1 m2 m3 m4 m5 m6 m7 fz_* fzs_* h18
tempfile firmdata
save `firmdata'
restore

display "Step 4/9: outcomes per firm and year (R1-09's rows, same code: logs, so a difference reads as %)"
* "Absent is not zero": each outcome uses only firms whose quantities in it are above zero
* (R1-05's rule): scope-1 rows: fuel energy and fuel CO2 > 0; scope-2 rows: bought electricity > 0;
* total rows: total energy and total CO2 > 0. Value added > 0 in all.
gen byte va_ok = value_added_nominal > 0 & !missing(value_added_nominal)
gen byte s1 = va_ok & gj_fuel_s1 > 0     & co2_scope1_s1 > 0 & !missing(gj_fuel_s1, co2_scope1_s1)
gen byte s2 = va_ok & gj_electricity > 0 & co2_scope2_s1 > 0 & !missing(gj_electricity, co2_scope2_s1)
gen byte st = va_ok & total_gj_s1 > 0    & co2_total_s1 > 0  & !missing(total_gj_s1, co2_total_s1)
gen byte og = st & own_gen_unknown == 0 & !missing(elec_owngen_kwh, elec_purchased_kwh)
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
* no firm or group difference can exist, so it is not estimated (as R1-05 and R1-09)
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
* the periods (each its own term; the comparison years are the 2013-14 pair)
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
assert p_pre + base + p_trans + p_jump + p_post + p_doubt == 1   // every year sits in exactly one period
keep if nbase > 0                         // only firms with a 2013-14 record can be frozen
keep firm_id year ind prov fz_* fzs_* y1-y20 base p_*
compress
tempfile basedata
save `basedata'

* ---- Entropy balancing, written out (Hainmueller 2012) -----------------------------------
mata:
// C = the other firms' balancing measures (one row per firm); m = the group's averages (targets).
// Returns one weight per other firm (adding up to 1). The weights are as close to equal weights
// as possible (smallest "entropy" distance) while the weighted averages C'w equal m exactly.
// They take the form w = exp(Z*lam) / sum(exp(Z*lam)) with Z = (C - m) / spread, one lam per
// measure; lam is found by Newton steps that minimise ln(sum(exp(Z*lam))) (the "dual" problem),
// whose slope is exactly the remaining weighted gap. Done when every gap is below tol spreads.
real colvector r110eb(real matrix C, real rowvector m, real scalar tol, real scalar maxit)
{
    real matrix Z, H
    real colvector lam, e, w, step
    real rowvector s, g
    real scalar it, L, Lnew, a, top
    s   = sqrt(diagonal(variance(C)))'       // each measure's spread among the other firms
    Z   = (C :- m) :/ s                       // distance from the group's average, in spreads
    lam = J(cols(Z), 1, 0)                    // start from equal weights
    for (it = 0; it <= maxit; it++) {
        e   = Z * lam
        top = max(e)                          // (taking out the largest avoids overflow in exp)
        w   = exp(e :- top)
        L   = ln(sum(w)) + top                // the dual: what the Newton steps make smaller
        w   = w / sum(w)
        g   = w' * Z                          // remaining weighted gap per measure (= the slope)
        if (max(abs(g)) < tol) break
        H   = (Z :* w)' * Z - g' * g          // curvature = weighted spread of Z
        step = -cholsolve(H, g')
        if (hasmissing(step)) step = -pinv(H) * g'
        a = 1                                 // halve the step until the dual falls enough
        while (a > 1e-12) {
            e    = Z * (lam + a * step)
            top  = max(e)
            Lnew = ln(sum(exp(e :- top))) + top
            if (Lnew <= L + 1e-4 * a * (g * step)) break
            a = a / 2
        }
        if (a <= 1e-12) break                 // no further progress possible (rounding): stop here
        lam = lam + a * step
    }
    st_numscalar("r110_iter", it)
    st_numscalar("r110_gap", max(abs(g)))
    return(w)
}
end

display "Step 5/9: weights: other firms made to match each group's 2013-14 averages, and the balance check"
* Three sets of weights per grouping:
*   m  = main: match the group's averages of the seven measures, industry shares and island shares;
*   sd = check: also match the spreads of the five measures m1-m5 (their squared distance from
*        the group's average);
*   st = the stricter group (flagged in every known 2013-14 year), main measures;
*   s18 = check: main measures, balanced only among the firms also recorded in the drawn later
*        year (only they carry the drawn comparison, and the main weights need not balance them).
* Group firms keep weight 1; the other firms' weights add up to the number of group firms.
tempname hb
tempfile balance
postfile `hb' str12 grouping str3 weights str14 measure double(mean_g mean_o mean_ow sd_pool ///
    std_before std_after vratio_before vratio_after) long(firms_g1 firms_g0 drop_g1 drop_g0 ///
    drop_nomeas iter) double(worth_g0 wmax_ratio gap_max) byte balanced using `balance', replace
local wfiles ""
foreach g in export_flag import_flag fdi_10_flag {
    foreach wv in m sd st s18 {
        use `firmdata', clear
        local G = cond("`wv'" == "st", "fzs_`g'", "fz_`g'")
        keep if !missing(`G')                       // frozen firms of this grouping
        if "`wv'" == "s18" keep if h18 == 1         // check: only firms also recorded in the drawn later year
        quietly count if missing(m1) | missing(ind, island)
        local dnm = r(N)                            // no usable 2013-14 record (or no industry or
        drop if missing(m1) | missing(ind, island)  // province code): cannot be balanced
        gen byte t  = `G'
        gen byte t0 = 1 - t
        * an industry or island with firms of only one kind cannot be balanced: its firms are left out
        bysort ind: egen long n1i = total(t)
        bysort ind: egen long n0i = total(t0)
        bysort island: egen long n1r = total(t)
        bysort island: egen long n0r = total(t0)
        gen byte off = n1i == 0 | n0i == 0 | n1r == 0 | n0r == 0
        quietly count if off & t == 1
        local d1 = r(N)
        quietly count if off & t == 0
        local d0 = r(N)
        drop if off
        quietly count if t == 1
        local n1 = r(N)
        quietly count if t == 0
        local n0 = r(N)
        * industry and island shares as 0/100 columns; one category of each is left out (shares add to 100)
        quietly tab ind, gen(I_)
        quietly tab island, gen(R_)
        foreach v of varlist I_* R_* {
            quietly replace `v' = 100 * `v'
        }
        drop I_1 R_1
        local X "m1 m2 m3 m4 m5 m6 m7 I_* R_*"
        if "`wv'" == "sd" {
            forvalues j = 1/5 {
                quietly summarize m`j' if t == 1
                gen double v`j' = (m`j' - r(mean))^2
            }
            local X "`X' v1-v5"
        }
        unab X : `X'
        * a measure that is the same for every other firm cannot be moved by weights: left out of the
        * targets here; the balance check below still tests it
        local XX ""
        foreach v of local X {
            quietly summarize `v' if t == 0
            if r(sd) > 0 local XX "`XX' `v'"
        }
        mata: r110w = r110eb(st_data(., "`XX'", "t0"), mean(st_data(., "`XX'", "t")), `eb_tol', `eb_maxit')
        gen double w = 1 if t == 1
        mata: st_store(., "w", "t0", r110w * `n1')
        local it  = scalar(r110_iter)
        local gap = scalar(r110_gap)
        * what the weighted other firms are worth: as many equally weighted firms as (sum w)^2 / sum w^2
        gen double w2 = w^2
        quietly summarize w if t == 0
        local sw = r(sum)
        local wmr = r(max) / r(mean)                // largest weight / average weight
        quietly summarize w2 if t == 0
        local worth = `sw'^2 / r(sum)
        * balance check on every target (asserted below): weighted gap in spreads
        local bal = `gap' < `eb_tol'
        foreach v of local X {
            quietly summarize `v' if t == 1
            local mg = r(mean)
            local vg = r(Var)
            quietly summarize `v' if t == 0
            local vo = r(Var)
            quietly summarize `v' [aw = w] if t == 0
            if abs(`mg' - r(mean)) > 1e-5 * sqrt((`vg' + `vo') / 2) local bal 0
        }
        display "   `g' (`wv'): `n1' in group, `n0' others, worth " %6.1f `worth' ///
            "; steps `it'; balanced: " cond(`bal', "yes", "NO")
        if !`bal' {
            display as error "   balance NOT reached for `g' (`wv'): its reweighted rows are left empty"
            replace w = .
        }
        * the table: every measure, each industry and island, before and after weighting
        quietly levelsof ind, local(inds)
        foreach l of local inds {
            gen double ind_`l' = 100 * (ind == `l')
        }
        forvalues l = 1/3 {
            gen double isl_`l' = 100 * (island == `l')
        }
        foreach v of varlist m1 m2 m3 m4 m5 m6 m7 ind_* isl_* {
            quietly summarize `v' if t == 1
            local mg = r(mean)
            local vg = r(Var)
            quietly summarize `v' if t == 0
            local mo = r(mean)
            local vo = r(Var)
            local sdp = sqrt((`vg' + `vo') / 2)
            local mow = .
            local vow = .
            if `bal' {
                quietly summarize `v' [aw = w] if t == 0
                local mow = r(mean)
                local vow = r(Var)
            }
            local sb = cond(`sdp' > 0, (`mg' - `mo') / `sdp', .)
            local sa = cond(`sdp' > 0, (`mg' - `mow') / `sdp', .)
            local vb = cond(`vo' > 0 & inlist("`v'", "m1", "m2", "m3", "m4", "m5"), `vg' / `vo', .)
            local va = cond(`vow' > 0 & inlist("`v'", "m1", "m2", "m3", "m4", "m5"), `vg' / `vow', .)
            post `hb' ("`g'") ("`wv'") ("`v'") (`mg') (`mo') (`mow') (`sdp') (`sb') (`sa') (`vb') (`va') ///
                (`n1') (`n0') (`d1') (`d0') (`dnm') (`it') (`worth') (`wmr') (`gap') (`bal')
        }
        * the main weights, checked only among the firms also recorded in the drawn later year (they
        * carry the drawn comparison; the weights were not asked to balance them): rows "m18"
        if "`wv'" == "m" & `bal' {
            quietly count if t == 1 & h18 == 1
            local n1s = r(N)
            quietly count if t == 0 & h18 == 1
            local n0s = r(N)
            quietly summarize w if t == 0 & h18 == 1
            local sws = r(sum)
            local wmrs = r(max) / r(mean)
            quietly summarize w2 if t == 0 & h18 == 1
            local worths = `sws'^2 / r(sum)
            foreach v of varlist m1 m2 m3 m4 m5 m6 m7 ind_* isl_* {
                quietly summarize `v' if t == 1 & h18 == 1
                local mg = r(mean)
                local vg = r(Var)
                quietly summarize `v' if t == 0 & h18 == 1
                local mo = r(mean)
                local vo = r(Var)
                quietly summarize `v' [aw = w] if t == 0 & h18 == 1
                local mow = r(mean)
                local vow = r(Var)
                local sdp = sqrt((`vg' + `vo') / 2)
                local sb = cond(`sdp' > 0, (`mg' - `mo') / `sdp', .)
                local sa = cond(`sdp' > 0, (`mg' - `mow') / `sdp', .)
                local vb = cond(`vo' > 0 & inlist("`v'", "m1", "m2", "m3", "m4", "m5"), `vg' / `vo', .)
                local va = cond(`vow' > 0 & inlist("`v'", "m1", "m2", "m3", "m4", "m5"), `vg' / `vow', .)
                post `hb' ("`g'") ("m18") ("`v'") (`mg') (`mo') (`mow') (`sdp') (`sb') (`sa') (`vb') (`va') ///
                    (`n1s') (`n0s') (`d1') (`d0') (`dnm') (`it') (`worths') (`wmrs') (.) (.)
            }
            display "      of which also recorded in `post_yr': `n1s' in group, `n0s' others, worth " %6.1f `worths'
        }
        keep firm_id w
        rename w w`wv'_`g'
        tempfile wf_`g'_`wv'
        save `wf_`g'_`wv''
        local wfiles "`wfiles' `wf_`g'_`wv''"
    }
}
postclose `hb'
* every frozen firm gets its weights (missing = not in that balancing sample)
use `basedata', clear
foreach f of local wfiles {
    merge m:1 firm_id using `f', nogenerate keep(master match)
}
save `basedata', replace

* Program: the smallest number of firms of the group (g = 1) and of the other firms (g = 0), and
* the smallest worth of the weighted other firms, in any year of a list, among the rows the last
* regression used (es = 1). Years with no rows at all are skipped.
capture program drop r110min
program define r110min, rclass
    args yrs
    local m1 = .
    local m0 = .
    local e0 = .
    foreach y of local yrs {
        quietly count if es & year == `y'
        if r(N) > 0 {
            quietly count if es & year == `y' & gcnt == 1
            local m1 = min(`m1', r(N))
            quietly count if es & year == `y' & gcnt == 0
            local m0 = min(`m0', r(N))
            quietly summarize wreg if es & year == `y' & gcnt == 0
            local sw = r(sum)
            quietly summarize wreg2 if es & year == `y' & gcnt == 0
            if r(sum) > 0 local e0 = min(`e0', `sw'^2 / r(sum))
            else local e0 = 0
        }
    }
    return scalar m1 = `m1'
    return scalar m0 = `m0'
    return scalar e0 = `e0'
end

display "Step 6/9: regressions: every outcome x group x version, with and without weights (firm-clustered 95% intervals)"
* Model (R1-09's main): outcome = firm's own average + one average per industry and year + one per
* province and year + the group's extra change in each period, against 2013-14:
*   b_period = (group's change from 2013-14 to that period) - (other firms' change), in log points.
* With weights, each other firm counts as much as its weight in every year (group firms count 1).
* The 95% intervals treat the weights as known (they are not re-estimated for each interval).
* Versions:
*   unw        not reweighted: R1-09's main model on the firms that can be balanced (figure: hollow circle)
*   eb         reweighted (main weights)                  (figure: black dot 2018, triangle 2010-12)
*   eb_sd      reweighted to match the spreads as well
*   eb_fe1     reweighted, firm + year averages only (the weights already match industry and island)
*   unw_st     stricter group, not reweighted
*   eb_st      stricter group, reweighted
*   eb_s18     reweighted only among the firms also recorded in the drawn later year (check)
*   eb_yearly  reweighted, one marker per year against 2013-14 (rows 3 and 6)
local fe2 "firm_id ind#year prov#year"
local fe1 "firm_id year"
local ylist "1 2 3 4 5 6 7 8 9 10 11 12 13 15 16 17 18 19 20"
local versions "unw eb eb_sd eb_fe1 unw_st eb_st eb_s18 eb_yearly"
quietly levelsof year, local(allyrs)
tempname P
tempfile res
postfile `P' str12 grouping str10 version int outcome_id str8 term double(b se df_r) ///
    long(rows firms singletons n_g1_min n_g0_min ref_g1_min ref_g0_min) double(worth_g0_min ref_worth_g0_min) ///
    using `res', replace
foreach g in export_flag import_flag fdi_10_flag {
    display "   `g': 19 outcomes x 7 versions + 2 yearly"
    use `basedata', clear
    keep if !missing(wm_`g') | !missing(wst_`g')     // firms in a balancing sample of this grouping
    foreach v of local versions {
        capture drop X gcnt wreg wreg2 t_*
        local wv = cond(inlist("`v'", "unw_st", "eb_st"), "st", cond("`v'" == "eb_sd", "sd", cond("`v'" == "eb_s18", "s18", "m")))
        if "`wv'" == "st" gen double X = fzs_`g'
        else gen double X = fz_`g'
        gen byte gcnt = X                              // who counts as "the group" for the counts
        * the weight each row gets (1 = not reweighted); rows without a weight are not used
        gen double wreg = cond(substr("`v'", 1, 3) == "unw", 1, w`wv'_`g') if !missing(w`wv'_`g')
        gen double wreg2 = wreg^2
        local wexp = cond(substr("`v'", 1, 3) == "unw", "", "[pw = wreg]")
        local ab "`fe2'"
        if "`v'" == "eb_fe1" local ab "`fe1'"
        if "`v'" == "eb_yearly" {
            local terms ""
            foreach y of local allyrs {
                if !inlist(`y', `base_in') {
                    gen double t_e`y' = X * (year == `y')
                    local terms "`terms' t_e`y'"
                }
            }
            local ks "3 6"
        }
        else {
            foreach p in pre trans jump post doubt {
                gen double t_`p' = X * p_`p'
            }
            local terms "t_pre t_trans t_jump t_post t_doubt"
            local ks "`ylist'"
        }
        quietly count if !missing(wreg, X)
        local nuse = r(N)
        foreach k of local ks {
            capture drop es
            if `nuse' > 0 {
                quietly reghdfe y`k' `terms' if !missing(wreg, X) `wexp', absorb(`ab') vce(cluster firm_id)
                gen byte es = e(sample)
                local N  = e(N)
                local G  = e(N_clust)
                local df = e(df_r)
                local S  = e(num_singletons)
                if "`S'" == "" local S 0
                r110min "`base_yrs'"
                local r1 = r(m1)
                local r0 = r(m0)
                local re = r(e0)
            }
            foreach t of local terms {
                local tn = substr("`t'", 3, .)
                if "`tn'" == "pre"   local tyrs "`pre_yrs'"
                if "`tn'" == "trans" local tyrs "`trans_yr'"
                if "`tn'" == "jump"  local tyrs "`jump_yrs'"
                if "`tn'" == "post"  local tyrs "`post_yr'"
                if "`tn'" == "doubt" local tyrs "`doubt_yrs'"
                if substr("`tn'", 1, 1) == "e" local tyrs = substr("`tn'", 2, .)
                if `nuse' == 0 {
                    * balance not reached: row left empty (said in the note column)
                    post `P' ("`g'") ("`v'") (`k') ("`tn'") (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.)
                    continue
                }
                r110min "`tyrs'"
                local n1 = r(m1)
                local n0 = r(m0)
                local e0 = r(e0)
                * a period with no rows (e.g. 2015 for own electricity) is dropped by reghdfe: left empty
                capture local sechk = _se[`t']
                if _rc local sechk = .
                if `sechk' == 0 | missing(`sechk') {
                    post `P' ("`g'") ("`v'") (`k') ("`tn'") (.) (.) (`df') (`N') (`G') (`S') (`n1') (`n0') (`r1') (`r0') (`e0') (`re')
                }
                else {
                    post `P' ("`g'") ("`v'") (`k') ("`tn'") (_b[`t']) (_se[`t']) (`df') (`N') (`G') (`S') (`n1') (`n0') (`r1') (`r0') (`e0') (`re')
                }
            }
        }
        * row 14 (GJ per tonne of CO2, bought electricity): the same for every firm, no regression
        if "`v'" != "eb_yearly" {
            foreach tn in pre trans jump post doubt {
                post `P' ("`g'") ("`v'") (14) ("`tn'") (0) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.)
            }
        }
    }
}
postclose `P'

display "Step 7/9: tables -> CSV (numbers written before drawing)"
* (0) share of each group's firms still so recorded in 2018 (links are fictional; for the notes)
tempname hs
tempfile still
postfile `hs' str12 grouping long(still_n still_known) double still_pct using `still', replace
use firm_id year export_flag import_flag fdi_10_flag using "$DATA", clear
merge 1:1 firm_id year using `basedata', keepusing(fz_* wm_*) keep(match) nogenerate
foreach g in export_flag import_flag fdi_10_flag {
    quietly count if fz_`g' == 1 & !missing(wm_`g') & year == `post_yr' & !missing(`g')
    local kn = r(N)
    quietly count if fz_`g' == 1 & !missing(wm_`g') & year == `post_yr' & `g' == 1
    local sn = r(N)
    post `hs' ("`g'") (`sn') (`kn') (100 * `sn' / `kn')
}
postclose `hs'
* (a) the balance table
use `balance', clear
gen str30 grp1_label = cond(grouping == "export_flag", "Exporters", cond(grouping == "import_flag", "Importers", "Foreign-owned (10%+)"))
gen str80 weights_label = ""
replace weights_label = "Main: other firms match the group's 2013-14 averages"                 if weights == "m"
replace weights_label = "Check: averages and spreads of the five size and energy measures"     if weights == "sd"
replace weights_label = "Stricter group (flagged in every known 2013-14 year), main weights"   if weights == "st"
replace weights_label = "Main weights, checked only among firms also recorded in `post_yr' (not a target)" if weights == "m18"
replace weights_label = "Check: main measures, balanced only among firms also recorded in `post_yr'" if weights == "s18"
gen str60 measure_label = ""
replace measure_label = "Workers (log)"                                   if measure == "m1"
replace measure_label = "Value added (log, current prices)"               if measure == "m2"
replace measure_label = "Energy (GJ) per unit of value added (log)"       if measure == "m3"
replace measure_label = "CO2 (tonnes) per unit of value added (log)"      if measure == "m4"
replace measure_label = "Bought electricity, % of energy used"            if measure == "m5"
replace measure_label = "Makes own electricity (% of firms)"              if measure == "m6"
replace measure_label = "Own electricity not recorded (% of firms)"       if measure == "m7"
replace measure_label = "Industry " + substr(measure, 5, .) + " (% of firms)" if substr(measure, 1, 4) == "ind_"
replace measure_label = "Island: Sumatra (% of firms)"                    if measure == "isl_1"
replace measure_label = "Island: Java (% of firms)"                       if measure == "isl_2"
replace measure_label = "Island: other islands (% of firms)"              if measure == "isl_3"
* one summary row each for industry and island: the largest gap among their categories
preserve
gen str14 cat = cond(substr(measure, 1, 4) == "ind_", "industry_max", cond(substr(measure, 1, 4) == "isl_", "island_max", ""))
keep if cat != ""
gen double abs_b = abs(std_before)
gen double abs_a = abs(std_after)
collapse (max) std_before = abs_b std_after = abs_a (first) grp1_label weights_label firms_g1 firms_g0 drop_g1 ///
    drop_g0 drop_nomeas iter worth_g0 wmax_ratio gap_max balanced, by(grouping weights cat)
rename cat measure
gen str60 measure_label = cond(measure == "industry_max", "Industry: largest gap among 2-digit codes (absolute)", ///
    "Island: largest gap among Sumatra, Java, other (absolute)")
tempfile maxrows
save `maxrows'
restore
append using `maxrows'
assert abs(std_after) < 1e-5 if balanced == 1 & !missing(std_after)
gen byte gi = cond(grouping == "export_flag", 1, cond(grouping == "import_flag", 2, 3))
gen byte wo = 1*(weights == "m") + 2*(weights == "m18") + 3*(weights == "sd") + 4*(weights == "st") + 5*(weights == "s18")
gen int mo = cond(substr(measure, 1, 1) == "m" & length(measure) == 2, real(substr(measure, 2, 1)), ///
    cond(substr(measure, 1, 4) == "ind_", 100 + real(substr(measure, 5, .)), ///
    cond(substr(measure, 1, 4) == "isl_", 200 + real(substr(measure, 5, .)), cond(measure == "industry_max", 199, 299))))
sort gi wo mo
gen str120 note = ""
replace note = "Gaps in spreads: (group average - other firms' average) / sqrt((group variance + other variance) / 2), both variances unweighted" if _n == 1
replace note = "worth_g0 = (sum of weights)^2 / (sum of squared weights): as many equally weighted other firms" if _n == 2
replace note = "Balance NOT reached: reweighted rows left empty" if !balanced
replace note = "Main weights, checked only among the firms also recorded in `post_yr', which carry the drawn comparison: not a target, gaps remain" if weights == "m18"
format mean_g mean_o mean_ow sd_pool %10.4f
format std_before std_after vratio_before vratio_after %8.3f
format worth_g0 wmax_ratio %8.1f
format gap_max %9.2e
order grouping grp1_label weights weights_label measure measure_label mean_g mean_o mean_ow sd_pool std_before ///
      std_after vratio_before vratio_after firms_g1 firms_g0 worth_g0 wmax_ratio drop_g1 drop_g0 drop_nomeas ///
      iter gap_max balanced note
export delimited grouping-note using "tables/10_reweighted_frozen_groups_balance.csv", datafmt replace
list grp1_label weights measure mean_g mean_o mean_ow std_before std_after if inlist(weights, "m", "m18") & (mo < 10 | mo == 199 | mo == 299), ///
    noobs sepby(grouping) abbreviate(24)
tempfile baltab
save `baltab'
* one row per grouping and weights: counts, worth and balance status (for the regression table)
drop if weights == "m18"                 // a check of the main weights, not a weight set
bysort grouping weights: keep if _n == 1
keep grouping weights firms_g1 firms_g0 worth_g0 balanced
tempfile balsum
save `balsum'

* (b) the regression table
use `res', clear
* scope-2 CO2 = bought electricity x one national factor a year, so its rows repeat the scope-2
* energy rows exactly (year averages in every version): check it, then say so in the notes
preserve
keep if inlist(outcome_id, 2, 5, 8, 11) & !missing(b)
gen byte pair = cond(inlist(outcome_id, 2, 5), 1, 2)
sort grouping version term pair outcome_id
by grouping version term pair: assert _N == 2
by grouping version term pair: assert reldif(b[1], b[2]) < 1e-6
restore
* support rule: every year of the period and of the comparison years needs min_n firms of each kind,
* and the weighted other firms must be worth min_worth firms in each of those years
gen byte shown = n_g1_min >= `min_n' & n_g0_min >= `min_n' & ref_g1_min >= `min_n' & ref_g0_min >= `min_n' ///
    & worth_g0_min >= `min_worth' & ref_worth_g0_min >= `min_worth' & !missing(b, se, worth_g0_min, ref_worth_g0_min)
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
* labels (as R1-09)
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
gen str100 version_label = ""
replace version_label = "Not reweighted: R1-09's main model on the firms that can be reweighted"      if version == "unw"
replace version_label = "Reweighted (main): other firms match the group's 2013-14 averages"           if version == "eb"
replace version_label = "Reweighted to match the averages and spreads of the five measures"           if version == "eb_sd"
replace version_label = "Reweighted, firm + year averages only (weights already match industry, island)" if version == "eb_fe1"
replace version_label = "Stricter group (flagged in every known 2013-14 year), not reweighted"        if version == "unw_st"
replace version_label = "Stricter group, reweighted"                                                  if version == "eb_st"
replace version_label = "Reweighted only among firms also recorded in `post_yr' (they carry the drawn comparison)" if version == "eb_s18"
replace version_label = "Reweighted, one marker per year against 2013-14 (event-study version)"       if version == "eb_yearly"
gen str60 period = ""
replace period = "before Paris: " + "`pre_yrs'" if term == "pre"
replace period = "transition year: `trans_yr'" if term == "trans"
replace period = "records jump: `jump_yrs'" if term == "jump"
replace period = "after Paris: `post_yr'" if term == "post"
replace period = "records in doubt: `doubt_yrs'" if term == "doubt"
replace period = "year " + substr(term, 2, .) if substr(term, 1, 1) == "e"
* own-electricity rows: the comparison years without the years left out for them
local keep_base ""
foreach y of local base_yrs {
    local isin : list y in og_skip
    if !`isin' local keep_base "`keep_base' `y'"
}
gen str30 compared_with = cond(inlist(outcome_id, 17, 18), strtrim("`keep_base'"), "`base_yrs'")
gen byte in_figure = ((version == "eb" & inlist(term, "pre", "post")) | (version == "unw" & term == "post")) ///
    & inlist(outcome_id, 3, 6, 9, 12, 16, 17, 18, 19, 20)
* firm counts and worth of each balancing sample
gen str3 weights = cond(inlist(version, "unw_st", "eb_st"), "st", cond(version == "eb_sd", "sd", cond(version == "eb_s18", "s18", "m")))
merge m:1 grouping weights using `balsum', nogenerate assert(match)
merge m:1 grouping using `still', nogenerate assert(match)
replace worth_g0 = firms_g0 if inlist(version, "unw", "unw_st")    // not reweighted: every firm counts 1
gen str120 note = ""
replace note = "Same for every firm in a year (electricity GJ / grid factor): no firm or group difference can exist; not estimated" if outcome_id == 14
replace note = "Repeats the scope-2 energy row (bought electricity x one national factor a year)" if inlist(outcome_id, 5, 11)
replace note = "Period not estimable: own electricity not used in year(s) `og_skip'" if missing(b) & inlist(outcome_id, 17, 18)
replace note = "Fewer than `min_n' firms of a kind (or weighted other firms worth under `min_worth') in a year of this period or of the comparison years: left empty" ///
    if !shown & !missing(b)
replace note = "Balance not reached for these weights: left empty" if !balanced
gen byte gi = cond(grouping == "export_flag", 1, cond(grouping == "import_flag", 2, 3))
gen byte vorder = 1*(version == "unw") + 2*(version == "eb") + 3*(version == "eb_sd") + 4*(version == "eb_fe1") ///
    + 5*(version == "unw_st") + 6*(version == "eb_st") + 7*(version == "eb_s18") + 8*(version == "eb_yearly")
gen int torder = cond(term == "pre", 1, cond(term == "trans", 2, cond(term == "jump", 3, cond(term == "post", 4, ///
    cond(term == "doubt", 5, real(substr(term, 2, .)))))))
* empty 2016 row in the yearly version (no annual file)
preserve
keep if version == "eb_yearly" & term == "e`trans_yr'"
replace term = "e2016"
replace torder = 2016
foreach v in b se lo hi p diff diff_lo diff_hi mirror_diff mirror_diff_lo mirror_diff_hi clear n_g1_min n_g0_min worth_g0_min {
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
assert diff == 0 if outcome_id == 14 & !missing(diff)
assert n_g1_min <= firms_g1 if !missing(n_g1_min)
assert worth_g0_min <= n_g0_min + 1e-6 if !missing(worth_g0_min)
sort gi vorder outcome_id torder
order grouping grp1_label grp0_label version version_label outcome_id section row_label deasy_item term period ///
      compared_with in_figure shown b se df_r p lo hi diff diff_lo diff_hi diff_unit clear ///
      mirror_diff mirror_diff_lo mirror_diff_hi rows firms singletons n_g1_min n_g0_min worth_g0_min ///
      ref_g1_min ref_g0_min ref_worth_g0_min firms_g1 firms_g0 worth_g0 still_n still_known still_pct note
format b se lo hi %9.4f
format p %6.4f
format diff diff_lo diff_hi mirror_* %8.2f
format worth_g0_min ref_worth_g0_min worth_g0 %8.1f
format still_pct %8.2f
format df_r rows firms singletons n_g* ref_g* firms_* still_n still_known %9.0f
export delimited grouping-note using "tables/10_reweighted_frozen_groups.csv", datafmt replace
list grouping outcome_id version term diff diff_lo diff_hi clear n_g1_min worth_g0_min if in_figure, ///
    noobs sepby(grouping) abbreviate(24)
list grouping outcome_id version diff diff_lo diff_hi clear if inlist(version, "eb_sd", "eb_fe1", "unw_st", "eb_st", "eb_s18") ///
    & term == "post" & inlist(outcome_id, 3, 6, 9, 12, 19), noobs sepby(grouping) abbreviate(24)
tempfile regtab
save `regtab'

display "Step 8/9: numbers for the notes, read from the tables (never typed)"
local base_n : word count `base_yrs'
local b1 : word 1 of `base_yrs'
local bl : word `base_n' of `base_yrs'
local base_txt = cond(`base_n' == 1, "`b1'", "`b1'–" + substr("`bl'", 3, 2))
local pre_n : word count `pre_yrs'
local q1 : word 1 of `pre_yrs'
local ql : word `pre_n' of `pre_yrs'
local pre_txt = cond(`pre_n' == 1, "`q1'", "`q1'–" + substr("`ql'", 3, 2))
* rows 5 and 11 repeat rows 2 and 8 exactly, and row 14 cannot differ: they are not counted
gen byte cnt = !inlist(outcome_id, 5, 11, 14)
foreach v in unw eb eb_st eb_s18 {
    quietly count if version == "`v'" & term == "post" & shown & cnt & !missing(clear)
    local nall_`v' = r(N)
    quietly count if version == "`v'" & term == "post" & clear == 1 & cnt
    local nclr_`v' = r(N)
    quietly count if version == "`v'" & term == "pre" & clear == 1 & cnt
    local npre_`v' = r(N)
}
local still ""
foreach g in export_flag import_flag fdi_10_flag {
    quietly summarize still_pct if grouping == "`g'"
    local still "`still' `=string(r(mean), "%9.0f")'%,"
}
local still = strtrim(substr("`still'", 1, length("`still'") - 1))
local still = subinstr("`still'", ",", " and", 2)
local still = subinstr("`still'", " and", ",", 1)
display "   still so recorded in `post_yr': `still'"
display "   clear after (of `nall_eb'): not reweighted `nclr_unw', reweighted `nclr_eb', stricter reweighted `nclr_eb_st' (of `nall_eb_st')"
display "   clear before Paris: not reweighted `npre_unw', reweighted `npre_eb'"
display "   reweighted only among firms also recorded in `post_yr': clear after `nclr_eb_s18' of `nall_eb_s18'"

display "Step 9/9: figure: top = 2013-14 gaps before/after weighting; bottom = the main rows, with and without weights"
* --- top section: balance rows (main weights) ---
use `baltab', clear
keep if inlist(weights, "m", "m18") & inlist(measure, "m1", "m2", "m3", "m4", "m5", "m6", "industry_max", "island_max")
* the gap left after weighting among the firms also recorded in the drawn later year (hollow diamond)
gen double s18 = std_after if weights == "m18"
bysort grouping measure: egen double std_after18 = max(s18)
keep if weights == "m"
gen double xd_bal = 100 * std_after18
gen byte panel = gi
gen byte r = cond(measure == "industry_max", 7, cond(measure == "island_max", 8, real(substr(measure, 2, 1))))
* gaps are drawn x 100 so the gridlines at -100, 0, 100 read as -1, 0, +1 spreads (own tick labels)
gen double xo_bal = 100 * std_before
gen double xa_bal = 100 * std_after
gen str40 rlab = ""
replace rlab = "Workers"                         if r == 1
replace rlab = "Value added"                     if r == 2
replace rlab = "Energy (GJ) per unit of VA"      if r == 3
replace rlab = "CO2 (tonnes) per unit of VA"     if r == 4
replace rlab = "Bought electricity, % of energy" if r == 5
replace rlab = "Makes own electricity"           if r == 6
replace rlab = "Industry (largest gap)"          if r == 7
replace rlab = "Island (largest gap)"            if r == 8
gen double y = r
keep panel r y rlab xo_bal xa_bal xd_bal firms_g1 firms_g0 worth_g0
tempfile top
save `top'
* --- bottom section: result rows ---
use `regtab', clear
keep if in_figure
gen byte panel = gi
gen byte r = 0
local rpos "3 6 9 12 16 17 18 19 20"
forvalues i = 1/9 {
    local k : word `i' of `rpos'
    replace r = `i' if outcome_id == `k'
}
gen str40 rlab = ""
replace rlab = "Energy (GJ) per unit of VA"   if outcome_id == 3
replace rlab = "CO2 (tonnes) per unit of VA"  if outcome_id == 6
replace rlab = "Energy used (GJ)"             if outcome_id == 9
replace rlab = "CO2 emitted (tonnes)"         if outcome_id == 12
replace rlab = "Bought, % of energy used"     if outcome_id == 16
replace rlab = "Firms making their own, %"    if outcome_id == 17
replace rlab = "Own, % of electricity used"   if outcome_id == 18
replace rlab = "Value added (current prices)" if outcome_id == 19
replace rlab = "Workers"                      if outcome_id == 20
keep panel r rlab version term diff diff_lo diff_hi clear
tempfile bot
save `bot'
* --- y positions (top to bottom; the y axis is reversed) ---
* top: heading 0, rows 1-8, tick labels 8.9, counts 10-12; bottom: each heading one unit above its
* first row, rows `gap' apart (room for three markers), the next heading `hgap' below a section's last row
local gap  = 1.35
local hgap = 1.35
local y0b = 13.6                                           // heading: energy and CO2 per unit of VA
local yb1 = `y0b' + 1
local yh2 = `yb1' + `gap' + `hgap'                         // heading: energy used and CO2 emitted
local yb3 = `yh2' + 1
local yh3 = `yb3' + `gap' + `hgap'                         // heading: electricity
local yb5 = `yh3' + 1
local yh4 = `yb5' + 2 * `gap' + `hgap'                     // heading: for comparison
local yb8 = `yh4' + 1
local ymax = `yb8' + `gap' + 0.6
use `bot', clear
gen double yrow = cond(r <= 2, `yb1' + (r - 1) * `gap', cond(r <= 4, `yb3' + (r - 3) * `gap', ///
    cond(r <= 7, `yb5' + (r - 5) * `gap', `yb8' + (r - 8) * `gap')))
* three markers per row, apart so they do not overlap: without weights above, reweighted in the
* middle, the before-Paris check below
gen double y = yrow + cond(version == "unw", -0.34, cond(term == "pre", 0.34, 0))
append using `top'
replace yrow = y if missing(yrow)
* the y-axis labels: headings (bold) and rows, read from the data
local ylab `"0 "{bf:Gap in `base_txt', before Paris}" `y0b' "{bf:Energy and CO2 per unit of VA}" `yh2' "{bf:Energy used and CO2 emitted}" `yh3' "{bf:Electricity (difference in points)}" `yh4' "{bf:For comparison}""'
sort panel yrow version term
forvalues i = 1/`=_N' {
    if panel[`i'] == 1 & (missing(version[`i']) | (version[`i'] == "eb" & term[`i'] == "post")) {
        local yy = yrow[`i']
        local ll = rlab[`i']
        local ylab `"`ylab' `yy' "`ll'""'
    }
}
local ylab `"`ylab' 8.9 "Gap, in spreads between firms" 10 "Firms in the group" 11 "Other firms" 12 "Other firms, worth after weighting""'
* marker sets (same meaning in both sections: hollow = other firms as they are, black = reweighted)
gen double xa = diff    if version == "eb"  & term == "post"
gen double xb = diff    if version == "eb"  & term == "pre"
gen double xc = diff    if version == "unw" & term == "post"
gen double la = diff_lo if version == "eb"  & term == "post"
gen double ha = diff_hi if version == "eb"  & term == "post"
gen double lb = diff_lo if version == "eb"  & term == "pre"
gen double hb = diff_hi if version == "eb"  & term == "pre"
replace xa = xa_bal if !missing(xa_bal)
replace xc = xo_bal if !missing(xo_bal)
gen double xd = xd_bal                             // hollow diamond, just below its row
gen double yd = y + 0.3 if !missing(xd)
* shared x scale: a round range (steps of 50) around every marker and interval
egen double xl = rowmin(xa xb xc xd la lb)
egen double xh = rowmax(xa xb xc xd ha hb)
quietly summarize xl
local xlo = 50 * floor(min(r(min), -100) / 50)
quietly summarize xh
local xhi = 50 * ceil(max(r(max), 100) / 50)
display "   x range `xlo' to `xhi'"
* the number column at the right: the reweighted 2018 difference (whole % or points; gray when its 95%
* interval includes 0); in the top section, the firm counts
local labx = `xhi' + 0.3 * (`xhi' - `xlo')
gen str12 lab = cond(round(xa) == 0, "0", cond(xa > 0, "+", "") + string(round(xa), "%9.0f")) ///
    if version == "eb" & term == "post" & !missing(xa)
gen double labx = `labx' if !missing(lab)
gen double laby = y if !missing(lab)
* extra rows: count labels, the top section's own tick labels, the dashed 0 line, column heading
local n0 = _N
set obs `=_N + 27'
gen double refx = .
gen double refy = .
gen double hx = .
gen double hy = .
gen str16 htxt = ""
gen byte hgray = 0
forvalues p = 1/3 {
    local base = `n0' + 9 * (`p' - 1)
    * the dashed 0 line: one piece per section (drawn as two series, so it skips the count rows)
    replace panel = `p' in `=`base' + 1'/`=`base' + 9'
    replace refx = 0 in `=`base' + 1'
    replace refy = 0.5 in `=`base' + 1'
    replace refx = 0 in `=`base' + 2'
    replace refy = 8.5 in `=`base' + 2'
    replace refx = 0 in `=`base' + 4'
    replace refy = `y0b' + 0.5 in `=`base' + 4'
    replace refx = 0 in `=`base' + 5'
    replace refy = `ymax' in `=`base' + 5'
    * counts: group firms, other firms, what the weighted other firms are worth (from the table)
    summarize firms_g1 if panel == `p' & !missing(firms_g1), meanonly
    local c1 = r(mean)
    summarize firms_g0 if panel == `p' & !missing(firms_g0), meanonly
    local c0 = r(mean)
    summarize worth_g0 if panel == `p' & !missing(worth_g0), meanonly
    local cw = r(mean)
    replace hx = `labx' in `=`base' + 6'
    replace hy = 10 in `=`base' + 6'
    replace htxt = string(`c1', "%9.0fc") in `=`base' + 6'
    replace hx = `labx' in `=`base' + 7'
    replace hy = 11 in `=`base' + 7'
    replace htxt = string(`c0', "%9.0fc") in `=`base' + 7'
    replace hx = `labx' in `=`base' + 8'
    replace hy = 12 in `=`base' + 8'
    replace htxt = string(`cw', "%9.0fc") in `=`base' + 8'
    replace hx = `labx' in `=`base' + 9'
    replace hy = `y0b' in `=`base' + 9'
    replace htxt = "`post_yr'" in `=`base' + 9'
    * the top section's tick labels (-1, 0, +1 spreads at the gridlines -100, 0, 100)
    replace hx = -100 in `=`base' + 3'
    replace hy = 8.9 in `=`base' + 3'
    replace htxt = "-1" in `=`base' + 3'
    replace hgray = 1 in `=`base' + 3'
}
* two more tick labels per panel (0 and +1)
local n1 = _N
set obs `=_N + 6'
forvalues p = 1/3 {
    replace panel = `p' in `=`n1' + 2*`p' - 1'
    replace panel = `p' in `=`n1' + 2*`p''
    replace hx = 0   in `=`n1' + 2*`p' - 1'
    replace hx = 100 in `=`n1' + 2*`p''
    replace hy = 8.9 in `=`n1' + 2*`p' - 1'/`=`n1' + 2*`p''
    replace htxt = "0"  in `=`n1' + 2*`p' - 1'
    replace htxt = "+1" in `=`n1' + 2*`p''
    replace hgray = 1 in `=`n1' + 2*`p' - 1'/`=`n1' + 2*`p''
}
label define panel 1 "(a) Exporters" 2 "(b) Importers" 3 "(c) Foreign-owned (10%+)"
label values panel panel
sort panel refy y
* Notes: one text, wrapped here into lines of at most 100 characters (PDF text runs wider than the PNG)
local ntext "Notes: Groups as in Figure R1-09. Each other firm gets one weight so that, in `base_txt', the weighted other firms match the group in every top row (entropy balancing: weights as equal as possible). Top: averages, group minus other firms, in spreads between firms (standard deviations); worth = as many firms counted equally; ◇~=~●~for the firms also recorded in `post_yr', on which the bottom rows rest. Bottom: ●~=~the group's change from `base_txt' to `post_yr' minus that of the reweighted other firms in the same industry and province, each firm against its own average (line = 95% interval; gray number: it includes 0, no clear difference). ○~=~without weights (●~in~Figure~R1-09). △~=~●~for~`pre_txt': away from 0 = already moving apart before Paris (adopted December 2015). Energy per VA falls when VA grows: see the value added row. VA~=~value added = output value minus materials, energy and services bought, current prices. Firm links are fictional: in `post_yr' only `still' of each group's answering firms are still so recorded. Association, not the effect of Paris."
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
* "~" keeps a symbol with its words on one line; it prints as a space
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
        (line refy refx if refy < 10, lpattern(dash) lcolor(gs8) lwidth(thin)) ///
        (line refy refx if refy > 10, lpattern(dash) lcolor(gs8) lwidth(thin)) ///
        (scatter laby labx if clear == 1, msymbol(none) mlabel(lab) mlabpos(0) mlabsize(vsmall) mlabcolor(black)) ///
        (scatter laby labx if clear != 1, msymbol(none) mlabel(lab) mlabpos(0) mlabsize(vsmall) mlabcolor(gs9)) ///
        (scatter hy hx if !hgray, msymbol(none) mlabel(htxt) mlabpos(0) mlabsize(vsmall) mlabcolor(black)) ///
        (scatter hy hx if hgray, msymbol(none) mlabel(htxt) mlabpos(0) mlabsize(vsmall) mlabcolor(gs6)) ///
        (scatter yd xd, msymbol(Dh) mcolor(gs5) mlwidth(medthin) msize(`msz')), ///
        by(panel, rows(1) imargin(tiny) graphregion(color(white) lcolor(white) ilcolor(white) margin(r+3)) legend(pos(6)) ///
            title("Figure R1-10. Energy and CO2: groups fixed before Paris vs reweighted other firms", ///
                  size(small) pos(11) span) ///
            note(`notelines' "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6))) ///
        subtitle(, pos(11) nobox fcolor(white) lcolor(white) size(small)) ///
        yscale(reverse noline range(-0.3 `ymax')) ylabel(`ylab', angle(0) noticks tlength(0) nogrid labsize(vsmall)) ytitle("") ///
        xscale(range(`xlo' `=`labx' + 0.06 * (`xhi' - `xlo')') noline) ///
        xlabel(`xlo'(100)`xhi', format(%9.0f) noticks tlength(0) labsize(vsmall) grid glcolor(gs15) glwidth(vthin)) ///
        xmtick(`xlo'(50)`xhi', noticks tlength(0) grid glcolor(gs15) glwidth(vthin)) ///
        xtitle("Bottom rows: change from `base_txt' to `post_yr', group minus other firms, % (electricity: points)", size(vsmall)) ///
        legend(order(5 "Other firms reweighted to match the group in `base_txt'" 2 "95% interval, reweighted" ///
                     4 "Other firms as they are (Figure R1-09's ●)" 1 "95% interval, before-Paris check" ///
                     3 "Before Paris (check): `pre_txt' vs `base_txt', reweighted" 6 "0 = no difference" ///
                     12 "Top: same weights, only firms also recorded in `post_yr'") ///
            cols(2) region(lcolor(none)) size(vsmall) symxsize(8) keygap(1) colgap(6) rowgap(0.5)) ///
        plotregion(style(none)) xsize(8) ysize(11)
    if "`out'" == "png" graph export "figures/10_reweighted_frozen_groups.png", width(2400) replace
    else graph export "figures/10_reweighted_frozen_groups.pdf", replace
}
timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/10_reweighted_frozen_groups.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
