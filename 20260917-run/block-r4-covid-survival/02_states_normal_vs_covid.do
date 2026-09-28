/*==========================================================================
  R4-02  Did more firms stay in or leave the survey files after COVID than
         in normal years? The firms of every annual file are followed in the
         next three files; the 2019 firms (followed in 2020, 2021, 2022) are
         set against the firms of earlier files.
  Answers Bu Deasy R4: "Impact covid: Survival analysis?? ... Which firms
         survived" - Notes "Melihat firms yg bertahan, mati dan hidup selama
         shock covid" (bertahan = stayed, mati = left the files).
  Output : figures/02_states_normal_vs_covid.png (+ .pdf)
           tables/02_states_normal_vs_covid.csv (shares with 95% intervals;
           stayers by workers and by output; newcomers - table only)
           tables/02_states_normal_vs_covid_table.pdf (every plotted point)
  Uses the block "COVID COHORT AND STATES" from R4-01 unchanged (Step 2),
  run once per starting file.
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
log using "logs/02_states_normal_vs_covid.log", replace text
timer clear 1
timer on 1
display _newline "=== [R4-02] STARTING: stayed, left the files, came back - COVID years against normal years ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

*---------------------------------------------------------------------------
display "Step 1/6: load firm, year, workers and output; choose the starting files"
*---------------------------------------------------------------------------
* workers              = persons engaged (price-free: the size measure drawn)
* gross_output_nominal = output value in current prices (table only)
* gross_output_real    = output in constant prices; empty in the development
*                        file, used automatically when filled (see Step 2)
quietly describe using "$DATA", varlist
local allvars `r(varlist)'
local want firm_id year workers gross_output_nominal gross_output_real
local have : list want & allvars
use `have' using "$DATA", clear
isid firm_id year
assert !missing(firm_id, year)
tempfile panel
save `panel'

* Starting files: every annual file with two files before it (so "also in one
* of the two files before" can be told) and three files after it (the follow-up).
* Read from the data, so the list is right on the real files too.
quietly levelsof year, local(allfiles)
local nfiles : word count `allfiles'
local starts ""
forvalues i = 3/`=`nfiles' - 3' {
    local starts `starts' `: word `i' of `allfiles''
}
assert "`starts'" != ""
display "   starting files: `starts'"
* The first annual file after COVID reached Indonesia (March 2020): a starting
* file whose next file is this one is followed through the COVID years.
local covid_first 2020

*---------------------------------------------------------------------------
display "Step 2/6: for each starting file, the states of its firms (shared R4 block)"
*---------------------------------------------------------------------------
* Four states, left to right on the chart (they add up to the starting file's firms):
*   1 stayed        = in all three later files
*   2 absent, back  = missed the first and/or second later file, in the third again
*   3 left later    = in the first or second later file, not in the third
*   4 left at once  = in none of the three later files
* Two groups of firms: all firms of the starting file, and only the firms also
* in one of the two files before it (new_to_file == 0).
local sc1 "state_file == 1"
local sc2 "state_file == 2"
local sc3 "state_file == 3 & left_when == 2"
local sc4 "state_file == 3 & left_when == 1"
local sl1 "Stayed: in all three later files"
local sl2 "Absent, then back in the third later file"
local sl3 "Left later: gone by the third later file"
local sl4 "Left at once: in none of the three later files"
local gcA "in_cohort"
local gcB "in_cohort & new_to_file == 0"
tempname pf
tempfile res
postfile `pf' str1 section int cohort_year str20 later_files byte status_code str40 status_text ///
    str12 row_kind int item_order str60 item byte drawn double(firms base_firms pct ci_lo ci_hi) ///
    str24 outcome_basis double band_pct using `res', replace

foreach cohort_year of local starts {
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

* -- how this starting file is followed: COVID years, reaching 2020, across a missing file, or normal --
local gapyrs ""
forvalues yy = `=`cohort_year' + 1'/`=`f3' - 1' {
    if !inlist(`yy', `f1', `f2') local gapyrs `gapyrs' `yy'
}
if `f1' == `covid_first' {
    local st 1
    local sttxt "COVID years"
}
else if `f3' >= `covid_first' {
    local st 2
    local sttxt "Partly COVID years"
}
else if "`gapyrs'" != "" {
    local st 3
    local gw : word count `gapyrs'
    local sttxt = cond(`gw' == 1, "Skips `gapyrs' (no file)", "Skips missing files")
}
else {
    local st 4
    local sttxt "Normal years"
}
local lf_`cohort_year' "`f1', `f2', `f3'"
local st_`cohort_year' `st'
local sttxt_`cohort_year' "`sttxt'"
local gap_`cohort_year' "`gapyrs'"
* -- post the counts: states (drawn), stayers by workers and output, newcomers (table only) --
foreach g in A B {
    quietly count if `gc`g''
    local N = r(N)
    forvalues s = 1/4 {
        quietly count if `gc`g'' & `sc`s''
        local k = r(N)
        local lo .
        local hi .
        if `N' > 0 {
            quietly cii proportions `N' `k', wilson
            local lo = 100 * r(lb)
            local hi = 100 * r(ub)
        }
        post `pf' ("`g'") (`cohort_year') ("`f1' `f2' `f3'") (`st') ("`sttxt'") ("state") (`s') ("`sl`s''") (1) ///
            (`k') (`N') (cond(`N' > 0, 100 * `k' / `N', .)) (`lo') (`hi') ("`outbasis'") (`band_pct')
    }
    * stayers split by workers and by output, third later file against the starting file
    quietly count if `gc`g'' & state_file == 1
    local NS = r(N)
    foreach m in wk out {
        local mw = cond("`m'" == "wk", "workers", "output")
        local j 0
        foreach z in 3 2 1 . {
            local ++j
            local zl = cond("`z'" == "3", "up more than", cond("`z'" == "2", "about the same, within", ///
                cond("`z'" == "1", "down more than", "not comparable")))
            local zt = cond("`z'" == ".", "Stayed, `mw' not comparable", "Stayed, `mw' `zl' `band_pct'%")
            if "`z'" == "." quietly count if `gc`g'' & state_file == 1 & missing(size_`m')
            else            quietly count if `gc`g'' & state_file == 1 & size_`m' == `z'
            local k = r(N)
            post `pf' ("`g'") (`cohort_year') ("`f1' `f2' `f3'") (`st') ("`sttxt'") ("stayers_`m'") (`j') ("`zt'") (0) ///
                (`k') (`NS') (cond(`NS' > 0, 100 * `k' / `NS', .)) (.) (.) ("`outbasis'") (`band_pct')
        }
    }
}
* newcomers: firms not in the starting file, first seen in each later file (percent of the starting file's firms)
quietly count if in_cohort
local N = r(N)
local j 0
foreach f in `f1' `f2' `f3' {
    local ++j
    quietly count if !in_cohort & new_in_file == `f'
    post `pf' ("A") (`cohort_year') ("`f1' `f2' `f3'") (`st') ("`sttxt'") ("newcomers") (`j') ("Not in the starting file, first in the `f' file") (0) ///
        (r(N)) (`N') (100 * r(N) / `N') (.) (.) ("`outbasis'") (`band_pct')
}
}
postclose `pf'

*---------------------------------------------------------------------------
display "Step 3/6: write the table (numbers before drawing)"
*---------------------------------------------------------------------------
use `res', clear
* Reconciliation (structural): the four states add up to the starting file's firms.
bysort section cohort_year: egen double c_sum = total(firms) if row_kind == "state"
assert c_sum == base_firms if row_kind == "state"
drop c_sum
foreach m in wk out {
    bysort section cohort_year: egen double c_sum = total(firms) if row_kind == "stayers_`m'"
    assert c_sum == base_firms if row_kind == "stayers_`m'"
    drop c_sum
}
* Gap to the COVID-years starting file: its share minus this share, in percentage points (drawn shares).
gen double c_cov = pct if status_code == 1
bysort section row_kind item_order: egen double covid_pct = max(c_cov)
gen double covid_minus_this_pts = covid_pct - pct if drawn == 1
drop c_cov covid_pct
gen byte section_order = cond(section == "A", 1, 2)
gen str64 section_name = cond(section == "A", "All firms in the starting file", ///
    "Only firms also in one of the two files before")
gen byte kind_order = cond(row_kind == "state", 1, cond(row_kind == "stayers_wk", 2, cond(row_kind == "stayers_out", 3, 4)))
sort section_order kind_order cohort_year item_order
format firms base_firms %9.0f
format pct ci_lo ci_hi covid_minus_this_pts %6.1f
order section section_name cohort_year later_files status_code status_text row_kind item_order item drawn ///
    firms base_firms pct ci_lo ci_hi covid_minus_this_pts outcome_basis band_pct
export delimited section-band_pct using "tables/02_states_normal_vs_covid.csv", datafmt replace
list section cohort_year status_text item firms base_firms pct ci_lo ci_hi covid_minus_this_pts ///
    if drawn, noobs sepby(section cohort_year) abbreviate(24)
list section cohort_year item firms base_firms pct if !drawn, noobs sepby(section cohort_year) abbreviate(24)

*---------------------------------------------------------------------------
display "Step 4/6: numbers for the notes (read from the data, never typed)"
*---------------------------------------------------------------------------
quietly summarize firms if drawn & section == "A" & item_order == 2
local n_back = r(sum)
local outbasis = outcome_basis[1]
local covidfile ""
local reach ""
local across ""
foreach c of local starts {
    if `st_`c'' == 1 local covidfile `c'
    if `st_`c'' == 2 local reach `reach' `c'
    if `st_`c'' == 3 local across `across' `c'
}
* word lists for the notes, e.g. "2013, 2014 and 2015"
foreach w in reach across {
    local n`w' : word count ``w''
    local t`w' ""
    forvalues i = 1/`n`w'' {
        local x : word `i' of ``w''
        if `i' == 1 local t`w' "`x'"
        else if `i' == `n`w'' local t`w' "`t`w'' and `x'"
        else local t`w' "`t`w'', `x'"
    }
}
* Reading rule for the notes: the COVID-years stayed share against the range of the
* starting files followed only before COVID reached Indonesia (status 3 and 4).
foreach g in A B {
    quietly summarize pct if drawn & section == "`g'" & item_order == 1 & status_code >= 3
    local rmin`g' = strtrim(string(r(min), "%5.1f"))
    local rmax`g' = strtrim(string(r(max), "%5.1f"))
    local nnorm`g' = r(N)
    quietly summarize pct if drawn & section == "`g'" & item_order == 1 & status_code == 1
    local rcov`g' = strtrim(string(r(mean), "%5.1f"))
    local rpos`g' = cond(r(mean) < real("`rmin`g''"), "below", cond(r(mean) > real("`rmax`g''"), "above", "inside"))
}
local reading ""
if `nnormA' > 0 & `nnormB' > 0 & "`rcovA'" != "." & "`rcovB'" != "." {
    local reading "Reading: the `covidfile' firms' stayed share (dashed line, `rcovA'%) is `rposA' the range of the files followed only before `covid_first' (`rminA'% to `rmaxA'%; lower group: `rcovB'%, `rposB' `rminB'% to `rmaxB'%); with the fictional firm links of the development data this says nothing about COVID either way."
}
local gapall ""
foreach c of local across {
    local gapall : list gapall | gap_`c'
}
local gapall : list sort gapall
local gapt = subinstr("`gapall'", " ", ", ", .)

*---------------------------------------------------------------------------
display "Step 5/6: 100% bars, one per starting file, two groups of firms"
*---------------------------------------------------------------------------
keep if drawn
* y positions: a bold heading per group, one row per starting file (oldest on top),
* and an empty row for every year with no annual file between starting files.
gen double y = .
local pos 0
local ylab ""
local headtext ""
local gaprows ""
local nstarts : word count `starts'
foreach g in A B {
    if "`g'" == "B" local pos = `pos' + 0.8
    local ++pos
    local head = cond("`g'" == "A", "All firms in the starting file", "Only firms also in one of the two files before")
    local headtext `"`headtext' text(`=`pos' - 0.15' 0 "{bf:`head'}", placement(e) size(vsmall))"'   // heading over the bars
    local first_`g' = `pos' + 1
    forvalues i = 1/`nstarts' {
        local c : word `i' of `starts'
        if `i' > 1 {
            local cprev : word `=`i' - 1' of `starts'
            forvalues gy = `=`cprev' + 1'/`=`c' - 1' {
                local ++pos
                local ylab `"`ylab' `pos' "`gy': no annual file""'
                local gaprows `gaprows' `g'`gy'
            }
        }
        local ++pos
        quietly replace y = `pos' if section == "`g'" & cohort_year == `c'
        local rl "`c' file, then `lf_`c''"
        if `st_`c'' == 1 local rl "{bf:`rl'}"
        local ylab `"`ylab' `pos' "`rl'""'
    }
    local last_`g' = `pos'
}
local ymax = `pos' + 0.6
assert !missing(y)
* pieces left to right: stayed, absent then back, left later, left at once
sort section cohort_year item_order
by section cohort_year: gen double x1 = sum(pct)
gen double x0 = x1 - pct
gen double mid = (x0 + x1) / 2
gen double ylab_y = y - 0.10                                  // text sits low in Stata: centre it in the bar
gen str8 in_lbl = strtrim(string(pct, "%5.1f")) if pct >= 7   // label a piece only when it is wide enough
* status text right of each bar
gen double st_x = 101.5
gen str40 st_lbl = status_text if item_order == 1
* dashed line: the COVID-years stayed share, over each group's rows
quietly summarize pct if status_code == 1 & section == "A" & item_order == 1
local refA = r(mean)
quietly summarize pct if status_code == 1 & section == "B" & item_order == 1
local refB = r(mean)
local yA0 = `first_A' - 0.45
local yA1 = `last_A' + 0.5
local yB0 = `first_B' - 0.45
local yB1 = `last_B' + 0.5
local charttitle "Figure R4-02. Stayed in the files or left them: the `covidfile' firms against earlier years"

* Notes: one text, wrapped into lines of at most 108 characters (PDF text runs wider than the PNG)
local ntext "Notes: Each bar = the firms of one annual file (the starting file), followed in its next three annual files. Absent, then back = missed the first or second later file, in the third again (`n_back' firms here); left later = in the first or second, not in the third. Lower group: only firms also in one of the two files before (firms new to the files leave more often). Starting files `tacross' are followed across the missing `gapt' file. `reading' Shares only, not the effect of COVID. Left the files is not proof of closure: a firm may have closed, fallen out of the survey or stopped answering. Firm links are fictional in the development data, so who stays, leaves or comes back means nothing here; read these results on the real BPS files."
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

twoway (rbar x0 x1 y if item_order == 1, horizontal barwidth(0.9) fcolor(gs4) lcolor(gs4) lwidth(vthin)) ///
    (rbar x0 x1 y if item_order == 2, horizontal barwidth(0.9) fcolor(gs9) lcolor(gs9) lwidth(vthin)) ///
    (rbar x0 x1 y if item_order == 3, horizontal barwidth(0.9) fcolor(gs13) lcolor(gs10) lwidth(vthin)) ///
    (rbar x0 x1 y if item_order == 4, horizontal barwidth(0.9) fcolor(white) lcolor(gs4) lwidth(thin)) ///
    (scatteri `yA0' `refA' `yA1' `refA', recast(line) lpattern(shortdash) lcolor(black) lwidth(medthin)) ///
    (scatteri `yB0' `refB' `yB1' `refB', recast(line) lpattern(shortdash) lcolor(black) lwidth(medthin)) ///
    (scatter ylab_y mid if item_order == 1 & in_lbl != "", msymbol(none) mlabel(in_lbl) mlabposition(0) mlabcolor(white) mlabsize(vsmall)) ///
    (scatter ylab_y mid if item_order != 1 & in_lbl != "", msymbol(none) mlabel(in_lbl) mlabposition(0) mlabcolor(black) mlabsize(vsmall)) ///
    (scatter ylab_y st_x if st_lbl != "", msymbol(none) mlabel(st_lbl) mlabposition(3) mlabgap(0) mlabcolor(black) mlabsize(vsmall)), ///
    `headtext' ///
    yscale(reverse noline range(0.2 `ymax')) ylabel(`ylab', angle(0) noticks nogrid labsize(vsmall) labgap(1)) ytitle("") ///
    xscale(range(0 130) noline) xlabel(0(20)100, labsize(vsmall) tlcolor(gs10) nogrid) ///
    xtitle("Percent of the firms in the starting file", size(vsmall)) ///
    legend(order(1 "Stayed (in all three later files)" 2 "Absent, then back" 3 "Left later" ///
                 4 "Left at once (in none of the three)" 5 "Stayed share of the `covidfile' firms") ///
           cols(2) position(6) region(lstyle(none)) size(vsmall) symysize(2.2) symxsize(4) keygap(1) rowgap(0.3) colgap(6)) ///
    title("`charttitle'", size(small) position(11) justification(left) span) ///
    note(`notelines' "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6)) ///
    graphregion(color(white) lcolor(white) margin(r+2)) plotregion(style(none) margin(t=1 b=1)) ///
    xsize(7.5) ysize(8)

graph export "figures/02_states_normal_vs_covid.png", width(2250) replace
graph export "figures/02_states_normal_vs_covid.pdf", replace

*---------------------------------------------------------------------------
display "Step 6/6: companion table - every plotted piece, one row each (putpdf, no add-on)"
*---------------------------------------------------------------------------
* Read back the CSV just written, so the table shows exactly the charted numbers.
import delimited using "tables/02_states_normal_vs_covid.csv", clear varnames(1) encoding("utf-8") ///
    stringcols(1 2 4 6 7 9 17)
keep if drawn == 1
local nrow = _N
gen byte sorder = cond(section == "A", 1, 2)
sort sorder cohort_year item_order
local ngap : word count `gaprows'
local ntab = `nrow' + `ngap' + 3                           // header + two group headings + gap rows
putpdf clear
putpdf begin, font("Times New Roman", 9) margin(all, 0.6in) landscape
putpdf paragraph, spacing(after, 6pt)
putpdf text ("Table R4-02. `=substr("`charttitle'", strpos("`charttitle'", ".") + 2, .)': every plotted point"), bold
matrix colw = (19, 28, 7, 7, 7, 7, 8, 17)                  // column widths, % of the page width
putpdf table T = (`ntab', 8), border(all, nil) width(colw)
local h1 "Starting file (row on the chart)"
local h2 "Piece of the bar"
local h3 "Percent"
local h4 "95% low"
local h5 "95% high"
local h6 "Firms"
local h7 "Firms in bar"
local h8 "Status"
forvalues c = 1/8 {
    local al = cond(inlist(`c', 1, 2, 8), "left", "right")
    putpdf table T(1, `c') = ("`h`c''"), bold halign(`al') border(top, single) border(bottom, single)
    if `c' == 8 putpdf table T(1, 8), margin(left, 8pt)
}
local r 1
local prevs ""
local prevc ""
forvalues i = 1/`nrow' {
    local s = section[`i']
    local c = cohort_year[`i']
    if "`s'" != "`prevs'" {
        local ++r
        putpdf table T(`r', 1) = ("`=section_name[`i']'"), bold colspan(8)
        local prevs "`s'"
        local prevc ""
    }
    * a row for every year with no annual file, where the chart leaves an empty row
    if "`prevc'" != "" {
        forvalues gy = `=`prevc' + 1'/`=`c' - 1' {
            local ++r
            putpdf table T(`r', 1) = ("`gy': no annual file")
            putpdf table T(`r', 8) = ("not drawn: no file"), margin(left, 8pt)
        }
    }
    local prevc `c'
    local ++r
    local rl = cond(item_order[`i'] == 1, "`c' file, then `lf_`c''", "")
    putpdf table T(`r', 1) = ("`rl'")
    putpdf table T(`r', 2) = ("`=item[`i']'")
    putpdf table T(`r', 3) = ("`=strtrim(string(pct[`i'], "%5.1f"))'"), halign(right)
    putpdf table T(`r', 4) = ("`=strtrim(string(ci_lo[`i'], "%5.1f"))'"), halign(right)
    putpdf table T(`r', 5) = ("`=strtrim(string(ci_hi[`i'], "%5.1f"))'"), halign(right)
    putpdf table T(`r', 6) = ("`=strtrim(string(firms[`i'], "%12.0fc"))'"), halign(right)
    putpdf table T(`r', 7) = ("`=strtrim(string(base_firms[`i'], "%12.0fc"))'"), halign(right)
    local stt = cond(pct[`i'] == 0, "drawn (zero width)", cond(pct[`i'] < 7, "drawn (no label: narrow)", "drawn"))
    if item_order[`i'] == 1 local stt "`stt'; `=status_text[`i']'"
    putpdf table T(`r', 8) = ("`stt'"), margin(left, 8pt)
}
assert `r' == `ntab'
forvalues c = 1/8 {
    putpdf table T(`ntab', `c'), border(bottom, single)
}
putpdf paragraph, spacing(before, 6pt)
putpdf text ("95% interval: Wilson interval for a share, treating the firms of the starting file as a sample; the starting files share many firms, so intervals of different bars are not independent. Firms = firms in this piece; firms in the bar = all firms of the starting file in that group. Status after the first piece of each bar: how the starting file is followed. The dashed line on the chart is the Stayed percent of the `covidfile' file in each group."), font("Times New Roman", 9)
putpdf paragraph
putpdf text ("`ntext'"), font("Times New Roman", 9)
putpdf paragraph
putpdf text ("`srcnote'"), font("Times New Roman", 9)
putpdf paragraph
putpdf text ("`devnote'"), font("Times New Roman", 9)
putpdf save "tables/02_states_normal_vs_covid_table.pdf", replace
display "table -> tables/02_states_normal_vs_covid_table.pdf (`nrow' plotted pieces, `ngap' rows for years with no file)"

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/02_states_normal_vs_covid.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
