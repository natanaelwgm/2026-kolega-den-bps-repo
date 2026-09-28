/*==========================================================================
  R4-05  Judged only by what was known about them by 2019, which firms
         ended up leaving the files, coming back, shrinking, staying about
         the same or growing by 2022? And how does that compare with normal
         years (the 2012 firms, followed 2013-2015)?
  Answers Bu Deasy R4: "Which firms survived and recovered?" - Strategy
         "Alternative: multinomial outcomes: exit, temporary disappearance,
         survive-shrink, survive-grow" (on "pre-COVID characteristics").
  Method : one multinomial logit per starting file (the five outcomes at
           once, one row per firm), on traits from the starting file and the
           two files before it only, with sector and province groups;
           standard errors clustered by firm. Dots = average marginal effects
           in percentage points (size band and export answer: each group
           against the reference group). A pooled model of both files (every
           term its own per file) gives the 2019-minus-2012 differences.
  Output : figures/05_outcomes_multinomial.png (+ .pdf)
           tables/05_outcomes_multinomial.csv (effects for workers - drawn -
             and output - table only -, raw coefficients, outcome counts,
             model checks, calibration by tenth of predicted chance)
           tables/05_outcomes_multinomial_table.pdf      (every plotted point)
           tables/05_outcomes_multinomial_regression.pdf (the regression table)
  Traits : the same eight as R4-04 (04_leaving_hazard.do), same code.
  Firm links are fictional in the development data, so who stays, leaves or
  comes back means nothing here; read these results on the real BPS files.
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
global OUTDIR "/Users/natanaelmassie/Downloads/2026-kolega-den-bps-repo/20260917-run/block-r4-covid-survival"
* ---------------------------------------------------------------------------
if `"`data_arg'"'   != "" global DATA   `"`data_arg'"'
if `"`outdir_arg'"' != "" global OUTDIR `"`outdir_arg'"'
cd "$OUTDIR"
foreach d in figures tables logs {
    capture mkdir "`d'"
}
cap log close
log using "logs/05_outcomes_multinomial.log", replace text
timer clear 1
timer on 1
display _newline "=== [R4-05] STARTING: left, back, shrank, same, grew - by traits known before COVID, 2019 vs 2012 firms ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."
local fname "05_outcomes_multinomial"
local exhibit "R4-05"

*---------------------------------------------------------------------------
display "Step 1/9: load firm, year, size, output, value added, trade, ownership, sector and province"
*---------------------------------------------------------------------------
* workers              = persons engaged (size bands; the main size change measure)
* gross_output_nominal = output value in current prices (the output version, table only)
* gross_output_real    = output in constant prices; empty in the development file,
*                        used automatically by the shared block when filled
* value_added_nominal  = value added in current prices (value added per worker)
* export_flag          = exports (0/1; often not answered: "not known" is its own group)
* import_flag          = imports (0/1)
* fdi_10_flag          = 10% or more foreign-owned (0/1; the R1-R3 rule)
* industry2_reported   = 2-digit sector; province_code = province (controls)
quietly describe using "$DATA", varlist
local allvars `r(varlist)'
local want firm_id year workers gross_output_nominal gross_output_real value_added_nominal ///
    export_flag import_flag fdi_10_flag industry2_reported province_code
local have : list want & allvars
use `have' using "$DATA", clear
isid firm_id year
assert !missing(firm_id, year)
tempfile panel
save `panel'

* The two starting files: the last file before COVID reached Indonesia (March 2020)
* and a normal-years file whose three later files end before COVID (row plan: 2012,
* followed 2013, 2014, 2015 - three consecutive years, before the missing 2016 file).
local cohort_covid  2019
local cohort_normal 2012
local cohorts `cohort_covid' `cohort_normal'
local covid_first 2020          // first annual file after COVID reached Indonesia
local band_pct 10               // stayers: "about the same" = within 10% either way (shared block)
local min_firms 30              // an outcome, a trait group or a control group needs this many firms

*---------------------------------------------------------------------------
display "Step 2/9: for each starting file: the shared cohort block, then the traits (one row per firm)"
*---------------------------------------------------------------------------
tempfile stack
local first 1
foreach cohort_year of local cohorts {
    use `panel', clear
*===========================================================================
* COVID COHORT AND STATES (copy exactly into later R4 and R10 files)
*   Version 2 - written and reviewed in R4-01 (28 Sep 2026). Do not edit a copy;
*   change R4-01 and re-copy. Set -local cohort_year- before the block; R4-02
*   runs it once per starting file (2012 ... 2019).
*   In : firm-year rows in memory (one row per firm and year): firm_id year
*        workers gross_output_nominal (gross_output_real is used instead when
*        present and filled for 95%+ of the cohort-file and last-file rows).
*        The block collapses to one row per firm: every other variable in memory
*        is dropped. Build traits in a tempfile first and merge them back by
*        firm_id after the block.
*   Out: one row per firm in the cohort file or in one of the next three files.
*        in_cohort = 1 for the firms of the cohort file (the cohort); the others
*        are newcomers (new_in_file = the later file they first appear in).
*        Locals: f1 f2 f3 = the next three files, p1 p2 = the two files before,
*        outbasis = output variable used, band_pct = neutral band in percent
*        (10 = within 10% either way), band_lo band_hi = its limits as ratios.
*   The years come from the data, so the block runs unchanged on the real files.
*===========================================================================
isid firm_id year
* -- the annual files in the data, and the files around the cohort file --
quietly levelsof year, local(c_files)
local c_pos : list posof "`cohort_year'" in c_files
local c_nf : word count `c_files'
if `c_pos' == 0 | `c_pos' + 3 > `c_nf' {
    display as error "cohort file `cohort_year' must be a file year with three later files"
    exit 198
}
local f1 : word `=`c_pos' + 1' of `c_files'
local f2 : word `=`c_pos' + 2' of `c_files'
local f3 : word `=`c_pos' + 3' of `c_files'
local p1 ""
local p2 ""
if `c_pos' > 1 local p1 : word `=`c_pos' - 1' of `c_files'
if `c_pos' > 2 local p2 : word `=`c_pos' - 2' of `c_files'
* -- output: constant prices when the file has them, else current prices --
local outbasis "gross_output_nominal"
capture confirm numeric variable gross_output_real
if !_rc {
    quietly count if inlist(year, `cohort_year', `f3')
    local c_nrows = r(N)
    quietly count if inlist(year, `cohort_year', `f3') & !missing(gross_output_real)
    if r(N) >= 0.95 * `c_nrows' & `c_nrows' > 0 local outbasis "gross_output_real"
}
* -- neutral band: a stayer is "about the same" if its last-file level is
*    within band_pct percent of its cohort-file level, up or down (10: 0.90 to 1.10 times);
*    the limits match the words on the chart ("down more than 10%") exactly --
if "`band_pct'" == "" local band_pct 10
local band_lo = 1 - `band_pct'/100
local band_hi = 1 + `band_pct'/100
* -- which files each firm is in (1 = in the file, 0 = not) --
gen byte c_base    = (year == `cohort_year')
gen byte c_f1      = (year == `f1')
gen byte c_f2      = (year == `f2')
gen byte c_f3      = (year == `f3')
gen byte c_earlier = (year <  `cohort_year')                    // any file before the cohort file
gen byte c_p1      = cond("`p1'" == "", ., (year == real("`p1'")))
gen byte c_p2      = cond("`p2'" == "", ., (year == real("`p2'")))
gen double c_wk0   = workers     if year == `cohort_year'
gen double c_wk3   = workers     if year == `f3'
gen double c_out0  = `outbasis'  if year == `cohort_year'
gen double c_out3  = `outbasis'  if year == `f3'
keep if year <= `f3'
collapse (max) seen_base = c_base seen_f1 = c_f1 seen_f2 = c_f2 seen_f3 = c_f3 ///
    seen_earlier = c_earlier seen_p1 = c_p1 seen_p2 = c_p2 ///
    workers_base = c_wk0 workers_f3 = c_wk3 output_base = c_out0 output_f3 = c_out3, by(firm_id)
keep if seen_base | seen_f1 | seen_f2 | seen_f3                  // firms of the cohort file or a later one
gen int  cohort_year = `cohort_year'
gen byte in_cohort   = (seen_base == 1)
* -- new_to_file = 1: in the cohort file but in neither of the two files before
*    (it may still be in an older file); 0 = "incumbent" (R10 uses 0 as incumbent) --
gen byte new_to_file = .
if "`p1'" != "" replace new_to_file = (seen_p1 == 0 & (seen_p2 == 0 | missing(seen_p2))) if in_cohort
* -- presence in the next three files, e.g. "110" = in f1 and f2, not in f3 --
gen str3 pattern = string(seen_f1) + string(seen_f2) + string(seen_f3) if in_cohort
* -- state by the last file (f3) --
*    1 stayed           = in all three later files
*    2 absent then back = missed f1 and/or f2, in f3 again ("temporary disappearance")
*    3 left the files   = not in f3 (the file has no closure record: not proof of closure)
gen byte state_file = cond(pattern == "111", 1, cond(seen_f3 == 1, 2, 3)) if in_cohort
*    left_when: 1 = gone from f1 on ("000"), 2 = in f1 or f2, gone by f3
gen byte left_when = cond(pattern == "000", 1, 2) if state_file == 3
* -- stayers: change from the cohort file to f3; 0 in f3 counts as shrank;
*    no positive cohort-file level (or no f3 level) = not classified (missing) --
gen double ratio_wk  = workers_f3 / workers_base if state_file == 1 & workers_base > 0 & !missing(workers_base, workers_f3)
gen double ratio_out = output_f3  / output_base  if state_file == 1 & output_base  > 0 & !missing(output_base,  output_f3)
foreach m in wk out {
    gen byte size_`m' = cond(ratio_`m' < `band_lo', 1, cond(ratio_`m' > `band_hi', 3, 2)) if !missing(ratio_`m')
    *   outcome5: 1 left the files, 2 absent then back, 3 shrank, 4 about the same, 5 grew
    gen byte outcome5_`m' = cond(state_file == 3, 1, cond(state_file == 2, 2, 2 + size_`m')) if in_cohort
    replace  outcome5_`m' = . if state_file == 1 & missing(size_`m')
}
* -- newcomers: the later file a firm not in the cohort file first appears in --
gen int new_in_file = cond(seen_f1, `f1', cond(seen_f2, `f2', `f3')) if !in_cohort
gen str80 outcome_basis = "`outbasis'"
label define c_state 1 "stayed" 2 "absent then back" 3 "left the files", replace
label define c_left  1 "gone from the first later file" 2 "gone later", replace
label define c_size  1 "shrank" 2 "about the same" 3 "grew", replace
label define c_out5  1 "left the files" 2 "absent then back" 3 "stayed, shrank" 4 "stayed, about the same" 5 "stayed, grew", replace
label values state_file c_state
label values left_when c_left
label values size_wk size_out c_size
label values outcome5_wk outcome5_out c_out5
* -- structural checks (hold on any data) --
isid firm_id
assert !missing(state_file, pattern) if in_cohort
assert missing(state_file) & !missing(new_in_file) if !in_cohort
assert (state_file == 1) == (pattern == "111") if in_cohort
assert !missing(outcome5_wk) if in_cohort & state_file != 1
order firm_id cohort_year in_cohort new_to_file seen_* pattern state_file left_when ///
    workers_base workers_f3 ratio_wk size_wk outcome5_wk output_base output_f3 ratio_out size_out ///
    outcome5_out new_in_file outcome_basis
display "   cohort file `cohort_year'; later files `f1' `f2' `f3'; earlier files `p2' `p1'; output: `outbasis'; band +/-`band_pct'%"
*===========================================================================
* END OF COVID COHORT AND STATES
*===========================================================================
    * -- keep the firms of the starting file, their outcome by the third later file,
    *    and the stayers' size change (workers; output for the table-only version) --
    keep if in_cohort
    keep firm_id cohort_year new_to_file pattern state_file left_when size_wk size_out ///
        outcome5_wk outcome5_out outcome_basis
    tempfile st
    save `st'
    local f1_`cohort_year' `f1'
    local f2_`cohort_year' `f2'
    local f3_`cohort_year' `f3'
    local p1_`cohort_year' `p1'
    local p2_`cohort_year' `p2'
    local outbasis_`cohort_year' `outbasis'
    * the normal-years file must be followed only through files before COVID
    if `cohort_year' != `cohort_covid' assert `f3' < `covid_first'

    * -- traits: from the starting file and the two files before it only (never a later file) --
    use `panel', clear
    gen byte t_in = (year == `cohort_year')
    foreach y in `p1' `p2' {
        replace t_in = 1 if year == `y'
    }
    keep if t_in
    * exporter: yes if any known answer in these files is yes, no if every known answer
    * is no, "not known" if no answer at all (kept as its own group, never counted as no)
    bysort firm_id: egen double t_exp = max(export_flag)
    keep if year == `cohort_year'
    gen byte expst = cond(missing(t_exp), 2, t_exp)
    * size band in the starting file: 1 = fewer than 20 workers, 2 = 20-99, 3 = 100 or more
    gen byte sizeb = cond(workers < 20, 1, cond(workers < 100, 2, 3)) if !missing(workers)
    * value added per worker above the median of its sector in the starting file
    * (compares within a sector and within a year, so prices and masking drop out)
    gen double lvapw = ln(value_added_nominal / workers) if workers > 0 & value_added_nominal > 0
    bysort industry2_reported: egen double med_lvapw = pctile(lvapw), p(50)
    gen byte hiprod = (lvapw > med_lvapw) if !missing(lvapw, med_lvapw)
    gen double lvr = lvapw - med_lvapw               // continuous version, for a table-only check
    rename (import_flag fdi_10_flag industry2_reported province_code) (imp fdi sector prov)
    keep firm_id sizeb expst hiprod imp fdi sector prov lvr
    merge 1:1 firm_id using `st', assert(match) nogen

    * -- control groups: sectors and provinces with fewer than min_firms firms of this
    *    starting file are pooled into one "other" group (per starting file) --
    foreach v in sector prov {
        bysort `v': gen long n_`v' = _N
        replace `v' = "other" if n_`v' < `min_firms'
        drop n_`v'
    }
    gen int coh = `cohort_year'
    if `first' {
        save `stack'
        local first 0
    }
    else {
        append using `stack'
        save `stack', replace
    }
}

*---------------------------------------------------------------------------
display "Step 3/9: trait markers; which outcomes and traits have enough firms to estimate"
*---------------------------------------------------------------------------
use `stack', clear
* 0/1 marker per trait (reference groups: 20-99 workers; known non-exporters) - as R4-04
gen byte d1 = (sizeb == 1) if !missing(sizeb)   // fewer than 20 workers
gen byte d2 = (sizeb == 3) if !missing(sizeb)   // 100 or more workers
gen byte d3 = hiprod                            // value added per worker above its sector's median
gen byte d4 = (expst == 1)                      // exporter
gen byte d5 = (expst == 2)                      // export answer not known
gen byte d6 = imp                               // importer
gen byte d7 = fdi                               // 10% or more foreign-owned
gen byte d8 = new_to_file                       // in neither of the two files before
local nterm 8
* Size band and export answer have three groups each, so their two markers are one trait:
* an effect compares a group with the reference group (20-99 workers; known non-exporters),
* the other marker of the pair switched off in both (a factor contrast; R4-04 does the same)
local pair1 2
local pair2 1
local pair4 5
local pair5 4
local t1 "Fewer than 20 workers"
local t2 "100 or more workers"
local t3 "Value added per worker above its sector's median"
local t4 "Exporter"
local t5 "Export answer not known"
local t6 "Importer"
local t7 "Foreign-owned (10% or more)"
local t8 "New to the files (not in the two files before)"
* the five outcomes (codes of the shared block's outcome5_wk / outcome5_out)
local o1 "Left the files"
local o2 "Absent, then back"
local o3 "Stayed, shrank"
local o4 "Stayed, same size"
local o5 "Stayed, grew"
local mw_wk  "workers"
local mw_out = cond("`outbasis_`cohort_covid''" == "gross_output_real", "output (constant prices)", "output (current prices)")
* a firm is usable when every trait is known (value added per worker needs workers > 0)
egen byte n_miss = rowmiss(d1-d8)
gen byte usable = (n_miss == 0)
label values outcome5_wk outcome5_out .       // numeric outcome codes = equation names 1 ... 5
* cohort-specific sector and province groups (each starting file its own dummies)
egen long csec  = group(coh sector)
egen long cprov = group(coh prov)
* importer share of each starting file's usable firms (for the notes: not like for like)
foreach c of local cohorts {
    quietly summarize d6 if coh == `c' & usable
    local impsh_`c' = strtrim(string(100 * r(mean), "%5.0f"))
}
foreach m in wk out {
    gen byte ms_`m' = 0                        // 1 = firm is in this measure's model
    foreach c of local cohorts {
        quietly count if coh == `c'
        scalar nf_`m'_`c' = r(N)                               // firms in the starting file
        quietly count if coh == `c' & usable
        scalar nfu_`m'_`c' = r(N)                              // every trait known
        quietly count if coh == `c' & usable & missing(outcome5_`m')
        scalar nnc_`m'_`c' = r(N)                              // stayers not comparable (no size change)
        * outcomes: modelled only with min_firms or more firms; the firms of a rarer
        * outcome are left out of the model (and counted)
        local outs_`m'_`c' ""
        scalar nrare_`m'_`c' = 0
        forvalues j = 1/5 {
            quietly count if coh == `c' & usable & outcome5_`m' == `j'
            scalar no_`m'_`c'_`j' = r(N)
            if r(N) >= `min_firms' local outs_`m'_`c' `outs_`m'_`c'' `j'
            else scalar nrare_`m'_`c' = nrare_`m'_`c' + r(N)
        }
        local nouts : word count `outs_`m'_`c''
        local model_`m'_`c' = (`nouts' >= 2)
        foreach j of local outs_`m'_`c' {
            replace ms_`m' = 1 if coh == `c' & usable & outcome5_`m' == `j'
        }
        quietly count if coh == `c' & ms_`m'
        scalar nfm_`m'_`c' = r(N)                              // firms in the model
        local base_`m'_`c' : word 1 of `outs_`m'_`c''          // base outcome (effects do not depend on it)
        * traits: estimated only with min_firms or more model firms with and without it
        local terms_`m'_`c' ""
        forvalues t = 1/`nterm' {
            quietly count if coh == `c' & ms_`m' & d`t' == 1
            scalar nw_`m'_`c'_`t' = r(N)
            quietly count if coh == `c' & ms_`m' & d`t' == 0
            scalar nwo_`m'_`c'_`t' = r(N)
            forvalues j = 1/5 {
                quietly count if coh == `c' & ms_`m' & d`t' == 1 & outcome5_`m' == `j'
                scalar nwj_`m'_`c'_`t'_`j' = r(N)              // firms with the trait in outcome j
            }
            if nw_`m'_`c'_`t' >= `min_firms' & nwo_`m'_`c'_`t' >= `min_firms' & `model_`m'_`c'' ///
                local terms_`m'_`c' `terms_`m'_`c'' `t'
        }
        display "   `mw_`m'', `c' firms: " nf_`m'_`c' " (traits known " nfu_`m'_`c' ", in the model " nfm_`m'_`c' ///
            "); outcomes modelled: `outs_`m'_`c''; traits: `terms_`m'_`c''"
        forvalues j = 1/5 {
            display "      outcome `j' (`o`j''): " no_`m'_`c'_`j' " firms"
        }
    }
}

*---------------------------------------------------------------------------
display "Step 4/9: one multinomial logit per starting file; effects in points; model checks"
*---------------------------------------------------------------------------
* Model, per firm i of starting file c:
*   Pr(firm i ends in outcome j by the third later file)
*     = exp(a_j + traits x b_j + sector_j + province_j) / sum over outcomes of the same
* Effects (the dots) = average marginal effects: for each firm, the chance of outcome j
* with the trait minus without it (everything else as observed), averaged over the
* firms of the starting file, in percentage points. For one trait the effects of all
* modelled outcomes add up to zero (checked).
foreach c of local cohorts {
    forvalues j = 1/5 {
        scalar cz_b_`c'_`j'  = .                  // continuous check, filled below
        scalar cz_se_`c'_`j' = .
    }
}
foreach m in wk out {
    foreach j in 1 2 3 4 5 {
        gen double pr_`m'_`j' = .               // predicted chance of each outcome
    }
    foreach c of local cohorts {
        scalar ok_`m'_`c' = 0
        scalar conv_`m'_`c' = .
        scalar r2p_`m'_`c' = .
        scalar nbig_`m'_`c' = .
        local xs ""
        foreach t of local terms_`m'_`c' {
            local xs `xs' d`t'
        }
        if !`model_`m'_`c'' | "`xs'" == "" continue
        capture noisily mlogit outcome5_`m' i.(`xs') i.csec i.cprov if coh == `c' & ms_`m', ///
            baseoutcome(`base_`m'_`c'') vce(cluster firm_id) iterate(100)
        if _rc {
            display as error "   `mw_`m'' `c': the model did not run: its dots are written as 'not estimated'"
            continue
        }
        scalar conv_`m'_`c' = e(converged)
        if e(converged) != 1 {
            display as error "   `mw_`m'' `c': the model did not converge: its dots are written as 'not estimated'"
            continue
        }
        scalar ok_`m'_`c' = 1
        scalar r2p_`m'_`c' = e(r2_p)                          // McFadden pseudo R-squared
        assert e(N) == nfm_`m'_`c'                            // every model firm used
        * near perfect prediction: coefficients above 10 in absolute value (log odds)
        matrix B = e(b)
        matrix V = e(V)
        scalar nbig_`m'_`c' = 0
        forvalues k = 1/`=colsof(B)' {
            if abs(B[1, `k']) > 10 & V[`k', `k'] > 0 scalar nbig_`m'_`c' = nbig_`m'_`c' + 1
        }
        * raw coefficients (log odds against the base outcome), CSV only
        foreach j of local outs_`m'_`c' {
            foreach t of local terms_`m'_`c' {
                scalar lb_`m'_`c'_`j'_`t'  = _b[`j':1.d`t']
                scalar lse_`m'_`c'_`j'_`t' = _se[`j':1.d`t']
            }
            tempvar p
            predict double `p' if e(sample), pr outcome(`j')
            replace pr_`m'_`j' = `p' if e(sample)
            drop `p'
        }
        estimates store sep_`m'_`c'
        * average marginal effects, outcome by outcome: for each trait, the average predicted
        * chance with the trait (at 1) minus without it (at 0), over the file's firms; for size
        * band and export answer the partner marker is 0 in both (group against reference group)
        local atl ""
        foreach t of local terms_`m'_`c' {
            local pt ""
            if "`pair`t''" != "" {
                local inp : list pair`t' in terms_`m'_`c'
                if `inp' local pt " d`pair`t''=0"
            }
            local atl `atl' at(d`t'=0`pt') at(d`t'=1`pt')
        }
        foreach j of local outs_`m'_`c' {
            estimates restore sep_`m'_`c'
            quietly margins, `atl' predict(outcome(`j')) post
            local k 0
            foreach t of local terms_`m'_`c' {
                local k = `k' + 2
                quietly lincom _b[`k'._at] - _b[`=`k' - 1'._at]
                scalar ame_`m'_`c'_`j'_`t' = r(estimate)
                scalar ase_`m'_`c'_`j'_`t' = r(se)
            }
        }
        * check: for each trait the effects over the modelled outcomes add up to zero
        foreach t of local terms_`m'_`c' {
            scalar s_ = 0
            foreach j of local outs_`m'_`c' {
                scalar s_ = s_ + ame_`m'_`c'_`j'_`t'
            }
            assert abs(s_) < 1e-8
        }
        * calibration: firms sorted into tenths of the predicted chance of outcome j;
        * predicted vs actual share per tenth; the largest gap; area under the ROC curve
        foreach j of local outs_`m'_`c' {
            tempvar y dec
            gen byte `y' = (outcome5_`m' == `j') if coh == `c' & ms_`m'
            quietly roctab `y' pr_`m'_`j' if coh == `c' & ms_`m'
            scalar auc_`m'_`c'_`j' = r(area)                  // 0.5 = no better than chance
            quietly xtile `dec' = pr_`m'_`j' if coh == `c' & ms_`m', nquantiles(10)
            scalar gap_`m'_`c'_`j' = 0
            quietly levelsof `dec', local(decs)
            local ndec_`m'_`c'_`j' : word count `decs'
            foreach d of local decs {
                quietly count if `dec' == `d'
                scalar cn_`m'_`c'_`j'_`d' = r(N)
                quietly summarize `y' if `dec' == `d'
                scalar ca_`m'_`c'_`j'_`d' = 100 * r(mean)
                quietly summarize pr_`m'_`j' if `dec' == `d'
                scalar cp_`m'_`c'_`j'_`d' = 100 * r(mean)
                scalar gap_`m'_`c'_`j' = max(gap_`m'_`c'_`j', abs(ca_`m'_`c'_`j'_`d' - cp_`m'_`c'_`j'_`d'))
            }
            drop `y' `dec'
        }
        display "   `mw_`m'' `c': firms " nfm_`m'_`c' ", pseudo R2 " %5.3f r2p_`m'_`c' ///
            ", coefficients above 10 (near perfect prediction) " nbig_`m'_`c'
        * table-only check (as R4-04; not drawn): value added per worker as a continuous
        * measure (log distance from its sector's median, per standard deviation across the
        * starting file's firms) in place of the yes/no marker; otherwise the same model
        if "`m'" == "wk" {
            local dd3 d3
            local xz : list xs - dd3
            capture drop zc
            quietly summarize lvr if coh == `c' & usable
            gen double zc = lvr / r(sd) if coh == `c'
            capture {
                quietly mlogit outcome5_`m' `=cond("`xz'" != "", "i.(`xz')", "")' c.zc i.csec i.cprov if coh == `c' & ms_`m', ///
                    baseoutcome(`base_`m'_`c'') vce(cluster firm_id) iterate(100)
                foreach j of local outs_`m'_`c' {
                    quietly margins, dydx(zc) predict(outcome(`j'))
                    matrix mz = r(b)
                    matrix vz = r(V)
                    scalar cz_b_`c'_`j'  = 100 * mz[1, 1]
                    scalar cz_se_`c'_`j' = 100 * sqrt(vz[1, 1])
                }
            }
            capture drop zc
            foreach j of local outs_`m'_`c' {
                display "   check `c', outcome `j': value added per worker, continuous (per SD): " %6.2f cz_b_`c'_`j' " points (SE " %5.2f cz_se_`c'_`j' ")"
            }
        }
    }
}

*---------------------------------------------------------------------------
display "Step 5/9: 2019 minus 2012 - one pooled model of both starting files"
*---------------------------------------------------------------------------
* Both starting files in one multinomial logit, every term (traits, sector and province
* groups, hence also the constants) specific to its starting file: the same model as the
* two separate ones (checked), but one covariance matrix, so the difference between the
* files can use firms that are in both (clustered by firm). Needs the same modelled
* outcomes in both files; otherwise the differences are left empty and said so.
foreach m in wk out {
    local both_`m' : list terms_`m'_`cohort_covid' & terms_`m'_`cohort_normal'
    local sameouts : list outs_`m'_`cohort_covid' === outs_`m'_`cohort_normal'
    scalar pooled_`m' = 0
    scalar maxdev_`m' = .
    if !(ok_`m'_`cohort_covid' & ok_`m'_`cohort_normal' & `sameouts') | "`both_`m''" == "" {
        display "   `mw_`m'': differences not computed (a model did not run, or the files model different outcomes)"
        continue
    }
    * one marker per trait, 0 in the rows of a file where that trait is not estimated;
    * ibn.coh# gives every marker its own coefficient per starting file
    local alls : list terms_`m'_`cohort_covid' | terms_`m'_`cohort_normal'
    local evars ""
    local efv ""
    foreach t of local alls {
        capture drop e`t'
        gen byte e`t' = 0
        foreach c of local cohorts {
            local inc : list t in terms_`m'_`c'
            if `inc' replace e`t' = d`t' if coh == `c'
        }
        local evars `evars' e`t'
        local efv `efv' ibn.coh#i.e`t'
    }
    capture noisily mlogit outcome5_`m' `efv' i.csec i.cprov if ms_`m', ///
        baseoutcome(`base_`m'_`cohort_covid'') vce(cluster firm_id) iterate(100)
    if _rc | e(converged) != 1 {
        display as error "   `mw_`m'': the pooled model did not run: differences left empty"
        continue
    }
    scalar pooled_`m' = 1
    estimates store pool_`m'
    scalar maxdev_`m' = 0
    * the same "with minus without" pairs as the separate models, per starting file
    local atl ""
    local na 0
    foreach t of local alls {
        local pt ""
        if "`pair`t''" != "" {
            local inp : list pair`t' in alls
            if `inp' local pt " e`pair`t''=0"
        }
        local atl `atl' at(e`t'=0`pt') at(e`t'=1`pt')
        local na = `na' + 2
        local at1_`t' = `na'                               // "with" position; "without" = one before
    }
    foreach j of local outs_`m'_`cohort_covid' {
        estimates restore pool_`m'
        quietly margins, `atl' predict(outcome(`j')) over(coh) post
        matrix mb = e(b)
        local cn : colfullnames e(b)
        * find each (at, file) cell by name (Stata may add "bn" to base levels)
        local q 0
        foreach nm of local cn {
            local ++q
            local cl = subinstr("`nm'", "bn", "", .)
            foreach c of local cohorts {
                forvalues a = 1/`na' {
                    if "`cl'" == "`a'._at#`c'.coh" {
                        local nm_`a'_`c' "`nm'"
                        local qq_`a'_`c' `q'
                    }
                }
            }
        }
        foreach c of local cohorts {
            foreach t of local terms_`m'_`c' {
                local a1 = `at1_`t''
                local a0 = `a1' - 1
                assert "`nm_`a1'_`c''" != "" & "`nm_`a0'_`c''" != ""
                scalar maxdev_`m' = max(maxdev_`m', abs(mb[1, `qq_`a1'_`c''] - mb[1, `qq_`a0'_`c''] - ame_`m'_`c'_`j'_`t'))
            }
        }
        * 2019 minus 2012, trait by trait, and all traits together
        local jt ""
        foreach t of local both_`m' {
            local a1 = `at1_`t''
            local a0 = `a1' - 1
            local ex "_b[`nm_`a1'_`cohort_covid''] - _b[`nm_`a0'_`cohort_covid''] - _b[`nm_`a1'_`cohort_normal''] + _b[`nm_`a0'_`cohort_normal'']"
            quietly lincom `ex'
            scalar dif_`m'_`j'_`t' = r(estimate)
            scalar dse_`m'_`j'_`t' = r(se)
            scalar dp_`m'_`j'_`t'  = r(p)
            local jt `jt' (`ex' = 0)
        }
        quietly test `jt'
        scalar jp_`m'_`j' = r(p)
    }
    * the pooled model reproduces the separate models' effects (a gross-error guard;
    * the two fits stop at slightly different points of the same maximum)
    display "   `mw_`m'': largest gap pooled vs separate effects " %9.2e maxdev_`m'
    assert maxdev_`m' < 1e-4
}

*---------------------------------------------------------------------------
display "Step 6/9: write the table (numbers before drawing)"
*---------------------------------------------------------------------------
scalar z_ = invnormal(0.975)
tempname pf
tempfile res
postfile `pf' str12 section str8 measure int cohort_year str14 later_files byte outcome_id str24 outcome ///
    int row_id str60 label byte estimated byte drawn str80 status ///
    double ame_pp ame_se_pp ame_lo_pp ame_hi_pp diff_pp diff_se_pp diff_p logodds_b logodds_se ///
    firms_with firms_without firms_with_in_outcome firms_model firms_outcome pred_pct actual_pct stat_value ///
    using `res', replace
foreach m in wk out {
    foreach c of local cohorts {
        local lf "`f1_`c'' `f2_`c'' `f3_`c''"
        forvalues j = 1/5 {
            local oest : list j in outs_`m'_`c'
            * (a) one row per outcome and trait: the dots (workers) / table-only (output)
            forvalues t = 1/`nterm' {
                local test : list t in terms_`m'_`c'
                local isest = `oest' & `test' & ok_`m'_`c'
                if `isest' {
                    local st = cond("`m'" == "wk", cond(`c' == `cohort_covid', "drawn: solid dot", "drawn: hollow dot"), "not drawn: output version, table only")
                    scalar a_ = 100 * ame_`m'_`c'_`j'_`t'
                    scalar s_ = 100 * ase_`m'_`c'_`j'_`t'
                    scalar dd_ = .
                    scalar ds_ = .
                    scalar dp_ = .
                    if `c' == `cohort_covid' & pooled_`m' {
                        local inb : list t in both_`m'
                        if `inb' {
                            scalar dd_ = 100 * dif_`m'_`j'_`t'
                            scalar ds_ = 100 * dse_`m'_`j'_`t'
                            scalar dp_ = dp_`m'_`j'_`t'
                        }
                    }
                    scalar lb_ = .
                    scalar ls_ = .
                    if `j' != `base_`m'_`c'' {
                        scalar lb_ = lb_`m'_`c'_`j'_`t'
                        scalar ls_ = lse_`m'_`c'_`j'_`t'
                    }
                    post `pf' ("effect") ("`m'") (`c') ("`lf'") (`j') ("`o`j''") (`t') ("`t`t''") (1) ("`m'" == "wk") ("`st'") ///
                        (a_) (s_) (a_ - z_ * s_) (a_ + z_ * s_) (dd_) (ds_) (dp_) (lb_) (ls_) ///
                        (nw_`m'_`c'_`t') (nwo_`m'_`c'_`t') (nwj_`m'_`c'_`t'_`j') (nfm_`m'_`c') (no_`m'_`c'_`j') (.) (.) (.)
                }
                else {
                    local st "not estimated: the model did not run"
                    if !`test' local st "not estimated: too few firms with or without the trait (fewer than `min_firms')"
                    if !`oest' local st "not estimated: too few firms in this outcome: `=no_`m'_`c'_`j'' (fewer than `min_firms')"
                    post `pf' ("effect") ("`m'") (`c') ("`lf'") (`j') ("`o`j''") (`t') ("`t`t''") (0) (0) ("`st'") ///
                        (.) (.) (.) (.) (.) (.) (.) (.) (.) ///
                        (nw_`m'_`c'_`t') (nwo_`m'_`c'_`t') (nwj_`m'_`c'_`t'_`j') (nfm_`m'_`c') (no_`m'_`c'_`j') (.) (.) (.)
                }
            }
            * (b) one row per outcome: how many firms, share of the starting file's firms
            local st = cond(`oest', "modelled", "not modelled: too few firms: `=no_`m'_`c'_`j'' (fewer than `min_firms')")
            if `j' == `base_`m'_`c'' local st "modelled (base outcome of the raw coefficients)"
            post `pf' ("outcome") ("`m'") (`c') ("`lf'") (`j') ("`o`j''") (0) ("`o`j''") (`oest') (0) ("`st'") ///
                (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (nfm_`m'_`c') (no_`m'_`c'_`j') (.) ///
                (100 * no_`m'_`c'_`j' / nfu_`m'_`c') (.)
            * (c) calibration by tenth of predicted chance
            if `oest' & ok_`m'_`c' {
                forvalues d = 1/`ndec_`m'_`c'_`j'' {
                    post `pf' ("calibration") ("`m'") (`c') ("`lf'") (`j') ("`o`j''") (`d') ("Tenth `d' of predicted chance") (.) (0) ("") ///
                        (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (cn_`m'_`c'_`j'_`d') ///
                        (cp_`m'_`c'_`j'_`d') (ca_`m'_`c'_`j'_`d') (.)
                }
                foreach s in "area under ROC curve|auc" "largest calibration gap (points)|gap" {
                    tokenize "`s'", parse("|")
                    post `pf' ("check") ("`m'") (`c') ("`lf'") (`j') ("`o`j''") (0) ("`1'") (.) (0) ("") ///
                        (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (`3'_`m'_`c'_`j')
                }
                if `c' == `cohort_covid' & pooled_`m' {
                    post `pf' ("check") ("`m'") (`c') ("`lf'") (`j') ("`o`j''") (0) ("all traits `cohort_covid' = `cohort_normal', joint p") (.) (0) ("") ///
                        (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (jp_`m'_`j')
                }
                * table-only check (workers): value added per worker, continuous, per SD
                if "`m'" == "wk" {
                    post `pf' ("check") ("`m'") (`c') ("`lf'") (`j') ("`o`j''") (0) ("value added per worker, continuous (per SD): effect") (.) (0) ("table-only check, not drawn") ///
                        (cz_b_`c'_`j') (cz_se_`c'_`j') (cz_b_`c'_`j' - z_ * cz_se_`c'_`j') (cz_b_`c'_`j' + z_ * cz_se_`c'_`j') ///
                        (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.)
                }
            }
        }
        * (d) model checks, one statistic per row
        local k 0
        foreach s in "firms in the starting file|nf" "firms with every trait known|nfu" ///
            "stayers left out: size change not comparable|nnc" "firms left out: outcome with too few firms|nrare" ///
            "firms in the model|nfm" "model ran and converged|ok" "pseudo R-squared (McFadden)|r2p" ///
            "coefficients above 10 (near perfect prediction)|nbig" "largest gap pooled vs separate effects|maxdev" {
            local ++k
            tokenize "`s'", parse("|")
            if "`3'" == "maxdev" & `c' != `cohort_covid' continue
            local sc = cond("`3'" == "maxdev", "maxdev_`m'", "`3'_`m'_`c'")
            post `pf' ("check") ("`m'") (`c') ("`lf'") (0) ("") (`k') ("`1'") (.) (0) ("") ///
                (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (`sc')
        }
        post `pf' ("check") ("`m'") (`c') ("`lf'") (0) ("") (`++k') ("importer share of firms (%)") (.) (0) ("") ///
            (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (`impsh_`c'')
    }
}
postclose `pf'
use `res', clear
gen str80 outcome_basis = cond(measure == "wk", "workers", "`outbasis_`cohort_covid''")
gen double band_pct = `band_pct'
format ame_pp-stat_value %12.6f
format firms_with-firms_outcome %12.0f
export delimited using "tables/`fname'.csv", datafmt replace
tempfile ctsrc
save `ctsrc'                                          // the companion tables read this
list measure cohort_year outcome label ame_pp ame_lo_pp ame_hi_pp diff_pp diff_p firms_with_in_outcome ///
    if section == "effect" & measure == "wk" & estimated, noobs sep(8) abbreviate(24)
list measure cohort_year outcome label firms_outcome actual_pct stat_value status if inlist(section, "outcome", "check"), ///
    noobs sep(0) abbreviate(24)
assert ame_lo_pp <= ame_pp & ame_pp <= ame_hi_pp if estimated == 1 & section == "effect"

*---------------------------------------------------------------------------
display "Step 7/9: the figure - one panel per outcome, traits in rows, shared scale"
*---------------------------------------------------------------------------
keep if section == "effect" & measure == "wk"
* shared x scale over every drawn interval (steps chosen from the data)
quietly summarize ame_lo_pp if drawn
local xlo = min(r(min), 0)
quietly summarize ame_hi_pp if drawn
local xhi = max(r(max), 0)
if `xlo' == 0 & `xhi' == 0 {
    local xlo -1
    local xhi 1
}
local pad = 0.04 * (`xhi' - `xlo')
local glo = `xlo' - `pad'                              // panel range: the data plus a little room
local ghi = `xhi' + `pad'
local raw = (`xhi' - `xlo') / 3                        // about three labelled ticks per panel
local mag = 10^floor(log10(`raw'))
local step = `mag'
foreach f in 2 2.5 5 10 {
    if `step' < `raw' local step = `f' * `mag'
}
local tlo = `step' * ceil(`glo' / `step')              // labelled ticks inside the range
local thi = `step' * floor(`ghi' / `step')
local W = `ghi' - `glo'
local G = 0.45 * `W'                                  // blank gap between panels
* panel j occupies [ (j-1)(W+G), (j-1)(W+G) + W ] on the drawing axis
gen double off = (outcome_id - 1) * (`W' + `G') - `glo'
gen double xp  = ame_pp + off
gen double xl  = ame_lo_pp + off
gen double xh  = ame_hi_pp + off
gen double y   = row_id + cond(cohort_year == `cohort_covid', -0.17, 0.17)
local xl_all ""
local zl ""
local nz 0
local ptxt ""
forvalues j = 1/5 {
    local o = (`j' - 1) * (`W' + `G') - `glo'
    quietly count if outcome_id == `j' & drawn
    local ndj = r(N)
    * tick labels only under panels with dots
    if `ndj' > 0 {
        forvalues v = `tlo'(`step')`thi' {
            local vv = round(`v', 1e-9)
            local lab = cond(`vv' > 0, "+", "") + strofreal(`vv')
            local xl_all `"`xl_all' `=`o' + `vv'' "`lab'""'
        }
    }
    * panel heading: outcome, then each starting file's share of firms in it
    local l2 ""
    foreach c of local cohorts {
        quietly summarize firms_outcome if outcome_id == `j' & cohort_year == `c', meanonly
        local nj = r(max)
        quietly count if outcome_id == `j' & cohort_year == `c' & estimated
        if r(N) > 0 {
            * share of the modelled firms in this outcome
            quietly summarize firms_model if outcome_id == `j' & cohort_year == `c', meanonly
            local sh = strtrim(string(100 * `nj' / r(max), "%5.0f")) + "%"
        }
        else local sh = strtrim(string(`nj', "%12.0fc")) + " firms"
        local l2 `"`l2' "`c': `sh'""'                   // one line per starting file
    }
    local cx = `o' + (`glo' + `ghi') / 2
    local ptxt `"`ptxt' text(-0.4 `cx' "{bf:`o`j''}" `l2', size(vsmall) placement(c) justification(center))"'
    * zero line (below the headings); an outcome not estimated in either file gets a
    * sentence inside its panel instead
    quietly count if outcome_id == `j' & drawn
    if r(N) > 0 {
        local zl `"`zl' (pci 0.55 `o' 8.45 `o', lcolor(gs11) lwidth(thin))"'
        local ++nz                                     // zero lines come first in the plot list
    }
    if r(N) == 0 {
        local nn ""
        foreach c of local cohorts {
            quietly summarize firms_outcome if outcome_id == `j' & cohort_year == `c', meanonly
            local nn = cond("`nn'" == "", "`c': " + strtrim(string(r(max), "%12.0fc")), "`nn'; `c': " + strtrim(string(r(max), "%12.0fc")))
        }
        local ptxt `"`ptxt' text(4.5 `cx' "Not estimated:" "fewer than `min_firms' firms", size(vsmall) placement(c) justification(center) color(gs6))"'
    }
}
local ylab ""
forvalues t = 1/`nterm' {
    local ylab `"`ylab' `t' "`t`t''""'
}
local xmaxd = 4 * (`W' + `G') + `W'
* Notes: one text, wrapped into lines of at most 150 characters (PDF text runs wider than the PNG)
local ntext "Notes: Firm links are fictional in the development data, so who stays, leaves or comes back means nothing here; read these results on the real BPS files."
local ntext "`ntext' Each dot: how many percentage points more (right) or less (left) likely a firm with the trait was to end in that outcome by the third later file than a similar firm without it (same sector and province, the other traits as they are); line = 95% interval; where it crosses 0 the trait makes no clear difference."
local ntext "`ntext' Left the files = not in the third later file (not proof of closure); absent, then back = missed a later file but in the third; stayed = in all three, then workers in the third file against the starting file (same size = within `band_pct'% either way)."
local ntext "`ntext' Traits come only from the starting file and the two files before it. Compared with: 20–99 workers; known non-exporters; at or below the sector median; non-importers; not foreign-owned; firms in the two files before."
local ntext "`ntext' Importer answers were recorded differently from 2017 (`impsh_`cohort_normal''% importers among the `cohort_normal' firms, `impsh_`cohort_covid''% among the `cohort_covid' firms), so the importer rows are not like for like. Under each heading: share of the file's firms in that outcome."
local ntext "`ntext' New firms leave far more partly because of how the fictional links were drawn. Associations, not the effect of COVID: all firms were hit at once."
local notelines ""
local line ""
foreach w of local ntext {
    if ustrlen("`line' `w'") > 150 & "`line'" != "" {
        local notelines `"`notelines' "`line'""'
        local line "`w'"
    }
    else local line = strtrim("`line' `w'")
}
local notelines `"`notelines' "`line'""'
display `"   note lines: `notelines'"'
local charttitle "Figure R4-05. What became of the `cohort_covid' firms by `f3_`cohort_covid'', by traits known before COVID, against the `cohort_normal' firms by `f3_`cohort_normal''"
local k19 "`cohort_covid' firms, followed to `f3_`cohort_covid'' (COVID)"
local k12 "`cohort_normal' firms, followed to `f3_`cohort_normal'' (normal years)"

twoway `zl' ///
    (rspike xl xh y if drawn & cohort_year == `cohort_covid', horizontal lcolor(black) lwidth(medthin)) ///
    (scatter y xp if drawn & cohort_year == `cohort_covid', msymbol(O) msize(small) mcolor(black)) ///
    (rspike xl xh y if drawn & cohort_year == `cohort_normal', horizontal lcolor(gs7) lwidth(medthin)) ///
    (scatter y xp if drawn & cohort_year == `cohort_normal', msymbol(Oh) msize(small) mcolor(black) mlwidth(medthin)), ///
    yscale(reverse noline range(-1.3 8.5)) ylabel(`ylab', angle(0) noticks nogrid labsize(vsmall) labgap(1)) ytitle("") ///
    xscale(range(0 `xmaxd') lcolor(gs10)) xlabel(`xl_all', labsize(vsmall) tlcolor(gs10) nogrid) ///
    xtitle("Difference in the chance of the outcome, percentage points (trait against no trait)", size(vsmall)) ///
    `ptxt' ///
    legend(order(`=`nz' + 2' "`k19'" `=`nz' + 4' "`k12'" `=`nz' + 1' "95% interval, `cohort_covid' firms" `=`nz' + 3' "95% interval, `cohort_normal' firms") ///
           rows(2) colfirst position(6) region(lstyle(none)) size(vsmall) symxsize(6) keygap(2) colgap(10) rowgap(0.4)) ///
    title("`charttitle'", size(small) position(11) justification(left) span) ///
    note(`notelines' "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6)) ///
    graphregion(color(white) lcolor(white) margin(l+2 r+2)) plotregion(style(none) margin(t=1 b=1 l=1 r=1)) ///
    xsize(10) ysize(7)

graph export "figures/`fname'.png", width(3000) replace
graph export "figures/`fname'.pdf", replace

*---------------------------------------------------------------------------
display "Step 8/9: companion table - every plotted point (putpdf, no add-on)"
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
* --- PART 2: the rows of this exhibit ---------------------------------------
* (1) Points table: one row per outcome panel, trait and starting file, in chart order
*     (panels left to right, traits top to bottom, 2019 above 2012); rows not drawn
*     are included with the reason.
use `ctsrc', clear
keep if section == "effect" & measure == "wk"
gen byte cord = cond(cohort_year == `cohort_covid', 1, 2)
sort outcome_id row_id cord
local npts = _N
gen str40 t_pan = char(64 + outcome_id) + ". " + outcome
gen str60 t_tr  = label
gen str24 t_coh = string(cohort_year) + cond(cohort_year == `cohort_covid', " (COVID)", " (normal years)")
gen str12 t_v   = cond(estimated, cond(round(ame_pp, 0.1) > 0, "+", "") + string(ame_pp, "%9.1f"), "")
gen str12 t_lo  = cond(estimated, cond(round(ame_lo_pp, 0.1) > 0, "+", "") + string(ame_lo_pp, "%9.1f"), "")
gen str12 t_hi  = cond(estimated, cond(round(ame_hi_pp, 0.1) > 0, "+", "") + string(ame_hi_pp, "%9.1f"), "")
gen str12 t_dp  = cond(missing(diff_p), "", cond(diff_p < 0.001, "< 0.001", string(diff_p, "%5.3f")))
gen str12 t_nw  = string(firms_with, "%12.0fc")
gen str12 t_nj  = string(firms_with_in_outcome, "%12.0fc")
gen str80 t_st  = status
* short status so every row stays on one line (the CSV keeps the full reason)
replace t_st = "not estimated: " + string(firms_outcome, "%12.0fc") + " firms in outcome" if !estimated & strpos(status, "this outcome")
replace t_st = "not estimated: trait too rare" if !estimated & strpos(status, "with or without")
replace t_st = "not estimated: model did not run" if !estimated & strpos(status, "did not run")
quietly count if drawn
local ndrawn = r(N)
* thin rule under the last row of each outcome panel
local rl ""
forvalues j = 1/4 {
    quietly count if outcome_id <= `j'
    local rl `rl' `r(N)'
}
local tnote "Table: every point of Figure `exhibit' (workers version), panels left to right, traits top to bottom; values rounded to"
local tnote "`tnote' one decimal. Effect = average marginal effect in percentage points; low/high = 95% interval. Firms with the trait:"
local tnote "`tnote' in the model, and of those in this outcome. 2019 vs 2012 p: test that the two files' effects are equal (pooled model)."
local tnote "`tnote' Not estimated: fewer than `min_firms' firms. Full precision, the reasons and the output version: tables/`fname'.csv."
order t_pan t_tr t_coh t_v t_lo t_hi t_nw t_nj t_dp t_st      // ctable_pdf reads the columns in data order
ctable_pdf t_pan t_tr t_coh t_v t_lo t_hi t_nw t_nj t_dp t_st using "tables/`fname'_table.pdf", ///
    title("Table `exhibit'. What became of the firms, by traits known before COVID: every plotted point") ///
    subtitle("Difference in the chance of each outcome, percentage points, firms with the trait against firms without it") ///
    header("Outcome (panel)" "Trait" "Starting file" "Effect|(points)" "95%|low" "95%|high" "Firms with|the trait" "Of which in|this outcome" "`cohort_covid' vs|`cohort_normal': p" "Status") ///
    right(4 5 6 7 8 9) norepeat(1 2) rules(`rl') fontsize(9) perpage(16) ///
    notes("`ntext'" "`tnote'" "`srcnote'" "`devnote'")
display "table -> tables/`fname'_table.pdf (`npts' rows, `ndrawn' drawn)"

*---------------------------------------------------------------------------
display "Step 9/9: companion table - regression table (AER style)"
*---------------------------------------------------------------------------
* (2) Regression table: one column per starting file and modelled outcome; cell =
*     average marginal effect in percentage points, (standard error) below. Panel A =
*     workers (drawn), Panel B = output (table only). Every number comes from the CSV
*     just written (same estimation run as the chart).
use `ctsrc', clear
* columns: outcomes modelled in either file, per starting file
local cols ""
foreach c of local cohorts {
    if "`cols'" != "" local cols `cols' sp            // narrow blank column between the files
    forvalues j = 1/5 {
        quietly count if section == "outcome" & measure == "wk" & outcome_id == `j' & estimated
        if r(N) > 0 local cols `cols' `c'_`j'
    }
}
local ncol : word count `cols'
local hdr `""Trait""'
local q 0
foreach cj of local cols {
    if "`cj'" == "sp" {
        local hdr `"`hdr' " ""'
        continue
    }
    local ++q
    gettoken c j : cj, parse("_")
    local j = subinstr("`j'", "_", "", 1)
    local oname = lower(substr("`o`j''", 1, 1)) + substr("`o`j''", 2, .)
    local oname = subinstr("`oname'", "stayed, ", "", 1)
    local hdr `"`hdr' "(`q')|`c':|`oname'""'
}
tempname P
tempfile R
local cvars ""
forvalues q = 1/`ncol' {
    local cvars `cvars' str24 k`q'
}
postfile `P' str64 t_lab `cvars' using `R'
local nrow 0
local rl ""
foreach m in wk out {
    local ptitle = cond("`m'" == "wk", "Panel A. Stayers split by workers (drawn in the figure)", "Panel B. Stayers split by `mw_out'; not drawn")
    local e ""
    forvalues q = 1/`ncol' {
        local e `"`e' ("")"'
    }
    post `P' ("`ptitle'") `e'
    local ++nrow
    forvalues t = 1/`nterm' {
        local lb ""
        local ls ""
        foreach cj of local cols {
            if "`cj'" == "sp" {
                local lb `"`lb' ("")"'
                local ls `"`ls' ("")"'
                continue
            }
            gettoken c j : cj, parse("_")
            local j = subinstr("`j'", "_", "", 1)
            quietly summarize ame_pp if section == "effect" & measure == "`m'" & cohort_year == `c' & outcome_id == `j' & row_id == `t' & estimated, meanonly
            if r(N) == 0 {
                local lb `"`lb' ("—")"'
                local ls `"`ls' ("")"'
                continue
            }
            local bb = cond(round(r(mean), 0.01) > 0, "+", "") + string(r(mean), "%9.2f")
            quietly summarize ame_se_pp if section == "effect" & measure == "`m'" & cohort_year == `c' & outcome_id == `j' & row_id == `t', meanonly
            local ss = "(" + string(r(mean), "%9.2f") + ")"
            local lb `"`lb' ("`bb'")"'
            local ls `"`ls' ("`ss'")"'
        }
        post `P' ("`t`t''") `lb'
        post `P' ("") `ls'
        local nrow = `nrow' + 2
    }
    local rl `rl' `nrow'
    * table-only check under Panel A (as R4-04): value added per worker, continuous
    if "`m'" == "wk" {
        local lb ""
        local ls ""
        foreach cj of local cols {
            local b ""
            local se ""
            if "`cj'" != "sp" {
                gettoken c j : cj, parse("_")
                local j = subinstr("`j'", "_", "", 1)
                quietly summarize ame_pp if section == "check" & measure == "wk" & cohort_year == `c' & outcome_id == `j' & label == "value added per worker, continuous (per SD): effect", meanonly
                if r(N) > 0 & r(mean) < . {
                    local b = cond(round(r(mean), 0.01) > 0, "+", "") + string(r(mean), "%9.2f")
                    quietly summarize ame_se_pp if section == "check" & measure == "wk" & cohort_year == `c' & outcome_id == `j' & label == "value added per worker, continuous (per SD): effect", meanonly
                    local se = "(" + string(r(mean), "%9.2f") + ")"
                }
                else local b "—"
            }
            local lb `"`lb' ("`b'")"'
            local ls `"`ls' ("`se'")"'
        }
        post `P' ("Check, not drawn: value added per worker, continuous (per SD)") `lb'
        post `P' ("") `ls'
        local nrow = `nrow' + 2
        local rl `rl' `nrow'
    }
    * whole-model rows, one statistic per column
    foreach s in "Firms in this outcome|n" "Share of the model's firms (%)|sh" "Firms in the model|nm" ///
        "Sector and province groups|fe" "Pseudo R-squared (McFadden)|r2" ///
        "Coefficients above 10 in the model (near perfect prediction)|nb" "Area under ROC curve, this outcome|auc" ///
        "Largest calibration gap (points)|gap" "All traits same in `cohort_covid' and `cohort_normal', joint p|jp" ///
        "Standard errors clustered by|cl" {
        tokenize "`s'", parse("|")
        local lab "`1'"
        local key "`3'"
        local vals ""
        foreach cj of local cols {
            if "`cj'" == "sp" {
                local vals `"`vals' ("")"'
                continue
            }
            gettoken c j : cj, parse("_")
            local j = subinstr("`j'", "_", "", 1)
            local v ""
            quietly summarize firms_outcome if section == "outcome" & measure == "`m'" & cohort_year == `c' & outcome_id == `j', meanonly
            local nj = r(mean)
            quietly summarize firms_model if section == "outcome" & measure == "`m'" & cohort_year == `c' & outcome_id == `j', meanonly
            local nm = r(mean)
            quietly count if section == "outcome" & measure == "`m'" & cohort_year == `c' & outcome_id == `j' & estimated
            local oe = r(N)
            if "`key'" == "n"  local v = string(`nj', "%12.0fc")
            if "`key'" == "sh" & `oe' local v = string(100 * `nj' / `nm', "%5.1f")
            if "`key'" == "nm" & `oe' local v = string(`nm', "%12.0fc")
            if "`key'" == "fe" & `oe' local v "Yes"
            if "`key'" == "cl" & `oe' local v "Firm"
            foreach kk in r2 nb auc gap jp {
                if "`key'" != "`kk'" continue
                local lk = cond("`kk'" == "r2", "pseudo R-squared (McFadden)", cond("`kk'" == "auc", "area under ROC curve", ///
                    cond("`kk'" == "gap", "largest calibration gap (points)", cond("`kk'" == "nb", ///
                    "coefficients above 10 (near perfect prediction)", "all traits `cohort_covid' = `cohort_normal', joint p"))))
                local oc = cond(inlist("`kk'", "r2", "nb"), 0, `j')
                quietly summarize stat_value if section == "check" & measure == "`m'" & cohort_year == `c' & outcome_id == `oc' & label == "`lk'", meanonly
                if r(N) > 0 & r(mean) < . {
                    if "`kk'" == "gap" local v = string(r(mean), "%5.1f")
                    else if "`kk'" == "jp" local v = cond(r(mean) < 0.001, "< 0.001", string(r(mean), "%5.3f"))
                    else if "`kk'" == "nb" local v = string(r(mean), "%9.0f")
                    else local v = string(r(mean), "%5.3f")
                }
            }
            if "`v'" == "" & !`oe' & "`key'" != "n" local v "—"
            local vals `"`vals' ("`v'")"'
        }
        post `P' ("`lab'") `vals'
        local ++nrow
    }
    local rl `rl' `nrow'
}
postclose `P'
* check: the Panel A cells are the plotted dots (CSV, full precision) rounded
use `ctsrc', clear
quietly count if section == "effect" & measure == "wk" & drawn
assert r(N) == `ndrawn'
use `R', clear
local knames ""
forvalues q = 1/`ncol' {
    local knames `knames' k`q'
}
* not-modelled outcomes (fewer than min_firms firms) have no column: say which
local notmod ""
use `ctsrc', clear
forvalues j = 1/5 {
    quietly count if section == "outcome" & measure == "wk" & outcome_id == `j' & !estimated
    if r(N) > 0 {
        local nn ""
        foreach c of local cohorts {
            quietly summarize firms_outcome if section == "outcome" & measure == "wk" & outcome_id == `j' & cohort_year == `c', meanonly
            local nn = cond("`nn'" == "", "`c': " + string(r(mean), "%12.0fc"), "`nn'; `c': " + string(r(mean), "%12.0fc"))
        }
        local notmod = cond("`notmod'" == "", "`=lower("`o`j''")' (`nn' firms)", "`notmod'; `=lower("`o`j''")' (`nn' firms)")
    }
}
use `R', clear
local rnote "Notes: One multinomial logit per starting file (all outcomes at once, one row per firm): the chance of ending in each outcome by"
local rnote "`rnote' the third later file, on the eight traits, with sector and province groups (fewer than `min_firms' firms pooled into 'other')."
local rnote "`rnote' Cell: average marginal effect in percentage points, the chance with the trait minus without it, averaged over the file's firms;"
local rnote "`rnote' size bands and export answers against 20–99 workers and known non-exporters. One file's effects add up to 0 across its outcomes."
local rnote "`rnote' Joint p: a pooled model of both files, every term its own per file, tests that all eight effects are equal in the two files."
local rnote "`rnote' Check row: the yes/no productivity marker replaced by the log distance from the sector median, per standard deviation."
local rnote "`rnote' Calibration gap: largest predicted-minus-actual share over tenths of predicted chance. No stars."
if "`notmod'" != "" local rnote "`rnote' Not modelled (fewer than `min_firms' firms; their firms left out): `notmod'."
ctable_pdf t_lab `knames' using "tables/`fname'_regression.pdf", ///
    title("Table `exhibit', regression. What became of the firms, by traits known before COVID: estimates behind the chart") ///
    subtitle("Average marginal effect, percentage points; (standard error). Outcome by the third later file; traits from the starting file and the two before it.") ///
    header(`hdr') right(2/`=`ncol' + 1') ///
    rules(`rl') fontsize(8.5) perpage(34) landscape ///
    notes("`rnote'" "`srcnote'" "`devnote'")
display "table -> tables/`fname'_regression.pdf"

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/`fname'.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
