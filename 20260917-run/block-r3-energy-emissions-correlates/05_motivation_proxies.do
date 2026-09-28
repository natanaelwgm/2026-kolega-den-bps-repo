/*==========================================================================
  R3-05  Do firms with an environmental permit document, waste treatment,
         R&D or innovation cut energy and CO2 more often than firms without?
  Answers Deasy R3: "Lebih ke determinan motivasi apa yg membuat firms
         respond to climate commitment" - "Bukan kausal, tp mengetahui firms
         mana yg respond thd climate and motivasinya apa". No survey question
         asks about motives: these answers are the closest stand-ins.
  Output : figures/05_motivation_proxies.png (+ .pdf)
           tables/05_motivation_proxies.csv     (numbers in the figure + checks)
           tables/05_motivation_proxies_fe.csv  (companion: R3-04 comparison A
                                                 with each answer added; not drawn)
           tables/05_motivation_proxies_table.pdf (every plotted point)
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
global OUTDIR "/Users/natanaelmassie/Downloads/2026-kolega-den-bps-repo/20260917-run/block-r3-energy-emissions-correlates"
* ---------------------------------------------------------------------------
if `"`data_arg'"'   != "" global DATA   `"`data_arg'"'
if `"`outdir_arg'"' != "" global OUTDIR `"`outdir_arg'"'
cd "$OUTDIR"
foreach d in figures tables logs {
    capture mkdir "`d'"
}
cap log close
log using "logs/05_motivation_proxies.log", replace text
timer clear 1
timer on 1
display _newline "=== [R3-05] STARTING: do firms with environmental documents, waste treatment, R&D or innovation cut energy and CO2 more often ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

* small helper: turn a list of years into short text, e.g. "2011 2017 2018 2019" -> "2011, 2017–19"
capture program drop yearspan
program define yearspan, rclass
    local out ""
    local first = .
    local prev  = .
    foreach y of local 0 {
        if `y' == `prev' + 1 {
            local prev = `y'
            continue
        }
        if `first' < . {
            local seg = cond(`prev' > `first', "`first'–" + substr("`prev'", 3, 2), "`first'")
            local out = cond(`"`out'"' == "", "`seg'", "`out', `seg'")
        }
        local first = `y'
        local prev  = `y'
    }
    if `first' < . {
        local seg = cond(`prev' > `first', "`first'–" + substr("`prev'", 3, 2), "`first'")
        local out = cond(`"`out'"' == "", "`seg'", "`out', `seg'")
    }
    return local s "`out'"
end

*---------------------------------------------------------------------------
display "Step 1/9: load the variables; find the years each question was asked"
*---------------------------------------------------------------------------
* env_amdal_flag / env_ukl_upl_flag / env_sppl_flag = the firm holds that environmental
*   permit document (AMDAL strictest, for large impacts; UKL-UPL middle; SPPL simplest)
* env_waste_treatment_flag = the firm has a waste treatment installation
* rd_activity_flag = the firm does research and development (R&D)
* innovation_flag / innovation_process_flag = any innovation / a new production process
* A blank answer stays blank ("not recorded"); it is never counted as "no".
use firm_id year total_gj_s1 co2_total_s1 value_added_nominal workers ///
    export_flag import_flag fdi_10_flag own_gen_positive_reported industry2_reported province_code ///
    env_amdal_flag env_ukl_upl_flag env_sppl_flag env_waste_treatment_flag ///
    rd_activity_flag innovation_flag innovation_process_flag ///
    vs_rd_activity_flag vs_innovation_flag vs_innovation_process_flag using "$DATA", clear
isid firm_id year
* years in which each question has at least one answer (read from the data)
local fams "doc waste rd inn proc amdal ukl sppl"
local fv_doc   "env_amdal_flag"
local fv_waste "env_waste_treatment_flag"
local fv_rd    "rd_activity_flag"
local fv_inn   "innovation_flag"
local fv_proc  "innovation_process_flag"
local fv_amdal "env_amdal_flag"
local fv_ukl   "env_ukl_upl_flag"
local fv_sppl  "env_sppl_flag"
foreach f of local fams {
    quietly levelsof year if !missing(`fv_`f''), local(ask_`f')
    display "   `fv_`f'': answers in `ask_`f''"
}
* years whose R&D / innovation answers are a provisional reading of the survey codes
* (source-validity code 10 = "PROVISIONAL observed; assumption documented")
quietly levelsof year if vs_rd_activity_flag == 10 | vs_innovation_flag == 10 | vs_innovation_process_flag == 10, local(prov_yrs)
display "   provisional R&D / innovation years: `prov_yrs'"
* foreign-ownership break year (R3-02 rule) - only for the companion model
preserve
collapse (mean) sh_fdi = fdi_10_flag, by(year)
quietly summarize sh_fdi, detail
local med_sh = r(p50)
quietly levelsof year if sh_fdi > 2 * `med_sh' & !missing(sh_fdi), local(fdi_skip)
restore
display "   Foreign-ownership break year(s): `fdi_skip'"
gen int sector = real(industry2_reported)
encode province_code, gen(province)
xtset firm_id year

*---------------------------------------------------------------------------
display "Step 2/9: one-year changes, as in R3-01 (same code)"
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
* R3-02 benchmark (typical change of ALL firms that year): kept for one CSV column
bysort year: egen double med_all_energy_va = pctile(chg_energy_va), p(50)   // median; egen median() would ignore "double"
xtset firm_id year                // the bysort call above changed the sort order

*---------------------------------------------------------------------------
display "Step 3/9: each firm's answer in the FIRST year of each change"
*---------------------------------------------------------------------------
gen int start_year = year - 1 if cmp
gen double ln_e0 = ln(L.total_gj_s1) if cmp                     // energy at the start (log), for the notes
* environmental document: the strictest one held (a firm may hold more than one)
gen byte doc_ans = !missing(L.env_amdal_flag, L.env_ukl_upl_flag, L.env_sppl_flag) if cmp
gen byte g_doc = 4 if cmp                                                    // 4 = not recorded (any of the three blank)
replace  g_doc = 3 if cmp & doc_ans & L.env_amdal_flag == 0 & L.env_ukl_upl_flag == 0 & L.env_sppl_flag == 0
replace  g_doc = 2 if cmp & doc_ans & L.env_amdal_flag == 0 & (L.env_ukl_upl_flag == 1 | L.env_sppl_flag == 1)
replace  g_doc = 1 if cmp & doc_ans & L.env_amdal_flag == 1
* yes / no / not recorded questions
foreach f in waste rd inn proc amdal ukl sppl {
    gen byte g_`f' = cond(L.`fv_`f'' == 1, 1, cond(L.`fv_`f'' == 0, 2, 3)) if cmp
}
* keep a change in a question's rows only if the question was asked in its first year
foreach f of local fams {
    gen byte cov_`f' = 0 if cmp
    foreach y of local ask_`f' {
        replace cov_`f' = 1 if cmp & start_year == `y'
    }
    replace g_`f' = . if cov_`f' != 1
    local nr = cond("`f'" == "doc", 4, 3)
    gen byte ans_`f' = !missing(g_`f') & g_`f' != `nr'
    quietly levelsof start_year if cov_`f' == 1, local(st_`f')
    yearspan `st_`f''
    local span_`f' "`r(s)'"
    * are ALL of this question's years provisionally coded? (then the figure header says so)
    local allprov_`f' : list st_`f' in prov_yrs
    if "`st_`f''" == "" | "`prov_yrs'" == "" local allprov_`f' 0
    quietly count if cov_`f' == 1
    local ncov = r(N)
    quietly count if ans_`f'
    display "   `f': answers taken from `span_`f''; changes `ncov', with an answer " r(N)
}
quietly count if cmp
local n_cmp = strtrim(string(r(N), "%9.0fc"))
* do 'Yes' firms start with more energy than 'No' firms? (numbers for the notes)
* A high start tends to be followed by a fall, which moves panels (c) and (d).
local nq 0
local nhi 0
foreach f in doc waste rd inn proc {
    local yc "g_`f' == 1"
    local nc "g_`f' == 2"
    if "`f'" == "doc" {
        local yc "inlist(g_doc, 1, 2)"
        local nc "g_doc == 3"
    }
    quietly summarize ln_e0 if `yc', detail
    local my = r(p50)
    quietly summarize ln_e0 if `nc', detail
    if `my' < . & r(p50) < . {
        local ++nq
        if `my' > r(p50) local ++nhi
        display "   `f': median start energy (log GJ), Yes " %6.2f `my' " vs No " %6.2f r(p50)
    }
}
display "   'Yes' firms start with more energy in `nhi' of `nq' questions"

*---------------------------------------------------------------------------
display "Step 4/9: did each change beat the typical firm that ANSWERED the same question that year?"
*---------------------------------------------------------------------------
* Firms without an answer differ a lot from firms with one, and the years a
* question was asked differ, so each change is compared with the typical
* (median) change of the firms that answered the same question in the same year.
foreach f of local fams {
    foreach v in energy_va co2_va energy co2 {
        bysort start_year: egen double m_`f'_`v' = pctile(cond(ans_`f', chg_`v', .)), p(50)
        gen byte b_`f'_`v' = (chg_`v' < m_`f'_`v') if !missing(g_`f')
    }
    quietly count if !missing(g_`f') & chg_energy_va == m_`f'_energy_va
    display "   `f': changes exactly at the typical change (counted as not beating it) = " r(N)
    quietly summarize b_`f'_energy_va if ans_`f'
    if r(N) > 0 assert inrange(r(mean), 0.48, 0.52)   // about half of the answering firms beat their median
}
gen byte b_all_energy_va = (chg_energy_va < med_all_energy_va) if cmp
xtset firm_id year

*---------------------------------------------------------------------------
display "Step 5/9: share beating the typical answering firm, per answer, with 95% intervals"
*---------------------------------------------------------------------------
tempname P
tempfile rows
postfile `P' int row_order byte in_figure str12 family str48 question str40 answers_from str30 group byte answered ///
    long(changes firms) str30 reference_group ///
    double(pct_energy_va lo_energy_va hi_energy_va gap_energy_va gap_lo_energy_va gap_hi_energy_va ///
           pct_co2_va lo_co2_va hi_co2_va gap_co2_va gap_lo_co2_va gap_hi_co2_va ///
           pct_energy lo_energy hi_energy gap_energy gap_lo_energy gap_hi_energy ///
           pct_co2 lo_co2 hi_co2 gap_co2 gap_lo_co2 gap_hi_co2 ///
           loo_min_energy_va loo_max_energy_va pct_energy_va_not_provisional pct_energy_va_vs_all_firms) ///
    using `rows', replace
local r 0
foreach f of local fams {
    if "`f'" == "doc"   local qn "Environmental permit"
    if "`f'" == "waste" local qn "Waste treatment"
    if "`f'" == "rd"    local qn "R&D activity"
    if "`f'" == "inn"   local qn "Any innovation"
    if "`f'" == "proc"  local qn "Process innovation"
    if "`f'" == "amdal" local qn "AMDAL held (any other too)"
    if "`f'" == "ukl"   local qn "UKL-UPL held"
    if "`f'" == "sppl"  local qn "SPPL held"
    local gl `""Yes" "No" "Not recorded""'
    if "`f'" == "doc" local gl `""AMDAL (strictest)" "UKL-UPL or SPPL only" "None of the three" "Not recorded""'
    local K : word count `gl'
    local ref = cond("`f'" == "doc", 3, 2)
    local refname : word `ref' of `gl'
    local infig = inlist("`f'", "doc", "waste", "rd", "inn", "proc")
    forvalues k = 1/`K' {
        quietly count if g_`f' == `k'
        if r(N) == 0 continue
        local ++r
        local gname : word `k' of `gl'
        local vals ""
        foreach v in energy_va co2_va energy co2 {
            quietly mean b_`f'_`v' if g_`f' == `k', vce(cluster firm_id)
            matrix T = r(table)
            local p  = 100 * T[1,1]
            local lo = 100 * T[5,1]
            local hi = 100 * T[6,1]
            local nn = e(N)
            local nf = e(N_clust)
            local g = .
            local glo = .
            local ghi = .
            if `k' != `ref' {
                quietly regress b_`f'_`v' ib`ref'.g_`f', vce(cluster firm_id)
                quietly lincom 100 * `k'.g_`f'
                local g   = r(estimate)
                local glo = r(lb)
                local ghi = r(ub)
            }
            local vals `vals' (`p') (`lo') (`hi') (`g') (`glo') (`ghi')
        }
        * leave out one start year at a time (main measure)
        local lmin = .
        local lmax = .
        local nst : word count `st_`f''
        if `nst' > 1 {
            foreach sy of local st_`f' {
                quietly summarize b_`f'_energy_va if g_`f' == `k' & start_year != `sy'
                if r(N) > 0 {
                    local lmin = min(`lmin', 100 * r(mean))
                    local lmax = cond(`lmax' == ., 100 * r(mean), max(`lmax', 100 * r(mean)))
                }
            }
        }
        * without the provisional R&D / innovation years
        local pnp = .
        if inlist("`f'", "rd", "inn", "proc") {
            gen byte tmp_np = 1
            foreach y of local prov_yrs {
                replace tmp_np = 0 if start_year == `y'
            }
            quietly summarize b_`f'_energy_va if g_`f' == `k' & tmp_np == 1
            if r(N) > 0 local pnp = 100 * r(mean)
            drop tmp_np
        }
        * the same change compared with ALL firms that year (the R3-02 benchmark)
        quietly summarize b_all_energy_va if g_`f' == `k'
        local pall = 100 * r(mean)
        local isans = (`k' < `K')
        post `P' (`r') (`infig') ("`f'") ("`qn'") ("`span_`f''") ("`gname'") (`isans') (`nn') (`nf') ("`refname'") ///
            `vals' (`lmin') (`lmax') (`pnp') (`pall')
    }
}
postclose `P'

*---------------------------------------------------------------------------
display "Step 6/9: companion - R3-04 comparison (A) with each answer added (CSV only)"
*---------------------------------------------------------------------------
* Same traits as R3-04 (A): workers, exporter, importer, foreign-owned, own
* electricity, each with its own "not recorded" indicator; year, sector and
* province effects. Foreign status from a break year is set to "not used"
* (R3-04 check A_keepbreak), because the document and waste questions exist
* only from that year on. Firms with no answer get their own baseline in each
* year (year x not recorded), so a blank answer never counts as "no".
gen double s_lnw  = ln(L.workers) if cmp
gen byte   exp1   = (L.export_flag == 1) if cmp
gen byte   exp_nr = missing(L.export_flag) if cmp
gen byte   imp1   = (L.import_flag == 1) if cmp
gen byte   brk    = 0 if cmp
foreach y of local fdi_skip {
    replace brk = 1 if start_year == `y' & cmp
}
gen byte   fdi1_k   = (L.fdi_10_flag == 1) & brk == 0 if cmp
gen byte   fdi_nr_k = (missing(L.fdi_10_flag) | brk == 1) if cmp
gen byte   own1   = (L.own_gen_positive_reported == 1) if cmp
gen byte   own_nr = missing(L.own_gen_positive_reported) if cmp
local X "s_lnw exp1 exp_nr imp1 fdi1_k fdi_nr_k own1 own_nr"
gen byte doc_amdal = (g_doc == 1) if !missing(g_doc)
gen byte doc_light = (g_doc == 2) if !missing(g_doc)
foreach f in waste rd inn proc {
    gen byte `f'_yes = (g_`f' == 1) if !missing(g_`f')
}
foreach f of local fams {
    gen byte nr_`f' = !ans_`f' if !missing(g_`f')
}
tempname E
tempfile fe
postfile `E' str12 family str10 outcome str12 term str40 term_label double(b se p pct pct_lo pct_hi) ///
    long(changes firms changes_with_answer) using `fe', replace
foreach f in doc waste rd inn proc {
    local P "`f'_yes"
    if "`f'" == "doc" local P "doc_amdal doc_light"
    quietly count if ans_`f' & !missing(s_lnw)
    if r(N) == 0 continue                         // question never answered: nothing to estimate
    foreach y in energy_va co2_va energy co2 {
        quietly reghdfe chg_`y' `X' `P' if !missing(g_`f') & !missing(s_lnw), ///
            absorb(start_year#nr_`f' sector province) vce(cluster firm_id)
        matrix T = r(table)
        local N = e(N)
        local G = e(N_clust)
        foreach t of local P {
            local j = colnumb(T, "`t'")
            quietly count if `t' == 1 & e(sample)
            local ca = r(N)
            local tl = cond("`t'" == "doc_amdal", "AMDAL (vs none of the three)", ///
                       cond("`t'" == "doc_light", "UKL-UPL or SPPL only (vs none)", "Yes (vs no)"))
            if missing(T[2,`j']) | T[2,`j'] == 0 {     // answer dropped (nobody has it in this sample): blank
                post `E' ("`f'") ("`y'") ("`t'") ("`tl'") (.) (.) (.) (.) (.) (.) (`N') (`G') (`ca')
            }
            else {
                post `E' ("`f'") ("`y'") ("`t'") ("`tl'") (T[1,`j']) (T[2,`j']) (T[4,`j']) ///
                    (100*(exp(T[1,`j'])-1)) (100*(exp(T[5,`j'])-1)) (100*(exp(T[6,`j'])-1)) (`N') (`G') (`ca')
            }
        }
    }
}
postclose `E'

*---------------------------------------------------------------------------
display "Step 7/9: write the numbers (CSV) before drawing"
*---------------------------------------------------------------------------
preserve
use `fe', clear
format b se %9.4f
format pct pct_lo pct_hi %7.2f
format p %6.4f
export delimited using "tables/05_motivation_proxies_fe.csv", datafmt replace
list family outcome term pct pct_lo pct_hi changes firms changes_with_answer, noobs sep(0) abbreviate(24)
restore
use `rows', clear
format changes firms %9.0f
format pct_* lo_* hi_* gap_* loo_* %6.2f
export delimited using "tables/05_motivation_proxies.csv", datafmt replace
tempfile ctsrc                     // same numbers, full precision, for the companion table (Step 9)
quietly save `ctsrc'
list row_order family group answers_from changes firms pct_energy_va lo_energy_va hi_energy_va gap_energy_va ///
    pct_energy gap_energy loo_min_energy_va loo_max_energy_va pct_energy_va_not_provisional pct_energy_va_vs_all_firms, ///
    noobs sep(0) abbreviate(24)
assert lo_energy_va <= pct_energy_va & pct_energy_va <= hi_energy_va if firms >= 2

*---------------------------------------------------------------------------
display "Step 8/9: dot plot, four panels on one shared scale"
*---------------------------------------------------------------------------
* numbers for the notes (read from the data, never typed)
yearspan `prov_yrs'
local provspan "`r(s)'"
local provnote ""
if "`prov_yrs'" != "" local provnote "R&D and innovation codes for `provspan' are provisional. "   // read from codes whose meaning is assumed
local fbnote ""
if `nq' > 0 local fbnote "In `nhi' of `nq' questions, 'Yes' firms start with more energy than 'No' firms; high starts tend to fall back, so gaps in (c)–(d) are partly automatic."
keep if in_figure
sort row_order
gen double y = .
local pos 0
local ylab `"0 "Answer at start (number of changes)""'
local prevf ""
forvalues i = 1/`=_N' {
    local fnm = family[`i']
    if "`fnm'" != "`prevf'" {
        if "`prevf'" != "" local ++pos
        local ++pos
        local qn  = question[`i']
        local afr = answers_from[`i']
        if `allprov_`fnm'' local afr "`afr', provisional"
        local ylab `"`ylab' `pos' "{bf:`qn'} (`afr'):""'
        local prevf "`fnm'"
    }
    local ++pos
    replace y = `pos' in `i'
    local nstr = strtrim(string(changes[`i'], "%9.0fc"))
    local gnm = group[`i']
    local ylab `"`ylab' `pos' "`gnm' (`nstr')""'
}
local ymax = `pos' + 0.5
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
    replace refy = `ymax' in `=`n0' + 2*`p''
}
quietly summarize lo
local dlo = 50 - r(min)
quietly summarize hi
local dhi = r(max) - 50
local half = max(10, 5 * ceil((max(`dlo', `dhi') + 3) / 5))
local xlo = 50 - `half'
local xhi = 50 + `half'
local xstep = cond(`half' > 20, 20, 10)       // fewer labels on a wide axis
local xs  = `xstep' * floor(`half' / `xstep')
display "   x range `xlo'-`xhi'"
sort panel refy y

twoway (rspike lo hi y if answered == 1, horizontal lcolor(black) lwidth(thin)) ///
    (rspike lo hi y if answered == 0, horizontal lcolor(gs9) lwidth(thin)) ///
    (scatter y pct if answered == 1, msymbol(O) mcolor(black) msize(vsmall)) ///
    (scatter y pct if answered == 0, msymbol(Oh) mcolor(gs7) msize(vsmall)) ///
    (scatter y labx if answered == 1, msymbol(none) mlabel(plab) mlabvposition(labp) mlabgap(0.6) mlabsize(vsmall) mlabcolor(gs5)) ///
    (scatter y labx if answered == 0, msymbol(none) mlabel(plab) mlabvposition(labp) mlabgap(0.6) mlabsize(vsmall) mlabcolor(gs9)) ///
    (line refy refx, lpattern(dash) lcolor(gs8) lwidth(thin)), ///
    by(panel, rows(1) graphregion(color(white) lcolor(white) ilcolor(white)) legend(pos(6)) scale(0.8125) ///
        title("Figure R3-05. Do firms with environmental permits, waste treatment, R&D or innovation cut energy and CO2 more often?" ///
              "Share of one-year changes that fell more (or rose less) than the typical answering firm's change that year", size(small) pos(11) span) ///
        note("Notes: The survey never asks why; these answers are stand-ins (rules faced, capacity to change). Shows who, not why. GJ = gigajoules." ///
             "Dot = share of the group's one-year changes that fell more or rose less than the typical (median) change of firms answering the question that year." ///
             "50% = same as that typical firm; where a 95% interval crosses the dashed line, the group is not clearly different from it. Compare 'Yes' with 'No'." ///
             "Hollow gray = no answer recorded, never counted as 'No'. These records can differ in other ways, so their distance from 50% is not a result." ///
             "`fbnote'" ///
             "`provnote'VA = value added = output minus materials, energy and services bought (current prices)." ///
             "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6))) ///
    subtitle(, pos(11) nobox fcolor(white) lcolor(white) size(small)) ///
    yscale(reverse noline range(-0.3 `ymax')) ylabel(`ylab', angle(0) noticks tlength(0) nogrid labsize(vsmall)) ytitle("") ///
    xscale(range(`xlo' `xhi') lcolor(gs10)) ///
    xlabel(`=50 - `xs''(`xstep')`=50 + `xs'', noticks tlength(0) labsize(vsmall) grid glcolor(gs15) glwidth(vthin)) ///
    xtitle("Changes that fell more or rose less than the typical answering firm's that year (% of the group's changes)", size(vsmall)) ///
    legend(order(3 "Share (%)" 1 "95% interval" 4 "No answer recorded" 7 "50% = same as the typical firm that answered") rows(1) region(lcolor(none)) ///
        size(vsmall) symxsize(8) keygap(1) colgap(6)) ///
    plotregion(style(none)) xsize(10) ysize(8.5)

graph export "figures/05_motivation_proxies.png", width(3000) replace
graph export "figures/05_motivation_proxies.pdf", replace


*---------------------------------------------------------------------------
display "Step 9/9: companion table: every plotted point"
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
* Source: the answer table saved right after the CSV export (full precision,
* same run as the chart). One row per point, in chart order: panel (a) to (d),
* questions and answers top to bottom. The three single-document rows (AMDAL,
* UKL-UPL, SPPL held) are CSV-only checks, not chart positions, and are not
* listed; the regressions of tables/05_motivation_proxies_fe.csv are not drawn.
use `ctsrc', clear
keep if in_figure
sort row_order
local nrow = _N
expand 4
bysort row_order: gen byte panel = _n
sort panel row_order
gen str30 t_panel = cond(panel == 1, "(a) Energy per unit of VA", cond(panel == 2, "(b) CO2 per unit of VA", ///
                    cond(panel == 3, "(c) Energy use (GJ)", "(d) CO2 emitted (tonnes)")))
* question header exactly as on the chart's axis: name (years of the answers[, provisional])
gen str80 t_q = ""
forvalues i = 1/`=_N' {
    local fnm = family[`i']
    local afr = answers_from[`i']
    if `allprov_`fnm'' local afr "`afr', provisional"
    quietly replace t_q = question[`i'] + " (`afr')" in `i'
}
gen str30 t_grp = group
gen double v  = cond(panel == 1, pct_energy_va, cond(panel == 2, pct_co2_va, cond(panel == 3, pct_energy, pct_co2)))
gen double lo = cond(panel == 1, lo_energy_va,  cond(panel == 2, lo_co2_va,  cond(panel == 3, lo_energy,  lo_co2)))
gen double hi = cond(panel == 1, hi_energy_va,  cond(panel == 2, hi_co2_va,  cond(panel == 3, hi_energy,  hi_co2)))
* rounding as the chart labels (one decimal)
gen str12 t_v  = string(v,  "%9.1f") if !missing(v)
gen str12 t_lo = string(lo, "%9.1f") if !missing(lo)
gen str12 t_hi = string(hi, "%9.1f") if !missing(hi)
gen str12 t_ch = string(changes, "%12.0fc")
gen str12 t_f  = string(firms, "%12.0fc")
gen str60 t_status = cond(answered == 1, "drawn: solid dot", "drawn: hollow gray (no answer)")
* checks: one row per drawn point, each with a number and an interval
assert t_v != "" & t_lo != "" & t_hi != ""
assert _N == 4 * `nrow'
* notes: the chart's notes, how to read the table, Source, development-data line
local ntext "Notes: The survey never asks why; these answers are stand-ins (rules faced, capacity to change). Shows who, not why. GJ = gigajoules."
local ntext "`ntext' Dot = share of the group's one-year changes that fell more or rose less than the typical (median) change of firms answering the question that year."
local ntext "`ntext' 50% = same as that typical firm; where a 95% interval crosses the dashed line, the group is not clearly different from it. Compare 'Yes' with 'No'."
local ntext "`ntext' Hollow gray = no answer recorded, never counted as 'No'. These records can differ in other ways, so their distance from 50% is not a result."
local ntext "`ntext' `fbnote'"
local ntext "`ntext' `provnote'VA = value added = output minus materials, energy and services bought (current prices)."
local ntext = itrim(`"`ntext'"')
local tnote "Table: every point of Figure R3-05, panel by panel, answers top to bottom; rounded as the chart labels. 95% interval"
local tnote "`tnote' clustered by firm. Changes = one-year changes with that answer (the number on the chart); Firms = firms behind them."
local tnote "`tnote' Gaps against the reference answer, checks and the single-document rows: tables/05_motivation_proxies.csv."
ctable_pdf t_panel t_q t_grp t_v t_lo t_hi t_ch t_f t_status using "tables/05_motivation_proxies_table.pdf", ///
    title("Table R3-05. Share of one-year changes that fell more (or rose less) than the typical answering firm's, by permit, waste treatment, R&D and innovation answer: every plotted point") ///
    header("Panel" "Question (answers from)" "Answer at start" "Share|(%)" "95%|low" "95%|high" "Changes" "Firms" "Status") ///
    right(4 5 6 7 8) norepeat(1 2) fontsize(9) rules(`nrow' `=2*`nrow'' `=3*`nrow'') perpage(`nrow') ///
    notes("`ntext'" "`tnote'" "`srcnote'" "`devnote'")
display "table -> tables/05_motivation_proxies_table.pdf"
* --- end of PART 2 ------------------------------------------------------------

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/05_motivation_proxies.png (elapsed `elapsed' s)"
quietly log close
