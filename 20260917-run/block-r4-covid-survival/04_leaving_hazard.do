/*==========================================================================
  R4-04  Which firms were more likely to leave the survey files after 2019,
         judged only by what was known about them by 2019? And was that
         different from normal years (the 2012 firms, followed 2013-2015)?
  Answers Bu Deasy R4: "Survival analysis??" ... "Which firms survived" -
         Strategy "Survival/hazard model menggunakan pre-COVID
         characteristics".
  Method : discrete-time hazard (a logit, one row per firm and later file
           while the firm is still in the files): the chance of first
           leaving the files at each of the next three files, on traits from
           the starting file and the two files before it only; later-file,
           sector and province dummies; standard errors clustered by firm.
           Dots = average marginal effects in percentage points.
  Output : figures/04_leaving_hazard.png (+ .pdf)
           tables/04_leaving_hazard.csv (effects, odds ratios, model checks,
           calibration by tenth of predicted risk, leaving rate per file)
           tables/04_leaving_hazard_table.pdf      (every plotted point)
           tables/04_leaving_hazard_regression.pdf (the regression table)
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
log using "logs/04_leaving_hazard.log", replace text
timer clear 1
timer on 1
display _newline "=== [R4-04] STARTING: chance of leaving the files by traits known before COVID, 2019 vs 2012 firms ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."
local fname "04_leaving_hazard"

*---------------------------------------------------------------------------
display "Step 1/8: load firm, year, size, value added, trade, ownership, sector and province"
*---------------------------------------------------------------------------
* workers              = persons engaged (size bands)
* value_added_nominal  = value added in current prices (value added per worker)
* export_flag          = exports (0/1; often not answered: "not known" is its own group)
* import_flag          = imports (0/1)
* fdi_10_flag          = 10% or more foreign-owned (0/1; the R1-R3 rule)
* industry2_reported   = 2-digit sector; province_code = province (controls)
* gross_output_nominal / gross_output_real are read only because the shared block needs them.
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
local band_pct 10               // the shared block's neutral band (not used here)
local min_firms 30              // a trait group needs this many firms with and without it

*---------------------------------------------------------------------------
display "Step 2/8: for each starting file: the shared cohort block, the traits, one row per later file"
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
    * -- keep the firms of the starting file and their presence in the next three files --
    keep if in_cohort
    keep firm_id cohort_year new_to_file seen_f1 seen_f2 seen_f3 pattern state_file
    tempfile st
    save `st'
    local f1_`cohort_year' `f1'
    local f2_`cohort_year' `f2'
    local f3_`cohort_year' `f3'
    local p1_`cohort_year' `p1'
    local p2_`cohort_year' `p2'
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

    * -- one row per later file while the firm is still in the files (the "risk set"):
    *    row 1 = first later file (every firm), row 2 = second (if in the first),
    *    row 3 = third (if in the first two). left = 1 if the firm is missing from that file.
    *    A firm stops at its first missing file, so each firm leaves at most once. --
    expand 3
    bysort firm_id: gen byte period = _n
    keep if period == 1 | (period == 2 & seen_f1 == 1) | (period == 3 & seen_f1 == 1 & seen_f2 == 1)
    gen byte left = 1 - cond(period == 1, seen_f1, cond(period == 2, seen_f2, seen_f3))
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
display "Step 3/8: the trait markers, and which traits have enough firms to estimate"
*---------------------------------------------------------------------------
use `stack', clear
* 0/1 marker per trait (reference groups: 20-99 workers; known non-exporters)
gen byte d1 = (sizeb == 1) if !missing(sizeb)   // fewer than 20 workers
gen byte d2 = (sizeb == 3) if !missing(sizeb)   // 100 or more workers
gen byte d3 = hiprod                            // value added per worker above its sector's median
gen byte d4 = (expst == 1)                      // exporter
gen byte d5 = (expst == 2)                      // export answer not known
gen byte d6 = imp                               // importer
gen byte d7 = fdi                               // 10% or more foreign-owned
gen byte d8 = new_to_file                       // in neither of the two files before
local nterm 8
local t1 "Fewer than 20 workers"
local t2 "100 or more workers"
local t3 "Value added per worker above its sector's median"
local t4 "Exporter"
local t5 "Export answer not known"
local t6 "Importer"
local t7 "Foreign-owned (10% or more)"
local t8 "New to the files (not in the two files before)"
* a firm is usable when every trait is known (value added per worker needs workers > 0)
egen byte n_miss = rowmiss(d1-d8)
gen byte usable = (n_miss == 0)
* firm-level counts per starting file (period 1 = one row per firm), kept as scalars
foreach c of local cohorts {
    quietly count if coh == `c' & period == 1
    local nf_`c' = r(N)
    quietly count if coh == `c' & period == 1 & usable
    local nfu_`c' = r(N)
    quietly count if coh == `c' & usable
    local nr_`c' = r(N)
    quietly count if coh == `c' & usable & left
    local ne_`c' = r(N)
    * the whole file is left out when leaving (or staying) is rare
    quietly count if coh == `c' & usable & !left
    local model_`c' = (`ne_`c'' >= `min_firms' & r(N) >= `min_firms')
    local terms_`c' ""
    forvalues t = 1/`nterm' {
        quietly count if coh == `c' & period == 1 & usable & d`t' == 1
        scalar nw_`t'_`c' = r(N)                       // firms with the trait
        quietly count if coh == `c' & period == 1 & usable & d`t' == 0
        scalar nwo_`t'_`c' = r(N)                      // firms without it
        quietly count if coh == `c' & usable & d`t' == 1
        scalar rw_`t'_`c' = r(N)                       // rows (firm x later file) with it
        quietly count if coh == `c' & usable & d`t' == 1 & left
        scalar ev_`t'_`c' = r(N)                       // of which: left the files
        local ok = (nw_`t'_`c' >= `min_firms' & nwo_`t'_`c' >= `min_firms' & `model_`c'')
        scalar est_`t'_`c' = `ok'
        if `ok' local terms_`c' `terms_`c'' `t'
        * one marker per trait and starting file (0 in the other file's rows), so one
        * pooled model gives each starting file its own coefficients
        if `ok' gen byte x`t'_`c' = d`t' * (coh == `c')
    }
    display "   `c' firms: `nf_`c'' (usable `nfu_`c''), rows `nr_`c'', leaving events `ne_`c''; traits estimated: `terms_`c''"
}
* importer share of each starting file's usable firms (for the notes: not like for like)
foreach c of local cohorts {
    quietly summarize d6 if coh == `c' & period == 1 & usable
    scalar impsh_`c' = 100 * r(mean)
    local impsh_`c' = strtrim(string(impsh_`c', "%5.0f"))
}
* cohort-specific later-file, sector and province groups (each starting file its own dummies)
egen long cper  = group(coh period)
egen long csec  = group(coh sector)
egen long cprov = group(coh prov)
keep if usable
local xvars ""
foreach c of local cohorts {
    foreach t of local terms_`c' {
        local xvars `xvars' x`t'_`c'
    }
}
display "   markers in the model: `xvars'"
assert "`xvars'" != ""                 // at least one trait can be estimated

*---------------------------------------------------------------------------
display "Step 4/8: one logit for both starting files (each its own coefficients), effects, odds ratios"
*---------------------------------------------------------------------------
* Model, per row (firm i, later file k, starting file c):
*   Pr(firm i is missing from file k | still in the files before k)
*     = logistic( later-file dummy[c,k] + trait markers[c] + sector[c] + province[c] )
* Both starting files sit in one logit, but every term is specific to its starting
* file, so the coefficients equal two separate logits (checked below); one model lets
* the 2019-minus-2012 difference use firms that are in both files (clustered by firm).
foreach c of local cohorts {
    scalar cz_b_`c'  = .                              // continuous check, filled below
    scalar cz_se_`c' = .
}
capture noisily logit left i.(`xvars') i.cper i.csec i.cprov, vce(cluster firm_id)
local model_ok = (_rc == 0)
if !`model_ok' display as error "   the model did not run: every trait is written as 'not estimated'"
if `model_ok' {
    estimates store pooled
    scalar nclust = e(N_clust)                        // firms in the model (a firm in both files counts once)
    gen byte in_est = e(sample)
    * rows dropped because a sector or province predicts leaving (or staying) perfectly
    foreach c of local cohorts {
        quietly count if coh == `c'
        local a = r(N)
        quietly count if coh == `c' & in_est
        scalar drop_`c' = `a' - r(N)
        scalar nrow_`c' = r(N)
        quietly count if coh == `c' & in_est & left
        scalar nev_`c' = r(N)
        quietly count if coh == `c' & in_est & period == 1
        scalar nfirm_`c' = r(N)
        foreach t of local terms_`c' {
            scalar lb_`t'_`c'  = _b[1.x`t'_`c']       // log odds ratio of the trait
            scalar lse_`t'_`c' = _se[1.x`t'_`c']
        }
    }
    * check: two separate logits give the same coefficients and effects
    foreach c of local cohorts {
        if "`terms_`c''" == "" continue
        local xs ""
        foreach t of local terms_`c' {
            local xs `xs' x`t'_`c'
        }
        quietly logit left i.(`xs') i.cper i.csec i.cprov if coh == `c', vce(cluster firm_id)
        scalar rank_`c' = e(rank)                     // coefficients estimated for this file
        foreach t of local terms_`c' {
            assert reldif(_b[1.x`t'_`c'], lb_`t'_`c') < 1e-6
        }
        quietly margins, dydx(`xs')
        matrix ms = r(b)
        foreach t of local terms_`c' {
            scalar amesep_`t'_`c' = ms[1, colnumb(ms, "1.x`t'_`c'")]
        }
    }
    * table-only check (not drawn, not in the CSV): value added per worker as a continuous
    * measure (log distance from its sector's median, per standard deviation across the
    * starting file's firms) in place of the yes/no marker; otherwise the same model
    foreach c of local cohorts {
        if "`terms_`c''" == "" continue
        local xs ""
        foreach t of local terms_`c' {
            if `t' != 3 local xs `xs' x`t'_`c'
        }
        capture drop zc
        quietly summarize lvr if coh == `c' & period == 1
        local sdz = r(sd)                             // SD across the firms of this starting file
        gen double zc = lvr / `sdz' if coh == `c'
        capture {
            quietly logit left `=cond("`xs'" != "", "i.(`xs')", "")' c.zc i.cper i.csec i.cprov if coh == `c', vce(cluster firm_id)
            quietly margins, dydx(zc)
            matrix mz = r(b)
            matrix vz = r(V)
            scalar cz_b_`c'  = 100 * mz[1, 1]
            scalar cz_se_`c' = 100 * sqrt(vz[1, 1])
        }
        display "   check `c': value added per worker, continuous (per SD): " %6.2f cz_b_`c' " points (SE " %5.2f cz_se_`c' ")"
    }
    capture drop zc
    estimates restore pooled
    predict double phat if in_est, pr                 // predicted chance of leaving at that file
    * average marginal effects over each starting file's own rows (the dots)
    margins, dydx(`xvars') over(coh) post
    matrix mb = e(b)
    matrix mV = e(V)
    local cn : colfullnames e(b)
    local j 0
    foreach nm of local cn {
        local ++j
        local cl = subinstr("`nm'", "bn.coh", ".coh", 1)
        foreach c of local cohorts {
            foreach t of local terms_`c' {
                if "`cl'" == "1.x`t'_`c':`c'.coh" {
                    local nm_`t'_`c' "`nm'"
                    scalar ame_`t'_`c' = mb[1, `j']
                    scalar ase_`t'_`c' = sqrt(mV[`j', `j'])
                }
            }
        }
    }
    foreach c of local cohorts {
        foreach t of local terms_`c' {
            assert "`nm_`t'_`c''" != ""
            assert abs(ame_`t'_`c' - amesep_`t'_`c') < 1e-6   // same as the separate logit
        }
    }
    * 2019 minus 2012, trait by trait, and all traits together
    local both : list terms_`cohort_covid' & terms_`cohort_normal'
    local jt ""
    foreach t of local both {
        quietly lincom _b[`nm_`t'_`cohort_covid''] - _b[`nm_`t'_`cohort_normal'']
        scalar dif_`t' = r(estimate)
        scalar dse_`t' = r(se)
        scalar dp_`t'  = r(p)
        local jt `jt' (_b[`nm_`t'_`cohort_covid''] = _b[`nm_`t'_`cohort_normal''])
    }
    scalar joint_p = .
    if "`jt'" != "" {
        quietly test `jt'
        scalar joint_p = r(p)
        scalar joint_chi2 = r(chi2)
        scalar joint_df = r(df)
    }
    if "`jt'" != "" display "   all traits, `cohort_covid' vs `cohort_normal' together: chi2(" joint_df ") = " %6.2f joint_chi2 ", p = " %6.4f joint_p
}

*---------------------------------------------------------------------------
display "Step 5/8: model checks: rare outcomes, perfect prediction, calibration"
*---------------------------------------------------------------------------
* leaving rate per later file (actual, and average predicted)
foreach c of local cohorts {
    forvalues k = 1/3 {
        quietly count if coh == `c' & period == `k'
        scalar lr_n_`k'_`c' = r(N)
        quietly count if coh == `c' & period == `k' & left
        scalar lr_e_`k'_`c' = r(N)
        scalar lr_p_`k'_`c' = .
        if `model_ok' {
            quietly summarize phat if coh == `c' & period == `k'
            scalar lr_p_`k'_`c' = 100 * r(mean)
        }
    }
}
* calibration: rows sorted into tenths of predicted risk; predicted vs actual share;
* Hosmer-Lemeshow statistic = sum over tenths of (actual - predicted)^2 / (pred x (1 - pred/n)), 8 df
foreach c of local cohorts {
    scalar auc_`c' = .
    scalar hl_`c' = .
    scalar hlp_`c' = .
    scalar gap_`c' = .
    if !`model_ok' | "`terms_`c''" == "" continue
    quietly roctab left phat if coh == `c' & in_est
    scalar auc_`c' = r(area)                          // 0.5 = no better than chance, 1 = perfect sorting
    quietly xtile dec_`c' = phat if coh == `c' & in_est, nquantiles(10)
    scalar hl_`c' = 0
    scalar gap_`c' = 0
    quietly levelsof dec_`c', local(decs)
    local ndec : word count `decs'
    foreach d of local decs {
        quietly count if dec_`c' == `d'
        scalar cal_n_`d'_`c' = r(N)
        quietly summarize left if dec_`c' == `d'
        scalar cal_a_`d'_`c' = 100 * r(mean)
        scalar cal_o = r(sum)
        quietly summarize phat if dec_`c' == `d'
        scalar cal_p_`d'_`c' = 100 * r(mean)
        scalar cal_e = r(sum)
        scalar hl_`c' = hl_`c' + (cal_o - cal_e)^2 / (cal_e * (1 - cal_e / cal_n_`d'_`c'))
        scalar gap_`c' = max(gap_`c', abs(cal_a_`d'_`c' - cal_p_`d'_`c'))
    }
    scalar hlp_`c' = chi2tail(`ndec' - 2, hl_`c')
    local ndec_`c' `ndec'
    display "   `c': rows " nrow_`c' ", leaving events " nev_`c' ", coefficients " rank_`c' ", dropped for perfect prediction " drop_`c' ///
        "; area under ROC " %5.3f auc_`c' "; Hosmer-Lemeshow p " %5.3f hlp_`c' "; largest gap " %4.1f gap_`c' " points"
}

*---------------------------------------------------------------------------
display "Step 6/8: write the table (numbers before drawing)"
*---------------------------------------------------------------------------
scalar z_ = invnormal(0.975)
tempname pf
tempfile res
postfile `pf' str12 section int cohort_year str14 later_files int row_id str60 label byte estimated str60 status ///
    double ame_pp ame_se_pp ame_lo_pp ame_hi_pp logit_b logit_se odds_ratio or_se or_lo or_hi ///
    diff_pp diff_se_pp diff_p firms_with firms_without rows_with events_with ///
    firms_model rows_model events_model pred_pct actual_pct stat_value using `res', replace
foreach c of local cohorts {
    local lf "`f1_`c'' `f2_`c'' `f3_`c''"
    * (a) one row per trait: the dots
    forvalues t = 1/`nterm' {
        local isest : list t in terms_`c'
        local isest = `isest' & `model_ok'
        local st = cond(`isest', "estimated", "not estimated: too few firms (fewer than `min_firms' with or without)")
        if !`model_ok' local st "not estimated: the model did not run"
        if `isest' {
            scalar a_ = 100 * ame_`t'_`c'
            scalar s_ = 100 * ase_`t'_`c'
            scalar lb_ = lb_`t'_`c'
            scalar ls_ = lse_`t'_`c'
            scalar dd_ = .
            scalar ds_ = .
            scalar dp_ = .
            local inboth : list t in both
            if `inboth' & `c' == `cohort_covid' {
                scalar dd_ = 100 * dif_`t'
                scalar ds_ = 100 * dse_`t'
                scalar dp_ = dp_`t'
            }
            post `pf' ("effect") (`c') ("`lf'") (`t') ("`t`t''") (1) ("`st'") ///
                (a_) (s_) (a_ - z_ * s_) (a_ + z_ * s_) (lb_) (ls_) (exp(lb_)) (exp(lb_) * ls_) ///
                (exp(lb_ - z_ * ls_)) (exp(lb_ + z_ * ls_)) (dd_) (ds_) (dp_) ///
                (nw_`t'_`c') (nwo_`t'_`c') (rw_`t'_`c') (ev_`t'_`c') (nfirm_`c') (nrow_`c') (nev_`c') (.) (.) (.)
        }
        else {
            post `pf' ("effect") (`c') ("`lf'") (`t') ("`t`t''") (0) ("`st'") ///
                (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) ///
                (nw_`t'_`c') (nwo_`t'_`c') (rw_`t'_`c') (ev_`t'_`c') (.) (.) (.) (.) (.) (.)
        }
    }
    * (b) leaving rate at each later file
    forvalues k = 1/3 {
        post `pf' ("leaving_rate") (`c') ("`lf'") (`k') ("Missing from the `f`k'_`c'' file (first time)") (.) ("") ///
            (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) ///
            (.) (lr_n_`k'_`c') (lr_e_`k'_`c') (lr_p_`k'_`c') (100 * lr_e_`k'_`c' / lr_n_`k'_`c') (.)
    }
    * (c) calibration by tenth of predicted risk
    if `model_ok' & "`terms_`c''" != "" {
        forvalues d = 1/`ndec_`c'' {
            post `pf' ("calibration") (`c') ("`lf'") (`d') ("Tenth `d' of predicted risk") (.) ("") ///
                (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) ///
                (.) (cal_n_`d'_`c') (.) (cal_p_`d'_`c') (cal_a_`d'_`c') (.)
        }
    }
    * (d) model checks, one statistic per row
    local k 0
    foreach s in "firms in the starting file|nf_`c'" "firms with every trait known|nfu_`c'" ///
        "firms in the model|nfirm_`c'" "rows in the model|nrow_`c'" "leaving events in the model|nev_`c'" ///
        "coefficients estimated|rank_`c'" "rows dropped: perfect prediction|drop_`c'" ///
        "area under ROC curve|auc_`c'" "Hosmer-Lemeshow statistic|hl_`c'" "Hosmer-Lemeshow p|hlp_`c'" ///
        "largest calibration gap (points)|gap_`c'" "importer share of firms (%)|impsh_`c'" ///
        "firms in the model, both files (clusters)|nclust" ///
        "all traits `cohort_covid' = `cohort_normal', joint p|joint_p" {
        local ++k
        tokenize "`s'", parse("|")
        if inlist("`3'", "joint_p", "nclust") & `c' != `cohort_covid' continue   // one value for both files
        scalar v_ = .
        if inlist("`3'", "nf_`c'", "nfu_`c'") scalar v_ = ``3''
        else if "`3'" == "impsh_`c'" scalar v_ = impsh_`c'
        else if `model_ok' capture scalar v_ = `3'
        post `pf' ("check") (`c') ("`lf'") (`k') ("`1'") (.) ("") ///
            (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (v_)
    }
}
postclose `pf'
use `res', clear
format ame_pp-stat_value %12.6f
format firms_with-events_model %12.0f
export delimited using "tables/`fname'.csv", datafmt replace
list cohort_year label ame_pp ame_lo_pp ame_hi_pp odds_ratio diff_pp diff_p firms_with if section == "effect", ///
    noobs sep(0) abbreviate(24)
list section cohort_year label rows_model events_model pred_pct actual_pct stat_value if section != "effect", ///
    noobs sep(0) abbreviate(24)
assert ame_lo_pp <= ame_pp & ame_pp <= ame_hi_pp if estimated == 1

*---------------------------------------------------------------------------
display "Step 7/8: dot-and-whisker chart, read back from the CSV just written"
*---------------------------------------------------------------------------
import delimited using "tables/`fname'.csv", clear varnames(1) encoding("utf-8") stringcols(3)
tempfile csv
save `csv'
* numbers for the notes (read from the table, never typed)
local jp "not tested"
quietly summarize stat_value if section == "check" & strpos(label, "joint p") > 0
if r(N) == 1 & !missing(r(mean)) local jp = "p = " + strtrim(string(r(mean), "%5.2f"))
keep if section == "effect"
* chart rows: short labels under four bold headings (the tables use the same words)
local c1 "Fewer than 20 workers"
local c2 "100 or more workers"
local c3 "Above its sector's median"
local c4 "Exporter"
local c5 "No export answer, three files"
local c6 "Importer"
local c7 "Foreign-owned (10% or more)"
local c8 "Not in the two files before"
local hA "Size (against 20–99 workers)"
local hB "Value added per worker"
local hC "Exports (against non-exporters)"
local hD "Other traits (yes against no)"
local hd1 A
local hd3 B
local hd4 C
local hd6 D
* y position of each trait row (a heading sits one row above its first trait)
local y1 1
local y2 2
local y3 4.2
local y4 6.4
local y5 7.4
local y6 9.6
local y7 10.6
local y8 11.6
local ymax 12.2
local ylab `"0 "{bf:`hA'}" 1 "`c1'" 2 "`c2'" 3.2 "{bf:`hB'}" 4.2 "`c3'" 5.4 "{bf:`hC'}" 6.4 "`c4'" 7.4 "`c5'" 8.6 "{bf:`hD'}" 9.6 "`c6'" 10.6 "`c7'" 11.6 "`c8'""'
gen double yrow = .
forvalues t = 1/`nterm' {
    replace yrow = `y`t'' if row_id == `t'
}
* COVID-years file just above the row line, normal-years file just below
gen byte ser = cond(cohort_year == `cohort_covid', 1, 2)
gen double y = yrow + 0.2 * cond(ser == 1, -1, 1)
* value labels (1 decimal): two columns right of the plot, one per starting file
gen str8 plab = string(ame_pp, "%4.1f") if estimated == 1
replace plab = "n.e." if estimated == 0          // not estimated: too few firms
* x range from the data (0 always shown), steps that fit the range; the value columns
* sit right of the last axis label
quietly summarize ame_lo_pp
local dmin = min(r(min), 0)
quietly summarize ame_hi_pp
local dmax = max(r(max), 0)
local w = `dmax' - `dmin'
local step = 10^floor(log10(`w'))
if `w'/`step' < 2       local step = `step'/5
else if `w'/`step' < 5  local step = `step'/2
local xlo = `step' * floor(`dmin' / `step')
local xhi = `step' * ceil(`dmax' / `step')
local xw  = `xhi' - `xlo'
local xc1 = `xhi' + 0.13 * `xw'                  // value column, COVID-years file
local xc2 = `xhi' + 0.25 * `xw'                  // value column, normal-years file
local xend = `xhi' + 0.30 * `xw'
gen double labx = cond(ser == 1, `xc1', `xc2')
display "   x axis `xlo' to `xhi', step `step'; value columns at `xc1' and `xc2'"
* dashed 0 line as its own series, so the legend can key it
local n0 = _N
set obs `=_N + 2'
gen double refx = 0 if _n > `n0'
gen double refy = cond(_n == `n0' + 1, -0.5, `ymax') if _n > `n0'
sort refy ser y

local lf1 "`f1_`cohort_covid''–`f3_`cohort_covid''"
local lf2 "`f1_`cohort_normal''–`f3_`cohort_normal''"
local k1 "`cohort_covid' firms, followed `lf1' (COVID years)"
local k2 "`cohort_normal' firms, followed `lf2' (normal years)"
local s1 "`cohort_covid' firms (COVID years)"
local s2 "`cohort_normal' firms (normal years)"
local tl1 "Figure R4-04. Chance of leaving the survey files, by traits known before COVID:"
local tl2 "the `cohort_covid' firms against the `cohort_normal' firms"
local charttitle "`tl1' `tl2'"
* Notes: one text, wrapped into lines of at most 108 characters (PDF text runs wider than the PNG)
* "n.e." explained only when some trait could not be estimated
quietly count if estimated == 0
local nenote = cond(r(N) > 0, " (n.e. = not estimated: fewer than `min_firms' firms with or without the trait)", "")
local ntext "Notes: Firm links are fictional in the development data, so who stays, leaves or comes back means nothing here; read this chart on the real BPS files. Each firm of the starting file is followed until the first later file it is missing from ('leaves'; not proof of closure: the files record no closures). Dot = percentage points more (right of 0) or less likely to leave at each next file than a similar firm without the trait (same sector, province and other traits)`nenote'. Traits come only from the starting file and the two files before it. Where a 95% bar crosses 0 there is no clear difference. The gap between the two dots is an association, not the effect of COVID; the gaps are clear together only if p < 0.05 (here `jp'). Importers are not like for like (`impsh_`cohort_normal''% of the `cohort_normal' firms, `impsh_`cohort_covid''% of the `cohort_covid' firms: the recorded share jumps). Firms not in the two files before leave far more partly because of how the fictional links were drawn. Value added = output minus inputs bought (current prices)."
local notelines ""
local line ""
foreach w of local ntext {
    if ustrlen("`line' `w'") > 108 & "`line'" != "" {
        local notelines `"`notelines' "`line'""'
        local line "`w'"
    }
    else local line = strtrim("`line' `w'")
}
local notelines `"`notelines' "`line'""'
display `"   note lines: `notelines'"'

twoway (rspike ame_lo_pp ame_hi_pp y if ser == 1, horizontal lcolor(black) lwidth(thin)) ///
    (rspike ame_lo_pp ame_hi_pp y if ser == 2, horizontal lcolor(gs8) lwidth(thin)) ///
    (scatter y ame_pp if ser == 1, msymbol(O) mcolor(black) msize(small)) ///
    (scatter y ame_pp if ser == 2, msymbol(Oh) mcolor(gs5) msize(small) mlwidth(medthin)) ///
    (scatter y labx if ser == 1, msymbol(none) mlabel(plab) mlabposition(0) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter y labx if ser == 2, msymbol(none) mlabel(plab) mlabposition(0) mlabsize(vsmall) mlabcolor(gs6)) ///
    (line refy refx, lpattern(dash) lcolor(gs8) lwidth(thin)), ///
    text(0 `xc1' "`cohort_covid'" 0 `xc2' "`cohort_normal'", size(vsmall) placement(c)) ///
    yscale(reverse noline range(-0.5 `ymax')) ylabel(`ylab', angle(0) noticks nogrid labsize(vsmall) labgap(1)) ytitle("") ///
    xscale(range(`xlo' `xend') noline) ///
    xlabel(`xlo'(`step')`xhi', format(%9.0f) labsize(vsmall) tlcolor(gs10) grid glcolor(gs15) glwidth(vthin)) ///
    xtitle("Difference in the chance of leaving at each next file (percentage points)", size(vsmall) justification(left)) ///
    legend(order(3 "`k1'" 4 "`k2'" 1 "95% interval (gray bar: `cohort_normal' firms)" 7 "0 = no difference") ///
           cols(1) position(6) region(lstyle(none)) size(vsmall) symxsize(6) keygap(1) rowgap(0.2)) ///
    title("`tl1'" "`tl2'", size(small) position(11) justification(left) span) ///
    note(`notelines' "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6)) ///
    graphregion(color(white) lcolor(white) margin(l+2 r+2)) plotregion(style(none) margin(t=1 b=1)) ///
    xsize(8.5) ysize(9.5)

graph export "figures/`fname'.png", width(2550) replace
graph export "figures/`fname'.pdf", replace

*---------------------------------------------------------------------------
display "Step 8/8: companion tables: every plotted point, and the regression table"
*---------------------------------------------------------------------------
* Both tables are read back from the CSV written in Step 6 (the chart's numbers),
* after the chart is saved, so the chart and the CSV are not touched here.
* Written with putpdf (built into Stata; no add-on).
local ptab "tables/`fname'_table.pdf"
local rtab "tables/`fname'_regression.pdf"
local tfont "Times New Roman"
local ftitle = substr("`charttitle'", strpos("`charttitle'", ".") + 2, .)
* ---- (a) every plotted point, in chart order: trait by trait, COVID-years dot then normal-years dot ----
use `csv', clear
keep if section == "effect"
gen byte ser = cond(cohort_year == `cohort_covid', 1, 2)
sort row_id ser
local np = _N
assert `np' == 2 * `nterm'                              // every chart row, both starting files, once
local nhead 4
local ntab = 1 + `np' + `nhead'
putpdf clear
putpdf begin, pagesize(letter) landscape font("`tfont'", 9) margin(all, 0.6in)
putpdf paragraph, spacing(after, 6pt)
putpdf text ("Table R4-04. `ftitle': every plotted point"), bold font("`tfont'", 11)
matrix PW = (23, 18, 7, 6, 6, 8, 8, 8, 16)
putpdf table P = (`ntab', 9), border(all, nil) width(PW)
local c 0
foreach h in "Row on the chart" "Series (legend)" "Points (dot)" "95% low" "95% high" ///
    "Firms with the trait" "Firms without" "Rows with the trait" "Status" {
    local ++c
    local al = cond(inlist(`c', 1, 2, 9), "left", "right")
    putpdf table P(1, `c') = ("`h'"), halign(`al') bold
}
local r 1
forvalues i = 1/`np' {
    local t = row_id[`i']
    local s = ser[`i']
    if "`hd`t''" != "" & `s' == 1 {
        local ++r
        putpdf table P(`r', 1) = ("`h`hd`t'''"), bold colspan(9)
    }
    local ++r
    local ser = cond(`s' == 1, "`s1'", "`s2'")
    if estimated[`i'] == 1 {
        local f1 = string(ame_pp[`i'], "%4.1f")
        local f2 = string(ame_lo_pp[`i'], "%4.1f")
        local f3 = string(ame_hi_pp[`i'], "%4.1f")
        local st = cond(`s' == 1, "black dot and bar", "hollow gray dot and bar")
    }
    else {
        local f1 ""
        local f2 ""
        local f3 ""
        local st "not drawn: too few firms"
    }
    putpdf table P(`r', 1) = ("`c`t''"), halign(left)
    putpdf table P(`r', 2) = ("`ser'"), halign(left)
    putpdf table P(`r', 3) = ("`f1'"), halign(right)
    putpdf table P(`r', 4) = ("`f2'"), halign(right)
    putpdf table P(`r', 5) = ("`f3'"), halign(right)
    putpdf table P(`r', 6) = ("`=string(firms_with[`i'], "%9.0fc")'"), halign(right)
    putpdf table P(`r', 7) = ("`=string(firms_without[`i'], "%9.0fc")'"), halign(right)
    putpdf table P(`r', 8) = ("`=string(rows_with[`i'], "%9.0fc")'"), halign(right)
    putpdf table P(`r', 9) = ("`st'"), halign(left) margin(left, 6pt)
}
assert `r' == `ntab'
forvalues j = 1/9 {                                     // tight rows: table and notes fit one page
    putpdf table P(., `j'), margin(top, 0pt) margin(bottom, 0pt)
}
putpdf table P(1, .), border(top, single) border(bottom, single)
putpdf table P(`ntab', .), border(bottom, single)
putpdf paragraph, font("`tfont'", 8) spacing(before, 6pt)
putpdf text ("Points = average marginal effect in percentage points (the chart label, 1 decimal). Firms = firms of the starting file with every trait known; ")
putpdf text ("rows = firm x later-file rows in the model (a firm has one row per later file until it leaves). Odds ratios, standard errors, ")
putpdf text ("the `cohort_covid'-minus-`cohort_normal' difference and the model checks: `rtab'.")
putpdf paragraph, font("`tfont'", 8)
putpdf text ("`ntext'")                                  // the chart's notes, unwrapped
putpdf paragraph, font("`tfont'", 8)
putpdf text ("`srcnote'")
putpdf paragraph, font("`tfont'", 8)
putpdf text ("`devnote'")
putpdf save "`ptab'", replace
display "table -> `ptab' (`np' plotted points)"

* ---- (b) the regression table: effects (the dots), odds ratios, model checks, calibration ----
use `csv', clear
* helper: cell text for one statistic of one starting file (column 1 = COVID years, 2 = normal years)
local cc1 `cohort_covid'
local cc2 `cohort_normal'
putpdf clear
putpdf begin, pagesize(letter) font("`tfont'", 9) margin(left, 0.7in) margin(right, 0.7in) margin(top, 0.5in) margin(bottom, 0.5in)
putpdf paragraph, spacing(after, 4pt)
putpdf text ("Table R4-04 (regression). `ftitle': the model behind each dot"), bold font("`tfont'", 11)
putpdf paragraph, spacing(after, 4pt)
putpdf text ("Panel A. Average marginal effects on the chance of leaving at each next file (percentage points): the dots"), italic
local nsA 17
local nrA = 1 + `nterm' + `nhead' + `nsA'
matrix RW = (43, 19, 19, 19)
putpdf table A = (`nrA', 4), border(all, nil) width(RW)
putpdf table A(1, 1) = ("Trait known by the starting file"), halign(left)
putpdf table A(1, 2) = ("(1) `cohort_covid' firms,"), halign(right) linebreak
putpdf table A(1, 2) = ("followed `lf1'"), append
putpdf table A(1, 3) = ("(2) `cohort_normal' firms,"), halign(right) linebreak
putpdf table A(1, 3) = ("followed `lf2'"), append
putpdf table A(1, 4) = ("(3) Difference"), halign(right) linebreak
putpdf table A(1, 4) = ("(1) − (2)"), append
local r 1
forvalues t = 1/`nterm' {
    if "`hd`t''" != "" {
        local ++r
        putpdf table A(`r', 1) = ("`h`hd`t'''"), bold colspan(4)
    }
    local ++r
    putpdf table A(`r', 1) = ("`c`t''"), halign(left)
    local trowsA `trowsA' `r'
    forvalues k = 1/2 {
        quietly summarize ame_pp if section == "effect" & row_id == `t' & cohort_year == `cc`k''
        local bb = r(mean)
        quietly summarize ame_se_pp if section == "effect" & row_id == `t' & cohort_year == `cc`k''
        local ss = r(mean)
        if `bb' < . {
            putpdf table A(`r', `=`k' + 1') = ("`=string(`bb', "%9.2f")'"), halign(right) linebreak
            putpdf table A(`r', `=`k' + 1') = ("(`=string(`ss', "%9.2f")')"), append
        }
        else putpdf table A(`r', `=`k' + 1') = ("not estimated"), halign(right)
    }
    quietly summarize diff_pp if section == "effect" & row_id == `t' & cohort_year == `cc1'
    local bb = r(mean)
    quietly summarize diff_se_pp if section == "effect" & row_id == `t' & cohort_year == `cc1'
    local ss = r(mean)
    if `bb' < . {
        putpdf table A(`r', 4) = ("`=string(`bb', "%9.2f")'"), halign(right) linebreak
        putpdf table A(`r', 4) = ("(`=string(`ss', "%9.2f")')"), append
    }
}
local rcoef = `r'
* summary rows (the same model run as the coefficients)
local s1  "Difference in all traits together, p (joint test)"
local s2  "Share of rows that leave (%)"
local s3  "Observations (firm x later-file rows)"
local s4  "Firms (clusters)"
local s5  "Leaving events"
local s6  "Coefficients estimated (with the constant)"
local s7  "Leaving events per coefficient"
local s8  "Rows dropped for perfect prediction"
local s9  "Later-file dummies"
local s10 "Sector dummies (fewer than `min_firms' firms pooled)"
local s11 "Province dummies (fewer than `min_firms' firms pooled)"
local s12 "Firm fixed effects"
local s13 "Weights"
local s14 "Standard errors"
local s15 "Area under the ROC curve (0.5 = chance)"
local s16 "Calibration: Hosmer–Lemeshow p (tenths)"
local s17 "Calibration: largest gap, predicted vs actual (points)"
local st3  "rows in the model"
local st4  "firms in the model"
local st5  "leaving events in the model"
local st6  "coefficients estimated"
local st8  "rows dropped: perfect prediction"
local st15 "area under ROC curve"
local st16 "Hosmer-Lemeshow p"
local st17 "largest calibration gap (points)"
forvalues s = 1/`nsA' {
    local ++r
    putpdf table A(`r', 1) = ("`s`s''"), halign(left)
    forvalues k = 1/2 {
        local cell ""
        if inlist(`s', 3, 4, 5, 6, 8, 15, 16, 17) {
            quietly summarize stat_value if section == "check" & cohort_year == `cc`k'' & label == "`st`s''"
            local v = r(mean)
            if inlist(`s', 3, 4, 5, 6, 8) local cell = string(`v', "%9.0fc")
            if inlist(`s', 15, 16) local cell = string(`v', "%5.3f")
            if `s' == 17 local cell = string(`v', "%4.1f")
        }
        if `s' == 2 | `s' == 7 {
            quietly summarize stat_value if section == "check" & cohort_year == `cc`k'' & label == "rows in the model"
            local nr = r(mean)
            quietly summarize stat_value if section == "check" & cohort_year == `cc`k'' & label == "leaving events in the model"
            local ne = r(mean)
            quietly summarize stat_value if section == "check" & cohort_year == `cc`k'' & label == "coefficients estimated"
            local nk = r(mean)
            if `s' == 2 local cell = string(100 * `ne' / `nr', "%4.1f")
            if `s' == 7 local cell = string(`ne' / `nk', "%4.1f")
        }
        if inlist(`s', 9, 10, 11) local cell "Yes"
        if `s' == 12 local cell "No"
        if `s' == 13 local cell "None"
        if `s' == 14 local cell "By firm"
        if "`cell'" == "." local cell ""
        putpdf table A(`r', `=`k' + 1') = ("`cell'"), halign(right)
    }
    local cell ""
    if `s' == 1 {
        quietly summarize stat_value if section == "check" & strpos(label, "joint p") > 0
        if r(N) == 1 local cell = string(r(mean), "%5.3f")
    }
    if `s' == 4 {
        quietly summarize stat_value if section == "check" & label == "firms in the model, both files (clusters)"
        if r(N) == 1 local cell = string(r(mean), "%9.0fc") + " (both)"
    }
    if inlist(`s', 9, 10, 11) local cell "Yes"
    if `s' == 12 local cell "No"
    if `s' == 13 local cell "None"
    if `s' == 14 local cell "By firm"
    putpdf table A(`r', 4) = ("`cell'"), halign(right)
}
assert `r' == `nrA'
forvalues j = 1/4 {                                     // tight rows (Panel A fits one page)
    putpdf table A(., `j'), margin(top, 0pt) margin(bottom, 0pt)
}
foreach r of local trowsA {                              // a little air after each coefficient and its SE
    putpdf table A(`r', .), margin(bottom, 3pt)
}
putpdf table A(1, .), border(top, single) border(bottom, single)
putpdf table A(`rcoef', .), border(bottom, single)
putpdf table A(`nrA', .), border(bottom, single)
putpdf paragraph, font("`tfont'", 8) spacing(before, 6pt)
putpdf text ("Notes: One logit on both starting files. Each row is a firm of the starting file at one of the next three files, ")
putpdf text ("kept while the firm is still in the files; the outcome is 1 if the firm is missing from that file (it then drops out). ")
putpdf text ("Terms: the traits above, a dummy for each later file, sector and province dummies; every term is specific to its starting file, ")
putpdf text ("so columns (1) and (2) equal two separate logits (checked in the file), and column (3) uses firms that are in both files. ")
putpdf text ("Cells: average marginal effect (the change in the predicted chance of leaving at a file when the trait is switched from 0 to 1, ")
putpdf text ("averaged over that starting file's rows) in percentage points, standard error clustered by firm in parentheses. ")
putpdf text ("No significance stars. Reference groups: 20–99 workers; known non-exporters; firms without the trait. ")
putpdf text ("Firm links are fictional in the development data, so who stays, leaves or comes back means nothing here; read this table on the real BPS files.")

* Panel B: odds ratios
putpdf paragraph, spacing(before, 10pt) spacing(after, 4pt)
putpdf text ("Panel B. Odds ratios of leaving at a file (exp of the logit coefficient; 1 = no difference)"), italic
local nrB = 1 + `nterm' + `nhead'
putpdf table B = (`nrB', 4), border(all, nil) width(RW)
putpdf table B(1, 1) = ("Trait known by the starting file"), halign(left)
putpdf table B(1, 2) = ("(1) `cohort_covid' firms"), halign(right)
putpdf table B(1, 3) = ("(2) `cohort_normal' firms"), halign(right)
putpdf table B(1, 4) = (""), halign(right)
local r 1
forvalues t = 1/`nterm' {
    if "`hd`t''" != "" {
        local ++r
        putpdf table B(`r', 1) = ("`h`hd`t'''"), bold colspan(4)
    }
    local ++r
    putpdf table B(`r', 1) = ("`c`t''"), halign(left)
    local trowsB `trowsB' `r'
    forvalues k = 1/2 {
        quietly summarize odds_ratio if section == "effect" & row_id == `t' & cohort_year == `cc`k''
        local bb = r(mean)
        quietly summarize or_se if section == "effect" & row_id == `t' & cohort_year == `cc`k''
        local ss = r(mean)
        if `bb' < . {
            putpdf table B(`r', `=`k' + 1') = ("`=string(`bb', "%9.3f")'"), halign(right) linebreak
            putpdf table B(`r', `=`k' + 1') = ("(`=string(`ss', "%9.3f")')"), append
        }
        else putpdf table B(`r', `=`k' + 1') = ("not estimated"), halign(right)
    }
}
assert `r' == `nrB'
forvalues j = 1/4 {                                     // tight rows
    putpdf table B(., `j'), margin(top, 0pt) margin(bottom, 0pt)
}
foreach r of local trowsB {                              // a little air after each odds ratio and its SE
    putpdf table B(`r', .), margin(bottom, 3pt)
}
putpdf table B(1, .), border(top, single) border(bottom, single)
putpdf table B(`nrB', .), border(bottom, single)
putpdf paragraph, font("`tfont'", 8) spacing(before, 6pt)
putpdf text ("Notes: Same model as Panel A. Odds ratio above 1 = more likely to leave; standard error of the odds ratio (delta method) in parentheses. ")
putpdf text ("The logit coefficients (log odds ratios) and 95% intervals are in tables/`fname'.csv.")

* Check (not drawn, not in the CSV): value added per worker measured continuously
putpdf paragraph, spacing(before, 10pt) spacing(after, 4pt)
putpdf text ("Check (not on the chart). Value added per worker measured continuously instead of above or below its sector's median"), italic
matrix EW = (52, 24, 24)
putpdf table E = (3, 3), border(all, nil) width(EW)
putpdf table E(1, 1) = ("Value added per worker"), halign(left)
putpdf table E(1, 2) = ("(1) `cohort_covid' firms"), halign(right)
putpdf table E(1, 3) = ("(2) `cohort_normal' firms"), halign(right)
putpdf table E(2, 1) = ("Above its sector's median (the chart's row, Panel A)"), halign(left)
putpdf table E(3, 1) = ("One standard deviation further above its sector's median"), halign(left)
forvalues k = 1/2 {
    quietly summarize ame_pp if section == "effect" & row_id == 3 & cohort_year == `cc`k''
    local bb = r(mean)
    quietly summarize ame_se_pp if section == "effect" & row_id == 3 & cohort_year == `cc`k''
    local ss = r(mean)
    local zb = cz_b_`cc`k''
    local zs = cz_se_`cc`k''
    foreach rr in 2 3 {
        local v1 = cond(`rr' == 2, `bb', `zb')
        local v2 = cond(`rr' == 2, `ss', `zs')
        if `v1' < . {
            putpdf table E(`rr', `=`k' + 1') = ("`=string(`v1', "%9.2f")'"), halign(right) linebreak
            putpdf table E(`rr', `=`k' + 1') = ("(`=string(`v2', "%9.2f")')"), append
        }
        else putpdf table E(`rr', `=`k' + 1') = ("not estimated"), halign(right)
    }
}
forvalues j = 1/3 {                                     // tight rows
    putpdf table E(., `j'), margin(top, 0pt) margin(bottom, 3pt)
}
putpdf table E(1, .), border(top, single) border(bottom, single)
putpdf table E(3, .), border(bottom, single)
putpdf paragraph, font("`tfont'", 8) spacing(before, 6pt)
putpdf text ("Notes: Second row = the same model for each starting file with the yes/no marker replaced by the log distance of value added ")
putpdf text ("per worker from its sector's median, scaled by its standard deviation across the firms of the starting file (separate logit, ")
putpdf text ("standard errors clustered by firm). Average marginal effect in percentage points. Computed in this file (see the log); not drawn and not in the CSV.")

* Panel C: calibration, and Panel D: the leaving rate at each later file
putpdf pagebreak
putpdf paragraph, spacing(after, 4pt)
putpdf text ("Panel C. Calibration: predicted and actual share leaving, rows sorted into tenths of predicted risk (%)"), italic
local nrC = 2 + 10
matrix CW = (19, 13, 13, 14, 13, 13, 15)
putpdf table C = (`nrC', 7), border(all, nil) width(CW)
putpdf table C(1, 2) = ("(1) `cohort_covid' firms"), halign(center) colspan(3)
putpdf table C(1, 5) = ("(2) `cohort_normal' firms"), halign(center) colspan(3)
local c 0
foreach h in "Tenth of predicted risk" "Predicted" "Actual" "Rows" "Predicted" "Actual" "Rows" {
    local ++c
    putpdf table C(2, `c') = ("`h'"), halign(`=cond(`c' == 1, "left", "right")')
}
forvalues d = 1/10 {
    local r = `d' + 2
    putpdf table C(`r', 1) = ("`d'"), halign(left)
    forvalues k = 1/2 {
        quietly summarize pred_pct if section == "calibration" & row_id == `d' & cohort_year == `cc`k''
        local pp = r(mean)
        quietly summarize actual_pct if section == "calibration" & row_id == `d' & cohort_year == `cc`k''
        local aa = r(mean)
        quietly summarize rows_model if section == "calibration" & row_id == `d' & cohort_year == `cc`k''
        local nn = r(mean)
        local col = 2 + 3 * (`k' - 1)
        putpdf table C(`r', `col') = ("`=cond(`pp' < ., string(`pp', "%4.1f"), "")'"), halign(right)
        putpdf table C(`r', `=`col' + 1') = ("`=cond(`aa' < ., string(`aa', "%4.1f"), "")'"), halign(right)
        putpdf table C(`r', `=`col' + 2') = ("`=cond(`nn' < ., string(`nn', "%9.0fc"), "")'"), halign(right)
    }
}
forvalues j = 1/7 {                                     // tight rows
    putpdf table C(., `j'), margin(top, 0pt) margin(bottom, 0pt)
}
putpdf table C(1, .), border(top, single)
putpdf table C(2, .), border(bottom, single)
putpdf table C(`nrC', .), border(bottom, single)
putpdf paragraph, font("`tfont'", 8) spacing(before, 6pt)
putpdf text ("Notes: Predicted = average predicted chance of leaving in the tenth; actual = share that left. Close numbers = the model's ")
putpdf text ("chances match what happened. Tenths hold about equal numbers of rows. Hosmer–Lemeshow test (Panel A) on these tenths, ")
putpdf text ("8 degrees of freedom; it ignores clustering by firm.")

putpdf paragraph, spacing(before, 10pt) spacing(after, 4pt)
putpdf text ("Panel D. Leaving at each later file: firms still in the files before it, and how many are missing from it"), italic
matrix DW = (34, 18, 16, 16, 16)
putpdf table D = (9, 5), border(all, nil) width(DW)
local c 0
foreach h in "Starting file and later file" "Firms at risk (rows)" "Left" "Actual (%)" "Predicted (%)" {
    local ++c
    putpdf table D(1, `c') = ("`h'"), halign(`=cond(`c' == 1, "left", "right")')
}
local r 1
forvalues k = 1/2 {
    local ++r
    putpdf table D(`r', 1) = ("`=cond(`k' == 1, "`k1'", "`k2'")'"), bold colspan(5)
    forvalues p = 1/3 {
        local ++r
        quietly summarize rows_model if section == "leaving_rate" & row_id == `p' & cohort_year == `cc`k''
        local nn = r(mean)
        quietly summarize events_model if section == "leaving_rate" & row_id == `p' & cohort_year == `cc`k''
        local ee = r(mean)
        quietly summarize actual_pct if section == "leaving_rate" & row_id == `p' & cohort_year == `cc`k''
        local aa = r(mean)
        quietly summarize pred_pct if section == "leaving_rate" & row_id == `p' & cohort_year == `cc`k''
        local pp = r(mean)
        putpdf table D(`r', 1) = ("Missing from the `f`p'_`cc`k''' file"), halign(left)
        putpdf table D(`r', 2) = ("`=string(`nn', "%9.0fc")'"), halign(right)
        putpdf table D(`r', 3) = ("`=string(`ee', "%9.0fc")'"), halign(right)
        putpdf table D(`r', 4) = ("`=string(`aa', "%4.1f")'"), halign(right)
        putpdf table D(`r', 5) = ("`=cond(`pp' < ., string(`pp', "%4.1f"), "")'"), halign(right)
    }
}
forvalues j = 1/5 {                                     // tight rows
    putpdf table D(., `j'), margin(top, 0pt) margin(bottom, 0pt)
}
putpdf table D(1, .), border(top, single) border(bottom, single)
putpdf table D(9, .), border(bottom, single)
putpdf paragraph, font("`tfont'", 8) spacing(before, 6pt)
putpdf text ("Notes: Firms at risk = firms of the starting file still in every file before this one. The later-file dummies make the ")
putpdf text ("average predicted chance equal the actual share at each file. Leaving is not proof of closure: the files record no closures.")
putpdf paragraph, font("`tfont'", 8)
putpdf text ("`srcnote'")
putpdf paragraph, font("`tfont'", 8)
putpdf text ("`devnote'")
putpdf save "`rtab'", replace
display "table -> `rtab' (" 2 * `nterm' " effects, odds ratios, model checks, calibration)"

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/`fname'.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
