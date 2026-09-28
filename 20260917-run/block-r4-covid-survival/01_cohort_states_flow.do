/*==========================================================================
  R4-01  What happened to the firms in the last file before COVID (2019)?
         Which were still in the 2020, 2021 and 2022 files, which left the
         files, which came back, and how many firms came in after 2019?
  Answers Bu Deasy R4: "Impact covid: Survival analysis?? ... Which firms
         survived" - Strategy "multinomial outcomes: exit, temporary
         disappearance, survive-shrink, survive-grow" - Notes "Melihat firms
         yg bertahan, mati dan hidup selama shock covid".
  Output : figures/01_cohort_states_flow.png (+ .pdf)
           tables/01_cohort_states_flow.csv (flow table that adds up to the
           2019 firms; presence patterns and the output version in the table)
  This file defines the cohort and the states that every later R4 file and
  the R10 files copy (block "COVID COHORT AND STATES" in Step 2).
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
log using "logs/01_cohort_states_flow.log", replace text
timer clear 1
timer on 1
display _newline "=== [R4-01] STARTING: the 2019 firms - stayed, left the files, came back ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

*---------------------------------------------------------------------------
display "Step 1/7: load firm, year, workers and output"
*---------------------------------------------------------------------------
* workers              = persons engaged (price-free: the main size measure)
* gross_output_nominal = output value in current prices
* gross_output_real    = output in constant prices; empty in the development
*                        file, used automatically when filled (see Step 2)
quietly describe using "$DATA", varlist
local allvars `r(varlist)'
local want firm_id year workers gross_output_nominal gross_output_real
local have : list want & allvars
use `have' using "$DATA", clear
isid firm_id year
assert !missing(firm_id, year)

* The cohort file: the last annual file before COVID reached Indonesia (March 2020).
local cohort_year 2019
* Neutral band for stayers: "about the same" = within this many percent of the 2019 level.
local band_pct 10

display "Step 2/7: the cohort file, its firms' states, and the firms that came in"
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

*---------------------------------------------------------------------------
display "Step 3/7: the flow table - every row is a count of firms"
*---------------------------------------------------------------------------
* Each row: a label and the rule that picks its firms. drawn = 1 rows go into the figure.
* Cohort rows are split into firms also in the p2/p1 files ("incumbents") and
* firms new in the cohort file; newcomer rows into first-time firms and firms
* seen in a file before the cohort file.
tempname pf
tempfile flow
postfile `pf' int row_order str14 section str60 row_label byte drawn ///
    double firms incumbents new_in_cohort_file first_time_in_files seen_before_cohort_file ///
    using `flow', replace
* the eight presence patterns (CSV only): 1 = in that later file, 0 = not
local prows ""
foreach p in 111 110 101 100 011 010 001 000 {
    local c1 = substr("`p'", 1, 1)
    local c2 = substr("`p'", 2, 1)
    local c3 = substr("`p'", 3, 1)
    local prows `"`prows' "P|0|Pattern `p' (1 = in the file: `f1' `f2' `f3')|in_cohort & seen_f1 == `c1' & seen_f2 == `c2' & seen_f3 == `c3'""'
}
local r 0
foreach row in ///
    "A|1|In the `cohort_year' file|in_cohort" ///
    "A|1|In the `f1' file|in_cohort & seen_f1 == 1" ///
    "A|1|In the `f2' file|in_cohort & seen_f2 == 1" ///
    "A|1|In the `f3' file|in_cohort & seen_f3 == 1" ///
    "B|1|Stayed: in all three later files|state_file == 1" ///
    "B|1|Stayed, workers up more than `band_pct'%|state_file == 1 & size_wk == 3" ///
    "B|1|Stayed, workers about the same (±`band_pct'%)|state_file == 1 & size_wk == 2" ///
    "B|1|Stayed, workers down more than `band_pct'%|state_file == 1 & size_wk == 1" ///
    "B|1|Stayed, workers not comparable|state_file == 1 & missing(size_wk)" ///
    "B|1|Absent, then back in the `f3' file|state_file == 2" ///
    "B|1|Left: in none of the three later files|state_file == 3 & left_when == 1" ///
    "B|1|Left later: gone by the `f3' file|state_file == 3 & left_when == 2" ///
    "C|1|First in the `f1' file|!in_cohort & new_in_file == `f1'" ///
    "C|1|First in the `f2' file|!in_cohort & new_in_file == `f2'" ///
    "C|1|First in the `f3' file|!in_cohort & new_in_file == `f3'" ///
    `prows' ///
    "O|0|Stayed, output up more than `band_pct'%|state_file == 1 & size_out == 3" ///
    "O|0|Stayed, output about the same (±`band_pct'%)|state_file == 1 & size_out == 2" ///
    "O|0|Stayed, output down more than `band_pct'%|state_file == 1 & size_out == 1" ///
    "O|0|Stayed, output not comparable|state_file == 1 & missing(size_out)" {
    local ++r
    tokenize `"`row'"', parse("|")
    local sec "`1'"
    local drw = `3'
    local lab "`5'"
    local cond `"`7'"'
    quietly count if `cond'
    local n = r(N)
    if "`sec'" != "C" {
        quietly count if (`cond') & new_to_file == 0
        local a = r(N)
        quietly count if (`cond') & new_to_file == 1
        local b = r(N)
        post `pf' (`r') ("`sec'") ("`lab'") (`drw') (`n') (`a') (`b') (.) (.)
    }
    else {
        quietly count if (`cond') & seen_earlier == 0
        local a = r(N)
        quietly count if (`cond') & seen_earlier == 1
        local b = r(N)
        post `pf' (`r') ("`sec'") ("`lab'") (`drw') (`n') (.) (.) (`a') (`b')
    }
}
postclose `pf'

* Numbers the notes and checks need (read from the data, never typed).
quietly count if in_cohort
local n_coh = r(N)
quietly count if in_cohort & missing(new_to_file)
local n_nonew = r(N)
quietly count if state_file == 2
local n_back = r(N)

use `flow', clear
gen str12 section_name = cond(section == "A", "file_by_file", cond(section == "B", "final_state", ///
    cond(section == "C", "newcomers", cond(section == "P", "pattern", "output"))))
gen int  cohort_year      = `cohort_year'
gen str23 later_files     = "`f1' `f2' `f3'"
gen str9  earlier_files   = strtrim("`p2' `p1'")
gen str80 outcome_basis   = "`outbasis'"
gen double band_pct       = `band_pct'
gen double pct_of_cohort  = 100 * firms / `n_coh' if inlist(section, "A", "B", "P", "O")
quietly summarize firms if row_label == "Stayed: in all three later files"
local n_stay = r(sum)
gen double pct_of_stayed  = 100 * firms / `n_stay' if inlist(section, "O") | (section == "B" & strpos(row_label, "Stayed,") == 1)
foreach v in incumbents new_in_cohort_file {
    quietly summarize `v' if row_order == 1
    gen double pct_of_`v' = 100 * `v' / r(sum) if inlist(section, "A", "B", "P", "O")
}

* Reconciliation: every split adds up to the cohort (structural, holds on any data).
foreach v in firms incumbents new_in_cohort_file {
    quietly summarize `v' if row_order == 1
    local tot = r(sum)
    quietly summarize `v' if inlist(row_order, 5, 10, 11, 12)          // stayed + back + left + left later
    assert r(sum) == `tot'
    quietly summarize `v' if section == "P"                           // the eight presence patterns
    assert r(sum) == `tot'
    quietly summarize `v' if inrange(row_order, 6, 9)                 // stayers split by workers
    local s1 = r(sum)
    quietly summarize `v' if section == "O"                           // stayers split by output
    local s2 = r(sum)
    quietly summarize `v' if row_order == 5
    assert `s1' == r(sum) & `s2' == r(sum)
}
assert incumbents + new_in_cohort_file == firms if section != "C" & `n_nonew' == 0
assert first_time_in_files + seen_before_cohort_file == firms if section == "C"

*---------------------------------------------------------------------------
display "Step 4/7: write the table (numbers before drawing)"
*---------------------------------------------------------------------------
format firms incumbents new_in_cohort_file first_time_in_files seen_before_cohort_file %9.0f
format pct_* %6.1f
order cohort_year later_files earlier_files row_order section_name row_label drawn firms incumbents ///
    new_in_cohort_file first_time_in_files seen_before_cohort_file pct_of_cohort pct_of_stayed ///
    pct_of_incumbents pct_of_new_in_cohort_file outcome_basis band_pct
export delimited cohort_year-band_pct using "tables/01_cohort_states_flow.csv", datafmt replace
list row_order row_label firms incumbents new_in_cohort_file first_time_in_files ///
    seen_before_cohort_file, noobs sep(0) abbreviate(24)

*---------------------------------------------------------------------------
display "Step 5/7: numbers for the notes (read from the table, never typed)"
*---------------------------------------------------------------------------
local outword = cond("`outbasis'" == "gross_output_real", "constant prices", "current prices")
local incword "in the `p2' or `p1' file"
if "`p2'" == "" local incword "in the `p1' file"

*---------------------------------------------------------------------------
display "Step 6/7: horizontal bars, one row per count"
*---------------------------------------------------------------------------
keep if drawn
drop if row_label == "Stayed, workers not comparable" & firms == 0   // drawn only when it occurs
sort row_order
* section headings (also used in the companion table)
local headA "The `cohort_year' firms, file by file"
local headB "Where the `cohort_year' firms were by the `f3' file"
local headC "Firms in later files that were not in the `cohort_year' file"
local charttitle "Figure R4-01. The firms of the `cohort_year' file: how many stayed in the `f1'–`f3' files, left, or came back"
* y positions: a bold heading per section, one blank row between sections
gen double y = .
local pos 0
local ylab ""
local prevsec ""
forvalues i = 1/`=_N' {
    local sec = section[`i']
    if "`sec'" != "`prevsec'" {
        if "`prevsec'" != "" local pos = `pos' + 0.6
        local ++pos
        local head "`head`sec''"
        local ylab `"`ylab' `pos' "{bf:`head'}""'
        local prevsec "`sec'"
    }
    local ++pos
    replace y = `pos' in `i'
    local lab = row_label[`i']
    local ylab `"`ylab' `pos' "`lab'""'
}
local ymax = `pos' + 0.6
* bar pieces: dark = incumbents / light gray = first time in any file (left piece);
* white = new in the cohort file / pale = seen in a file before the cohort file (right piece)
gen double zero = 0
gen double cut  = cond(section == "C", first_time_in_files, incumbents)
* count labels: total at the bar end; piece counts inside when the piece is wide enough
quietly summarize firms
local xmax = r(max)
local step = 10^floor(log10(`xmax'))                       // axis step that grows with the counts
if `xmax'/`step' < 2       local step = `step'/5
else if `xmax'/`step' < 5  local step = `step'/2
local xtop = `step' * ceil(1.12*`xmax'/`step')           // room for the count labels
gen str24 end_lbl = strtrim(string(firms, "%12.0fc"))
replace end_lbl = end_lbl + " (" + strtrim(string(pct_of_cohort, "%5.1f")) + "%)" if section != "C" & row_order != 1
gen double in1_x = cut / 2
gen double in2_x = cut + (firms - cut) / 2
gen double ylab_y = y - 0.06                                  // text sits a hair low in Stata: centre it in the bar
gen str12 in1_lbl = strtrim(string(cut, "%12.0fc"))           if cut >= 0.07 * `xtop'
replace in1_lbl = "" if section == "C" & firms == cut          // one piece only: the end label says it
gen str12 in2_lbl = strtrim(string(firms - cut, "%12.0fc"))   if firms - cut >= 0.07 * `xtop'

* Notes: one text, wrapped into lines of at most 138 characters (PDF text runs wider than the PNG)
local ntext "Notes: Firm links are fictional in the development data, so who stays, leaves or comes back means nothing here; read this chart on the real BPS files. Every firm in the `cohort_year' file, looked up in the next three files (`f1', `f2', `f3'); percent = share of the `cohort_year' firms. Stayed = in all three; workers in `f3' against `cohort_year', about the same = within `band_pct'% either way (output, `outword', in the companion table). Absent, then back = missed `f1' or `f2' but in `f3' again (`n_back' firms here); the `f3' row = Stayed plus these firms. Left is not proof of closure: the files record no closures, so a firm may have closed, fallen out of the survey, stopped answering, or may return after `f3'. Counts only, not the effect of COVID (Figure R4-02 shows normal years)."
local notelines ""
local line ""
foreach w of local ntext {
    if ustrlen("`line' `w'") > 138 & "`line'" != "" {
        local notelines `"`notelines' "`line'""'
        local line "`w'"
    }
    else local line = strtrim("`line' `w'")
}
local notelines `"`notelines' "`line'""'
display `"   note lines: `notelines'"'

twoway (rbar zero cut y if section != "C", horizontal barwidth(0.78) fcolor(gs4) lcolor(gs4) lwidth(vthin)) ///
    (rbar cut firms y if section != "C", horizontal barwidth(0.78) fcolor(white) lcolor(gs4) lwidth(thin)) ///
    (rbar zero cut y if section == "C", horizontal barwidth(0.78) fcolor(gs11) lcolor(gs11) lwidth(vthin)) ///
    (rbar cut firms y if section == "C" & firms > cut, horizontal barwidth(0.78) fcolor(white) lcolor(gs6) lwidth(thin) lpattern(shortdash)) ///
    (scatter y firms, msymbol(none) mlabel(end_lbl) mlabposition(3) mlabgap(0.8) mlabcolor(black) mlabsize(vsmall)) ///
    (scatter ylab_y in1_x if section != "C" & in1_lbl != "", msymbol(none) mlabel(in1_lbl) mlabposition(0) mlabcolor(white) mlabsize(vsmall)) ///
    (scatter ylab_y in1_x if section == "C" & in1_lbl != "", msymbol(none) mlabel(in1_lbl) mlabposition(0) mlabcolor(black) mlabsize(vsmall)) ///
    (scatter ylab_y in2_x if in2_lbl != "", msymbol(none) mlabel(in2_lbl) mlabposition(0) mlabcolor(black) mlabsize(vsmall)), ///
    yscale(reverse noline range(0.4 `ymax')) ylabel(`ylab', angle(0) noticks nogrid labsize(vsmall) labgap(1)) ytitle("") ///
    xscale(range(0 `xtop') lcolor(gs10)) xlabel(0(`step')`xtop', format(%9.0fc) labsize(vsmall) tlcolor(gs10) nogrid) ///
    xtitle("Number of firms", size(vsmall)) ///
    legend(order(1 "Also `incword'" 2 "Not `incword'" ///
                 3 "Not in `cohort_year': new to the files" 4 "Not in `cohort_year': seen before `cohort_year'") ///
           rows(2) position(6) region(lstyle(none)) size(vsmall) symysize(2.2) symxsize(4) keygap(1) rowgap(0.3) colgap(8)) ///
    title("`charttitle'", ///
          size(small) position(11) justification(left) span) ///
    note(`notelines' "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6)) ///
    graphregion(color(white) lcolor(white) margin(r+2)) plotregion(style(none) margin(t=1 b=1)) ///
    xsize(8) ysize(6.5)

graph export "figures/01_cohort_states_flow.png", width(2400) replace
graph export "figures/01_cohort_states_flow.pdf", replace

*---------------------------------------------------------------------------
display "Step 7/7: companion table - every plotted bar, one row each (putpdf, no add-on)"
*---------------------------------------------------------------------------
* Read back the CSV just written, so the table shows exactly the charted numbers.
import delimited using "tables/01_cohort_states_flow.csv", clear varnames(1) encoding("utf-8") stringcols(6)
keep if drawn == 1 | section_name == "output"          // drawn rows + the output split the notes point to
sort row_order
gen str40 status = "drawn"
replace status = "not drawn: table only" if section_name == "output"
replace status = "not drawn: no firms" if row_label == "Stayed, workers not comparable" & firms == 0
gen str12 c_firms = strtrim(string(firms, "%12.0fc"))
gen str8  c_pct   = cond(missing(pct_of_cohort), "", strtrim(string(pct_of_cohort, "%5.1f")))
gen double left_piece  = cond(section_name == "newcomers", first_time_in_files, incumbents)
gen double right_piece = cond(section_name == "newcomers", seen_before_cohort_file, new_in_cohort_file)
gen str12 c_left  = strtrim(string(left_piece, "%12.0fc"))
gen str12 c_right = strtrim(string(right_piece, "%12.0fc"))
local nrow = _N
quietly tab section_name
local ntab = `nrow' + 1 + r(r)                            // header + one heading per section
local headD "Stayed, split by output (`outword'): not drawn"
putpdf clear
putpdf begin, font("Times New Roman", 10) margin(all, 0.6in)
putpdf paragraph, spacing(after, 6pt)
putpdf text ("Table R4-01. `=substr("`charttitle'", strpos("`charttitle'", ".") + 2, .)' — every plotted point and the output split"), bold
matrix colw = (34, 9, 12, 11, 12, 22)                  // column widths, % of the page width
putpdf table T = (`ntab', 6), border(all, nil) width(colw)
local h1 "Row on the chart"
local h2 "Firms"
local h3 "% of the `cohort_year' firms"
local h4 "Dark or gray piece"
local h5 "White or dashed piece"
local h6 "Status"
forvalues c = 1/6 {
    local al = cond(inlist(`c', 1, 6), "left", "right")
    putpdf table T(1, `c') = ("`h`c''"), bold halign(`al') border(top, single) border(bottom, single) margin(left, 6pt)
}
local r 1
local prev ""
forvalues i = 1/`nrow' {
    local sec = section_name[`i']
    local key = cond("`sec'" == "file_by_file", "A", cond("`sec'" == "final_state", "B", cond("`sec'" == "newcomers", "C", "D")))
    if "`key'" != "`prev'" {
        local ++r
        putpdf table T(`r', 1) = ("`head`key''"), bold colspan(6)
        local prev "`key'"
    }
    local ++r
    putpdf table T(`r', 1) = ("`=row_label[`i']'")
    putpdf table T(`r', 2) = ("`=c_firms[`i']'"), halign(right)
    putpdf table T(`r', 3) = ("`=c_pct[`i']'"), halign(right)
    putpdf table T(`r', 4) = ("`=c_left[`i']'"), halign(right)
    putpdf table T(`r', 5) = ("`=c_right[`i']'"), halign(right)
    putpdf table T(`r', 6) = ("`=status[`i']'"), margin(left, 6pt)
}
assert `r' == `ntab'
forvalues c = 1/6 {
    putpdf table T(`ntab', `c'), border(bottom, single)
}
putpdf paragraph, spacing(before, 6pt)
putpdf text ("Pieces: dark = also `incword'; white = not `incword'; gray = not in the `cohort_year' file, new to the files; dashed = not in the `cohort_year' file, seen in a file before `cohort_year'. The chart prints a piece count only where it fits; this table gives all."), font("Times New Roman", 9)
putpdf paragraph
putpdf text ("`ntext'"), font("Times New Roman", 9)
putpdf paragraph
putpdf text ("`srcnote'"), font("Times New Roman", 9)
putpdf paragraph
putpdf text ("`devnote'"), font("Times New Roman", 9)
putpdf save "tables/01_cohort_states_flow_table.pdf", replace
display "table -> tables/01_cohort_states_flow_table.pdf (`nrow' plotted rows)"

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/01_cohort_states_flow.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
