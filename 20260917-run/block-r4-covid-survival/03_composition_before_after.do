/*==========================================================================
  R4-03  Did the mix of manufacturing firms change between the last file
         before COVID (2019) and the 2022 file, and was that change larger
         than in normal years? Which part came from firms that left the
         files, which from firms that came in?
  Answers Bu Deasy R4: "Did COVID change the composition of Indonesian
         manufacturing?" - Notes "Melihat firms yg bertahan, mati dan hidup
         selama shock covid" (firms that left and firms that came in).
  Output : figures/03_composition_before_after.png (+ .pdf)
           tables/03_composition_before_after.csv (one row per chart row)
           tables/03_composition_before_after_pairs.csv (every pair of files)
           tables/03_composition_before_after_table.pdf (every plotted point)
  Uses the block "COVID COHORT AND STATES" of R4-01, copied exactly (Step 3).
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
log using "logs/03_composition_before_after.log", replace text
timer clear 1
timer on 1
display _newline "=== [R4-03] STARTING: the mix of firms before and after COVID, against normal years ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

*---------------------------------------------------------------------------
display "Step 1/8: load firm, year, workers, output, importer, foreign ownership and sector"
*---------------------------------------------------------------------------
* workers              = persons engaged (size bands and the share of workers)
* import_flag          = 1 if the firm reported imports that year
* fdi_10_flag          = 1 if foreign owners hold 10% or more (the R1-R4 rule)
* industry2_reported   = first two digits of the reported industry code
* gross_output_*       = only needed by the shared cohort block (Step 3)
quietly describe using "$DATA", varlist
local allvars `r(varlist)'
local want firm_id year workers gross_output_nominal gross_output_real import_flag fdi_10_flag industry2_reported
local have : list want & allvars
use `have' using "$DATA", clear
isid firm_id year
assert !missing(firm_id, year)
tempfile panel
save `panel'

* The COVID pair: the last annual file before COVID reached Indonesia (March 2020)
* against the third file after it. The main normal-years pair starts in 2012.
local covid_year   2019
local placebo_year 2012

*---------------------------------------------------------------------------
display "Step 2/8: the normal-years pairs, read from the files"
*---------------------------------------------------------------------------
* A normal-years pair = a starting file whose next three files are the next three
* calendar years and end before the COVID starting file (e.g. 2010 -> 2013).
* Pairs that cross the missing 2016 file are left out. On files with 2016 the
* rule adds those pairs by itself.
quietly levelsof year, local(files)
local normal_bases ""
foreach b of local files {
    local ok = (`b' + 3 < `covid_year')
    forvalues k = 1/3 {
        local nx = `b' + `k'
        local isin : list posof "`nx'" in files
        if `isin' == 0 local ok 0
    }
    if `ok' local normal_bases `normal_bases' `b'
}
local isin : list posof "`placebo_year'" in normal_bases
if `isin' == 0 {
    display as error "the normal-years starting file `placebo_year' needs three later consecutive files"
    exit 198
}
display "   normal-years starting files: `normal_bases'; COVID starting file: `covid_year'"

*---------------------------------------------------------------------------
display "Step 3/8: for every starting file, which firms stayed, left or came in (shared block)"
*---------------------------------------------------------------------------
* The block below is the R4-01 block, copied exactly. It runs once per starting
* file. Kept per firm: link = 1 in the starting file and the third later file,
* 2 in the starting file only (left the files), 3 in the third later file only
* (came in after the starting file).
tempfile links
local pairs ""
local first 1
foreach cohort_year in `normal_bases' `covid_year' {
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
    * -- keep, per firm, the link between the starting file and its third later file --
    keep firm_id cohort_year in_cohort seen_f3
    gen byte link = cond(in_cohort & seen_f3, 1, cond(in_cohort, 2, cond(seen_f3, 3, .)))
    drop if missing(link)             // came in after the starting file, gone again by the third later file
    rename cohort_year base_year
    gen int end_year = `f3'
    keep firm_id base_year end_year link
    if !`first' append using `links'
    save `links', replace
    local first 0
    local end_`cohort_year' `f3'
}
local covid_end   `end_`covid_year''
local placebo_end `end_`placebo_year''
local nb_first : word 1 of `normal_bases'
local nb_n     : word count `normal_bases'
local nb_last  : word `nb_n' of `normal_bases'
display "   COVID pair `covid_year'-`covid_end'; main normal pair `placebo_year'-`placebo_end'; `nb_n' normal pairs"

*---------------------------------------------------------------------------
display "Step 4/8: the groups - size band, importer, foreign-owned, sector"
*---------------------------------------------------------------------------
use `panel', clear
* size band from the workers in that file; 0 workers counts as "fewer than 20"
gen byte g_siz  = cond(workers < 20, 1, cond(workers < 100, 2, 3)) if !missing(workers)
gen byte g_imp  = import_flag                 // 1 importer, 0 not; missing = no answer
gen byte g_fdi  = fdi_10_flag                 // 1 foreign-owned 10%+, 0 not; missing = no answer
gen int  sec2   = real(industry2_reported)    // missing = no sector recorded
* sectors with fewer than 30 firms in the 2019 file or the 2022 file are pooled into
* "Other sectors" (code 98), so no row rests on a handful of firms
bysort sec2: egen double n_sec_b = total(year == `covid_year')
bysort sec2: egen double n_sec_e = total(year == `covid_end')
gen int g_sec = cond(min(n_sec_b, n_sec_e) < 30, 98, sec2) if !missing(sec2)
quietly levelsof sec2 if g_sec == 98, local(pooled) separate(", ")
display "   sectors pooled into Other sectors: `pooled'"
keep firm_id year workers g_siz g_imp g_fdi g_sec
gen long rid = _n
quietly reshape long g_, i(rid) j(dim) string
rename g_ cat
tempfile stacked
save `stacked'

*---------------------------------------------------------------------------
display "Step 5/8: shares in each pair of files, and the three parts of each change"
*---------------------------------------------------------------------------
* For each pair (starting file b, third later file e) and each group:
*   share of firms  = firms in the group / firms with a known answer (x 100)
*   share of workers = workers in the group's firms / workers in firms with a known answer
*   change = share in e - share in b, in percentage points.
* The change splits exactly into three parts (Melitz-Polanec rule, as in R9: firms that
* left are compared with the firms in both files in b, firms that came in with the firms
* in both files in e, so a shift shared by all firms is not credited to newcomers).
* sS_b, sS_e = share among the firms in both files, measured in b and in e;
* wL = left firms' weight in b; wE = came-in firms' weight in e:
*   left      = - wL x (share among the firms that left    - sS_b)
*   came in   =   wE x (share among the firms that came in - sS_e)
*   changed   =   sS_e - sS_b   (the firms in both files moving between groups)
* For firms the weight is the firm count, for workers the worker count.
tempfile cells
local first 1
foreach b in `normal_bases' `covid_year' {
    use `stacked' if inlist(year, `b', `end_`b''), clear
    gen int base_year = `b'
    quietly merge m:1 firm_id base_year using `links', keepusing(link) keep(master match)
    assert _merge == 3                          // every firm of the two files has a link
    drop _merge
    gen byte side = cond(year == `b', 1, 2)     // 1 starting file, 2 third later file
    assert inlist(link, 1, 2) if side == 1
    assert inlist(link, 1, 3) if side == 2
    gen byte one = 1
    collapse (sum) n = one w = workers, by(base_year side link dim cat)
    if !`first' append using `cells'
    save `cells', replace
    local first 0
}
* group totals among known answers (weights of the formula above)
use `cells', clear
drop if missing(cat)
gen int sl = 10 * side + link                   // 11 both (start) 12 left 21 both (end) 23 came in
tempfile known
preserve
collapse (sum) K = n W = w, by(base_year dim sl)
save `known'
restore
keep base_year dim cat sl n w
gen str12 dimcat = dim + ":" + string(cat)
fillin base_year dimcat sl                      // groups with no firms in a cell get 0
replace n = 0 if _fillin
replace w = 0 if _fillin
drop _fillin dim cat
gen str3 dim = substr(dimcat, 1, strpos(dimcat, ":") - 1)
gen int  cat = real(substr(dimcat, strpos(dimcat, ":") + 1, .))
merge m:1 base_year dim sl using `known', nogen keep(master match)
replace K = 0 if missing(K)
replace W = 0 if missing(W)
drop dimcat
quietly reshape wide n w K W, i(base_year dim cat) j(sl)
foreach s in 11 12 21 23 {
    foreach v in n w K W {
        capture confirm variable `v'`s'
        if _rc gen double `v'`s' = 0
        replace `v'`s' = 0 if missing(`v'`s')
    }
}
gen int end_year = .
foreach b in `normal_bases' `covid_year' {
    replace end_year = `end_`b'' if base_year == `b'
}
foreach m in firms workers {
    local c = cond("`m'" == "firms", "n", "w")
    local T = cond("`m'" == "firms", "K", "W")
    gen double share_`m'_base = 100 * (`c'11 + `c'12) / (`T'11 + `T'12)
    gen double share_`m'_end  = 100 * (`c'21 + `c'23) / (`T'21 + `T'23)
    gen double chg_`m'        = share_`m'_end - share_`m'_base
    gen double s_both_b = `c'11 / `T'11
    gen double s_left   = cond(`T'12 > 0, `c'12 / `T'12, 0)
    gen double s_both_e = `c'21 / `T'21
    gen double s_came   = cond(`T'23 > 0, `c'23 / `T'23, 0)
    gen double part_left_`m'    = -100 * `T'12 / (`T'11 + `T'12) * (s_left   - s_both_b)
    gen double part_came_in_`m' =  100 * `T'23 / (`T'21 + `T'23) * (s_came   - s_both_e)
    gen double part_changed_`m' =  100 * (s_both_e - s_both_b)
    * the three parts add up to the change (exact identity)
    assert abs(part_left_`m' + part_came_in_`m' + part_changed_`m' - chg_`m') < 1e-9 if !missing(s_both_b, s_both_e)
    drop s_both_b s_left s_both_e s_came
}
rename (n11 n12 n21 n23) (firms_both_base firms_left firms_both_end firms_came_in)
rename (K11 K12 K21 K23) (known_both_base known_left known_both_end known_came_in)
rename (w11 w12 w21 w23) (workers_both_base workers_left workers_both_end workers_came_in)
rename (W11 W12 W21 W23) (wknown_both_base wknown_left wknown_both_end wknown_came_in)
gen double firms_base = firms_both_base + firms_left
gen double known_base = known_both_base + known_left
gen double firms_end  = firms_both_end + firms_came_in
gen double known_end  = known_both_end + known_came_in
gen str11 pair_role = cond(base_year == `covid_year', "covid", cond(base_year == `placebo_year', "normal_main", "normal"))
* readable group names (sector names as in R3-03)
gen str40 group = ""
replace group = "Fewer than 20 workers"       if dim == "siz" & cat == 1
replace group = "20–99 workers"               if dim == "siz" & cat == 2
replace group = "100 or more workers"         if dim == "siz" & cat == 3
replace group = "Importer"                    if dim == "imp" & cat == 1
replace group = "Not an importer"             if dim == "imp" & cat == 0
replace group = "Foreign-owned (10% or more)" if dim == "fdi" & cat == 1
replace group = "Not foreign-owned"           if dim == "fdi" & cat == 0
label define secname 10 "Food products" 11 "Beverages" 12 "Tobacco" 13 "Textiles" 14 "Clothing" ///
    15 "Leather and footwear" 16 "Wood products" 17 "Paper" 18 "Printing" 19 "Refined petroleum, coke" ///
    20 "Chemicals" 21 "Medicines" 22 "Rubber and plastics" 23 "Cement, glass, ceramics" ///
    24 "Steel and other metals" 25 "Metal products" 26 "Computers, electronics" 27 "Electrical equipment" ///
    28 "Machinery" 29 "Motor vehicles" 30 "Motorcycles, other vehicles" 31 "Furniture" 32 "Other manufacturing" ///
    33 "Machine repair" 98 "Other sectors", replace
gen int sec_code = cat if dim == "sec"
label values sec_code secname
decode sec_code, gen(sec_name)
replace group = sec_name if dim == "sec"
replace group = "Sector code " + string(cat) if dim == "sec" & group == ""
drop sec_code sec_name
gen str7 section = cond(dim == "siz", "size", cond(dim == "sec", "sector", "trade"))
order base_year end_year pair_role section dim cat group firms_base known_base firms_end known_end ///
    share_firms_base share_firms_end chg_firms part_left_firms part_came_in_firms part_changed_firms ///
    share_workers_base share_workers_end chg_workers part_left_workers part_came_in_workers part_changed_workers
sort dim cat base_year
format share_* chg_* part_* %9.3f
format firms_* known_* workers_* wknown_* %12.0f
export delimited using "tables/03_composition_before_after_pairs.csv", datafmt replace
tempfile allpairs
save `allpairs'

*---------------------------------------------------------------------------
display "Step 6/8: one row per chart row -> CSV (numbers before drawing)"
*---------------------------------------------------------------------------
* normal-years range = lowest and highest change over the normal-years pairs
use `allpairs', clear
keep if pair_role != "covid"
collapse (min) nmin_firms = chg_firms nmin_workers = chg_workers ///
         (max) nmax_firms = chg_firms nmax_workers = chg_workers (count) n_normal_pairs = chg_firms, by(dim cat)
tempfile nrange
save `nrange'
use `allpairs' if pair_role == "normal_main", clear
keep dim cat chg_firms chg_workers part_left_firms part_came_in_firms part_changed_firms
rename (chg_firms chg_workers part_left_firms part_came_in_firms part_changed_firms) ///
       (norm_chg_firms norm_chg_workers norm_part_left norm_part_came_in norm_part_changed)
tempfile nmain
save `nmain'
use `allpairs' if pair_role == "covid", clear
merge 1:1 dim cat using `nmain', nogen
merge 1:1 dim cat using `nrange', nogen
* drawn rows: the three size bands, importers, foreign-owned firms, every sector
gen byte drawn = inlist(dim, "siz", "sec") | (inlist(dim, "imp", "fdi") & cat == 1)
gen byte doubt = (dim == "imp")                 // importer records change in 2017 and 2022
gen str60 status = cond(drawn, "drawn", "not drawn: the rest of the row above")
replace status = "drawn gray: records in doubt" if drawn & doubt
* the exporter row cannot be built: kept as a not-drawn row with the reason
local nobs = _N + 1
set obs `nobs'
replace dim = "exp" in `nobs'
replace section = "trade" in `nobs'
replace group = "Exporter" in `nobs'
replace drawn = 0 in `nobs'
replace doubt = 0 in `nobs'
replace status = "not drawn: the `covid_end' file records no non-exporters" in `nobs'
replace base_year = `covid_year' in `nobs'
replace end_year = `covid_end' in `nobs'
* row order: size, trade, then sectors from the largest rise in the share of firms to the largest fall
gen byte sec_ord = cond(dim == "siz", 1, cond(inlist(dim, "imp", "fdi", "exp"), 2, 3))
gen byte sub_ord = cond(dim == "siz", cat, cond(dim == "imp", 1 + (cat == 0), cond(dim == "fdi", 3 + (cat == 0), cond(dim == "exp", 5, cond(cat == 98, 2, 1)))))
gen double sort_chg = cond(dim == "sec", -chg_firms, 0)
sort sec_ord sub_ord sort_chg cat
gen int row_order = _n
gen str9  covid_pair   = "`covid_year'-`covid_end'"
gen str9  normal_pair  = "`placebo_year'-`placebo_end'"
gen str60 normal_pairs = "`nb_first' to `nb_last' starting files"
gen str40 pooled_sectors = "`pooled'" if dim == "sec" & cat == 98
order row_order section group drawn status doubt covid_pair firms_base known_base firms_end known_end ///
    share_firms_base share_firms_end chg_firms norm_chg_firms nmin_firms nmax_firms ///
    share_workers_base share_workers_end chg_workers norm_chg_workers nmin_workers nmax_workers ///
    part_left_firms part_came_in_firms part_changed_firms firms_both_base firms_left firms_both_end firms_came_in ///
    known_both_base known_left known_both_end known_came_in normal_pair normal_pairs n_normal_pairs norm_part_left norm_part_came_in norm_part_changed ///
    part_left_workers part_came_in_workers part_changed_workers pooled_sectors dim cat
keep row_order-cat
format share_* chg_* norm_* nmin_* nmax_* part_* %9.3f
export delimited using "tables/03_composition_before_after.csv", datafmt replace
list row_order group drawn firms_base firms_end share_firms_base share_firms_end chg_firms norm_chg_firms ///
    nmin_firms nmax_firms, noobs sep(0) abbreviate(24)
list row_order group chg_workers norm_chg_workers part_left_firms part_came_in_firms part_changed_firms ///
    firms_left firms_came_in, noobs sep(0) abbreviate(24)
* structural checks: shares of the size bands and of the sectors add up to 100 in each file
foreach d in siz sec {
    foreach v in share_firms_base share_firms_end share_workers_base share_workers_end {
        quietly summarize `v' if dim == "`d'"
        assert abs(r(sum) - 100) < 1e-6
    }
}

*---------------------------------------------------------------------------
display "Step 7/8: dot chart, three panels on one scale (percentage points)"
*---------------------------------------------------------------------------
* numbers for the notes (read from the data, never typed)
* firm counts behind panel (c): the size rows cover every firm (workers never missing in a file)
quietly summarize known_left if row_order == 1
local n_left = strtrim(string(r(mean), "%12.0fc"))
quietly summarize known_came_in if row_order == 1
local n_came = strtrim(string(r(mean), "%12.0fc"))
quietly summarize known_both_base if row_order == 1
local n_both = strtrim(string(r(mean), "%12.0fc"))
keep if drawn
* y positions: a bold heading per section, one blank row between sections
gen double y = .
local pos 0
local ylab ""
local prevsec ""
local headsize   "Size (workers in the file)"
local headtrade  "Imports and foreign ownership"
local headsector "Sector (two-digit code), largest rise first"
forvalues i = 1/`=_N' {
    local sec = section[`i']
    if "`sec'" != "`prevsec'" {
        if "`prevsec'" != "" local pos = `pos' + 0.5
        local ++pos
        local ylab `"`ylab' `pos' "{bf:`head`sec''}""'
        local prevsec "`sec'"
    }
    local ++pos
    replace y = `pos' in `i'
    local lab = group[`i']
    if doubt[`i'] local lab "`lab' (`covid_end' records in doubt)"
    local ylab `"`ylab' `pos' "`lab'""'
}
local ymax = `pos' + 0.6
* three panels: (a) share of firms, (b) share of workers, (c) the three parts of (a)
expand 3
bysort row_order: gen byte panel = _n
gen double covid = cond(panel == 1, chg_firms, cond(panel == 2, chg_workers, .))
gen double plac  = cond(panel == 1, norm_chg_firms, cond(panel == 2, norm_chg_workers, .))
gen double rlo   = cond(panel == 1, nmin_firms, cond(panel == 2, nmin_workers, .))
gen double rhi   = cond(panel == 1, nmax_firms, cond(panel == 2, nmax_workers, .))
gen double p_left = part_left_firms    if panel == 3
gen double p_came = part_came_in_firms if panel == 3
gen double p_chg  = part_changed_firms if panel == 3
* value label on the COVID dot, outside the row's other marks
gen str8   vlab = strtrim(string(covid, "%5.1f")) if panel < 3
replace vlab = "0.0" if vlab == "-0.0"
gen double vx   = cond(covid >= 0, max(covid, plac, rhi), min(covid, plac, rlo)) if panel < 3
gen byte   vpos = cond(covid >= 0, 3, 9)
label define panel 1 "(a) Share of firms" 2 "(b) Share of workers" ///
    3 "(c) Split of (a), `covid_year'–`covid_end'", replace
label values panel panel
* one shared x scale, step 5 points, room for the value labels
egen double lo_all = rowmin(covid plac rlo p_left p_came p_chg)
egen double hi_all = rowmax(covid plac rhi p_left p_came p_chg)
quietly summarize lo_all
local xlo = 5 * floor((r(min) - 3) / 5)
quietly summarize hi_all
local xhi = 5 * ceil((r(max) + 3) / 5)
local xlo = min(`xlo', -5)
local xhi = max(`xhi', 5)
local xstep = cond(`xhi' - `xlo' > 25, 10, 5)
local xl1 = `xstep' * ceil(`xlo' / `xstep')
local xl2 = `xstep' * floor(`xhi' / `xstep')
display "   x range `xlo' to `xhi'"

local charttitle "Figure R4-03. The mix of firms in the `covid_year' and `covid_end' files against normal years: change in the share of firms and of workers by size, imports, foreign ownership and sector"
local ntext "Notes: Each row = a group's share of all firms (a) or of all workers (b) in an annual file. Dot = change from the `covid_year' file to the `covid_end' file, in percentage points; hollow = the same change from `placebo_year' to `placebo_end'; gray bar = lowest to highest change over the normal-years spans (starting files `nb_first' to `nb_last', each compared with the file three years on). (c) splits the dot in (a) into three parts that add up to it: `covid_year' firms not in the `covid_end' file (`n_left'), compared with the firms in both files in `covid_year'; `covid_end' firms not in the `covid_year' file (`n_came'), compared with the firms in both files in `covid_end'; and the change within the firms in both files (`n_both'), e.g. shrinking below 20 workers or, for sectors, a changed sector code. Shares among firms with a known answer; sectors with under 30 firms in `covid_year' or `covid_end' are pooled; sector codes are not checked across years. Exporters are not shown: the `covid_end' file records no non-exporters. Gray: the recorded importer share jumps in 2017 and falls in `covid_end', likely a recording change. Whole annual files, not samples, so no sampling interval; the gray bar shows normal movement. Shows how the mix changed, not the effect of COVID; left the files is not proof of closure. (a) and (b) use no firm links; (c) does. Firm links are fictional in the development data, so who stays, leaves or comes back means nothing here; read these results on the real BPS files."
local notelines ""
local line ""
foreach w of local ntext {
    if ustrlen("`line' `w'") > 130 & "`line'" != "" {
        local notelines `"`notelines' "`line'""'
        local line "`w'"
    }
    else local line = strtrim("`line' `w'")
}
local notelines `"`notelines' "`line'""'
display `"   note lines: `notelines'"'
* title in two lines at the colon
local t1 = substr("`charttitle'", 1, strpos("`charttitle'", ":"))
local t2 = strtrim(substr("`charttitle'", strpos("`charttitle'", ":") + 1, .))
sort panel y

twoway (rbar rlo rhi y if panel < 3, horizontal barwidth(0.45) fcolor(gs13) lcolor(gs13) lwidth(none)) ///
    (scatter y plac if panel < 3, msymbol(Oh) mcolor(black) msize(small) mlwidth(thin)) ///
    (scatter y covid if panel < 3 & !doubt, msymbol(O) mcolor(black) msize(small)) ///
    (scatter y covid if panel < 3 & doubt, msymbol(O) mcolor(gs10) msize(small)) ///
    (scatter y p_left if !doubt, msymbol(Th) mcolor(black) msize(small) mlwidth(thin)) ///
    (scatter y p_came if !doubt, msymbol(S) mcolor(black) msize(vsmall)) ///
    (scatter y p_chg  if !doubt, msymbol(X) mcolor(black) msize(small)) ///
    (scatter y p_left if doubt, msymbol(Th) mcolor(gs10) msize(small) mlwidth(thin)) ///
    (scatter y p_came if doubt, msymbol(S) mcolor(gs10) msize(vsmall)) ///
    (scatter y p_chg  if doubt, msymbol(X) mcolor(gs10) msize(small)) ///
    (scatter y vx if panel < 3, msymbol(none) mlabel(vlab) mlabvposition(vpos) mlabgap(0.8) mlabsize(vsmall) mlabcolor(gs5)), ///
    by(panel, rows(1) graphregion(color(white) lcolor(white) ilcolor(white) margin(r+3)) legend(pos(6)) scale(0.8125) ///
        title("`t1'" "`t2'", size(small) pos(11) span) ///
        note(`notelines' "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6))) ///
    subtitle(, pos(11) nobox fcolor(white) lcolor(white) size(small)) ///
    yscale(reverse noline range(0.4 `ymax')) ylabel(`ylab', angle(0) noticks tlength(0) nogrid labsize(vsmall)) ytitle("") ///
    xscale(range(`xlo' `xhi') lcolor(gs10)) ///
    xlabel(`xl1'(`xstep')`xl2', noticks tlength(0) labsize(vsmall) grid glcolor(gs15) glwidth(vthin)) ///
    xline(0, lcolor(gs8) lwidth(thin)) ///
    xtitle("Percentage points (0 = no change)", size(vsmall)) ///
    legend(order(3 "`covid_year' to `covid_end' (COVID)" 2 "`placebo_year' to `placebo_end' (normal years)" ///
                 1 "Range, normal years" 4 "Gray: records in doubt" ///
                 5 "(c) Firms that left" 6 "(c) Firms that came in" 7 "(c) Change within firms in both files") ///
        rows(2) region(lcolor(none)) size(vsmall) symxsize(5) keygap(1) colgap(5) rowgap(0.4)) ///
    plotregion(style(none)) xsize(9.5) ysize(10)

graph export "figures/03_composition_before_after.png", width(2850) replace
graph export "figures/03_composition_before_after.pdf", replace

*---------------------------------------------------------------------------
display "Step 8/8: companion table - every plotted point, one chart row per line (putpdf, no add-on)"
*---------------------------------------------------------------------------
* Read back the CSV just written, so the table shows exactly the charted numbers.
import delimited using "tables/03_composition_before_after.csv", clear varnames(1) encoding("utf-8") stringcols(2 3 5 7)
keep if drawn == 1 | group == "Exporter"        // plotted rows, plus the row that cannot be drawn
sort row_order
local nall = _N
local nsec = 0
local prev ""
forvalues i = 1/`nall' {
    if section[`i'] != "`prev'" local ++nsec
    local prev = section[`i']
}
local ntab = `nall' + `nsec' + 2                 // two header rows + section headings
putpdf clear
putpdf begin, landscape font("Times New Roman", 9) margin(all, 0.5in)
putpdf paragraph, spacing(after, 6pt)
putpdf text ("Table R4-03. `=substr("`charttitle'", strpos("`charttitle'", ".") + 2, .)' — every plotted point"), bold font("Times New Roman", 10)
matrix colw = (22, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.4, 5.4, 11.1)
putpdf table T = (`ntab', 15), border(all, nil) width(colw)
* header row 1: panels; header row 2: series. Rules first, then merge cells from the
* right, so the cell numbers on the left do not move.
forvalues c = 1/15 {
    putpdf table T(1, `c') = (""), border(top, single)
}
putpdf table T(1, 13) = ("Firms in the group"), bold halign(center) colspan(2) border(top, single)
putpdf table T(1, 10) = ("(c) Split of (a), points"), bold halign(center) colspan(3) border(top, single)
putpdf table T(1, 6)  = ("(b) Share of workers, change (points)"), bold halign(center) colspan(4) border(top, single)
putpdf table T(1, 2)  = ("(a) Share of firms, change (points)"), bold halign(center) colspan(4) border(top, single)
local cy2 = substr("`covid_end'", 3, 2)
local py2 = substr("`placebo_end'", 3, 2)
local h1  "Row on the chart"
local h2  "`covid_year'–`cy2'"
local h3  "`placebo_year'–`py2'"
local h4  "Normal low"
local h5  "Normal high"
local h6  "`covid_year'–`cy2'"
local h7  "`placebo_year'–`py2'"
local h8  "Normal low"
local h9  "Normal high"
local h10 "Left"
local h11 "Came in"
local h12 "Both files"
local h13 "`covid_year'"
local h14 "`covid_end'"
local h15 "Status"
forvalues c = 1/15 {
    local al = cond(inlist(`c', 1, 15), "left", "right")
    putpdf table T(2, `c') = ("`h`c''"), bold halign(`al') border(bottom, single)
}
local r 2
local prev ""
forvalues i = 1/`nall' {
    local sec = section[`i']
    if "`sec'" != "`prev'" {
        local ++r
        putpdf table T(`r', 1) = ("`head`sec''"), bold
        local prev "`sec'"
    }
    local ++r
    local lab = group[`i']
    if doubt[`i'] local lab "`lab' (`covid_end' records in doubt)"
    putpdf table T(`r', 1) = ("`lab'")
    local c 1
    foreach v in chg_firms norm_chg_firms nmin_firms nmax_firms chg_workers norm_chg_workers nmin_workers nmax_workers ///
                 part_left_firms part_came_in_firms part_changed_firms {
        local ++c
        local x = `v'[`i']
        local s = cond(missing(`x'), "", strtrim(string(`x', "%6.2f")))
        putpdf table T(`r', `c') = ("`s'"), halign(right)
    }
    foreach v in firms_base firms_end {
        local ++c
        local x = `v'[`i']
        local s = cond(missing(`x'), "", strtrim(string(`x', "%12.0fc")))
        putpdf table T(`r', `c') = ("`s'"), halign(right)
    }
    putpdf table T(`r', 15) = ("`=status[`i']'"), margin(left, 6pt)
}
assert `r' == `ntab'
forvalues c = 1/15 {
    putpdf table T(`ntab', `c'), border(bottom, single)
}
putpdf paragraph, spacing(before, 6pt)
putpdf text ("Values in percentage points, two decimals (the chart labels round the `covid_year'–`covid_end' dot to one). Normal low and high = the ends of the gray bar. Firms in the group = firms in that row's group in each file (each share is taken over every firm with a known answer; the CSV gives those counts). Every pair of files and every share is in tables/03_composition_before_after_pairs.csv."), font("Times New Roman", 9)
putpdf paragraph
putpdf text ("`ntext'"), font("Times New Roman", 9)
putpdf paragraph
putpdf text ("`srcnote'"), font("Times New Roman", 9)
putpdf paragraph
putpdf text ("`devnote'"), font("Times New Roman", 9)
putpdf save "tables/03_composition_before_after_table.pdf", replace
quietly count if drawn == 1
display "table -> tables/03_composition_before_after_table.pdf (`r(N)' plotted rows, `nall' table rows)"

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/03_composition_before_after.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
