/*==========================================================================
  _charts.do -- helper: chart programs for the figures file

  Load once at the top of the figures file, after setting
      global FIG_XLSX  the block's tables workbook (charts read only from it)
      global FIG_OUT   the block's output folder

  Programs:
    ch_wide    load one statistic from a table sheet, by year, one column
               per group (s1 s2 ...); returns locals `wide' and `glabels'
    ch_lines   by-year lines: 2016 band, first/last labels, legend
    ch_qlines  lines over quintiles 1-5 (no year axis), first/last labels
    ch_dots    pooled dot plot per group, sorted, value labels
    ch_shares  pooled % of firm-years per category (horizontal bars)
    ch_profile pooled % exporting / importing / FDI / ... per group
    ch_counts  firm-years per year (bars with counts, 2016 band)

  Chart rules (repo consensus, WRITING-PREFERENCES-SEE-HERE.md):
    - lines are labelled at their first and last point only; bars and dots
      carry their value; labels are formatted from the table cells
    - 2016 has no survey file: lines break there and a gray band marks it,
      with a "No annual file" key in the legend
    - every chart has a legend, a Notes line and a separate Source line
    - fixed precision per unit (set by the caller with fmt())
    - the points of every chart, and the printed labels, are written to a
      sheet figNN_data in the same workbook
==========================================================================*/
global FIG_SRC "Source: SI 2010-2022 analysis-ready data (block 0; obscured values, fictional firm links); authors' calculations."
global C1 "42 120 214"      // blue
global C2 "235 104 52"      // orange
global C3 "27 175 122"      // green
global C4 "150 90 190"      // purple
global BAND "gs14"          // 2016 band
global GOPT "scheme(s1color) graphregion(color(white)) plotregion(color(white)) xsize(7) ysize(4.5)"

* ---------------------------------------------------------------------------
* ch_wide, sheet(t08_tfp) key(group) stat(mean) [var(tfp_lp) filter(...) scale(100)]
*   key   = column whose values become the series (group, category or variable)
*   var   = keep only this variable (for _sumstats sheets)
*   filter= any extra keep-if condition
*   Series keep the order of the table (= the group codes).
* ---------------------------------------------------------------------------
capture program drop ch_wide
program define ch_wide
    syntax, SHEET(string) KEY(string) STAT(string) [VAR(string) FILTER(string asis) SCALE(real 1)]
    import excel using "$FIG_XLSX", sheet("`sheet'") firstrow clear
    foreach v in group category {
        capture confirm variable `v'
        if !_rc {
            capture confirm string variable `v'
            if _rc tostring `v', replace
        }
    }
    if "`var'" != "" keep if variable == "`var'"
    if `"`filter'"' != "" keep if `filter'
    keep if period != "pool"
    generate long order = _n
    bysort `key' (order): generate long first = order[1]
    egen gid = group(first)
    local labs ""
    local wide ""
    quietly levelsof gid, local(ids)
    foreach i of local ids {
        quietly levelsof `key' if gid == `i', local(g) clean
        local labs `"`labs' `"`g'"'"'
        local wide "`wide' s`i'"
    }
    generate year = real(period)
    generate double s = `stat' * `scale'
    keep year gid s
    reshape wide s, i(year) j(gid)
    c_local glabels `"`labs'"'
    c_local wide "`wide'"
end

* ---------------------------------------------------------------------------
* ch_endlabels s1 s2, x(year) fmt(%4.2f) gap(0.1)
*   appends one row per printed label: _lk (series number), _lx, _ly (where
*   the label is drawn), _lpos (9 = left of the first point, 3 = right of
*   the last point) and _ltxt (the printed value). Labels at the same end
*   that would overlap are moved apart vertically by at least gap; the
*   printed value itself never changes.
* ---------------------------------------------------------------------------
capture program drop ch_endlabels
program define ch_endlabels
    syntax varlist, X(varname) FMT(string) GAP(real)
    tempfile main labs
    quietly save `main'
    local k 0
    foreach s of local varlist {
        local ++k
        use `main', clear
        keep `x' `s'
        drop if missing(`s') | missing(`x')
        quietly summarize `x'
        local xmin = r(min)
        local xmax = r(max)
        keep if inlist(`x', `xmin', `xmax')
        generate byte _lk = `k'
        generate byte _lpos = cond(`x' == `xmin' & `xmin' != `xmax', 9, 3)
        rename `x' _lx
        rename `s' _lv
        generate str16 _ltxt = strtrim(string(_lv, "`fmt'"))
        keep _lk _lx _lv _lpos _ltxt
        if `k' > 1 append using `labs'
        quietly save `labs', replace
    }
    generate double _ly = _lv
    sort _lpos _lx _lv _lk
    by _lpos _lx: replace _ly = max(_ly, _ly[_n-1] + `gap') if _n > 1
    keep _lk _lx _ly _lpos _ltxt
    quietly save `labs', replace
    use `main', clear
    append using `labs'
end

* ---------------------------------------------------------------------------
* ch_lines s1 s2, labels("A" "B") fmt(%4.2f) ytitle() title() note("Notes: ..." "$FIG_SRC") sheet() file()
*   data in memory: year s1 [s2 [s3 [s4]]], one row per survey year
* ---------------------------------------------------------------------------
capture program drop ch_lines
program define ch_lines
    syntax varlist(min=1 max=4), LABELS(string asis) FMT(string) YTITLE(string) ///
        TITLE(string) NOTE(string asis) SHEET(string) FILE(string)
    local colors `""$C1" "$C2" "$C3" "$C4""'
    local symbols "O S T D"
    * printed labels: first and last available year of each series
    foreach s of local varlist {
        quietly summarize year if !missing(`s')
        generate str16 lab_`s' = strtrim(string(`s', "`fmt'")) if !missing(`s') & inlist(year, r(min), r(max))
    }
    * graph-ready data, with the printed labels
    preserve
    sort year
    export excel using "$FIG_XLSX", sheet("`sheet'", replace) firstrow(variables)
    restore
    * 2016 band spans the plotted range
    local lo .
    local hi .
    foreach s of local varlist {
        quietly summarize `s'
        if r(min) < `lo' | `lo' == . local lo = r(min)
        if r(max) > `hi' | `hi' == . local hi = r(max)
    }
    local pad = (`hi' - `lo') * 0.12
    if `pad' == 0 local pad = abs(`hi') * 0.1 + 1
    local lo = `lo' - `pad'
    local hi = `hi' + `pad'
    quietly count if year == 2016
    if r(N) == 0 {
        quietly set obs `=_N + 1'
        quietly replace year = 2016 in `=_N'
    }
    generate band_lo = `lo' if year == 2016
    generate band_hi = `hi' if year == 2016
    sort year
    * label anchors: first value left of the line, last value right of it
    ch_endlabels `varlist', x(year) fmt(`fmt') gap(`=(`hi' - `lo') * 0.06')
    quietly summarize _ly
    if r(max) > `hi' local hi = r(max)
    * plots: 1 = band, 2..k+1 = lines, then the label layers
    local plots "(rbar band_lo band_hi year, barwidth(0.8) color($BAND) lwidth(none))"
    local k 0
    foreach s of local varlist {
        local ++k
        local col : word `k' of `colors'
        local sym : word `k' of `symbols'
        local plots `"`plots' (connected `s' year, lcolor("`col'") mcolor("`col'") msymbol(`sym') lwidth(medthick) cmissing(n))"'
    }
    local k 0
    foreach s of local varlist {
        local ++k
        local col : word `k' of `colors'
        local plots `"`plots' (scatter _ly _lx if _lk == `k', msymbol(none) mlabel(_ltxt) mlabvposition(_lpos) mlabcolor("`col'") mlabsize(small))"'
    }
    local order ""
    local k 1
    foreach l of local labels {
        local ++k
        local order `"`order' `k' `"`l'"'"'
    }
    local rows = cond(`k' <= 4, 1, 2)
    twoway `plots', ///
        legend(order(`order' 1 "No annual file") rows(`rows') size(small) region(lcolor(white))) ///
        yscale(range(`lo' `hi')) ylabel(, angle(0) labsize(small) format(`fmt')) ///
        xscale(range(2008.4 2023.6)) xlabel(2010(2)2022, labsize(small)) xtitle("") ///
        ytitle("`ytitle'", size(small) margin(0 3 0 0)) ///
        title("`title'", size(medsmall)) note(`note', size(vsmall)) $GOPT
    graph export "$FIG_OUT/`file'.png", replace width(2200)
end

* ---------------------------------------------------------------------------
* ch_qlines s1 s2, labels() fmt() ytitle() xtitle() title() note() sheet() file()
*   data in memory: quintile (1-5) s1 [s2 [s3 [s4]]]
* ---------------------------------------------------------------------------
capture program drop ch_qlines
program define ch_qlines
    syntax varlist(min=1 max=4), LABELS(string asis) FMT(string) YTITLE(string) XTITLE(string) ///
        TITLE(string) NOTE(string asis) SHEET(string) FILE(string)
    local colors `""$C1" "$C2" "$C3" "$C4""'
    local symbols "O S T D"
    foreach s of local varlist {
        quietly summarize quintile if !missing(`s')
        generate str16 lab_`s' = strtrim(string(`s', "`fmt'")) if !missing(`s') & inlist(quintile, r(min), r(max))
    }
    sort quintile
    export excel using "$FIG_XLSX", sheet("`sheet'", replace) firstrow(variables)
    local lo .
    local hi .
    foreach s of local varlist {
        quietly summarize `s'
        if r(min) < `lo' | `lo' == . local lo = r(min)
        if r(max) > `hi' | `hi' == . local hi = r(max)
    }
    local gap = (`hi' - `lo') * 0.05
    if `gap' == 0 local gap = abs(`hi') * 0.05 + 0.01
    ch_endlabels `varlist', x(quintile) fmt(`fmt') gap(`gap')
    local plots ""
    local k 0
    foreach s of local varlist {
        local ++k
        local col : word `k' of `colors'
        local sym : word `k' of `symbols'
        local plots `"`plots' (connected `s' quintile, lcolor("`col'") mcolor("`col'") msymbol(`sym') lwidth(medthick))"'
    }
    local k 0
    foreach s of local varlist {
        local ++k
        local col : word `k' of `colors'
        local plots `"`plots' (scatter _ly _lx if _lk == `k', msymbol(none) mlabel(_ltxt) mlabvposition(_lpos) mlabcolor("`col'") mlabsize(small))"'
    }
    local order ""
    local k 0
    foreach l of local labels {
        local ++k
        local order `"`order' `k' `"`l'"'"'
    }
    twoway `plots', ///
        legend(order(`order') rows(1) size(small) region(lcolor(white))) ///
        xscale(range(0.3 5.7)) xlabel(1 "Q1 (lowest)" 2 "Q2" 3 "Q3" 4 "Q4" 5 "Q5 (highest)", labsize(small)) ///
        ylabel(, angle(0) labsize(small) format(`fmt')) xtitle("`xtitle'", size(small)) ///
        ytitle("`ytitle'", size(small) margin(0 3 0 0)) ///
        title("`title'", size(medsmall)) note(`note', size(vsmall)) $GOPT
    graph export "$FIG_OUT/`file'.png", replace width(2200)
end

* ---------------------------------------------------------------------------
* ch_dots, sheet() var() stat() fmt() xtitle() legend() title() note() outsheet() file() [minn(100) prefix("KBLI ")]
*   pooled value per group, sorted from high to low; groups with fewer than
*   minn firm-years are left out
* ---------------------------------------------------------------------------
capture program drop ch_dots
program define ch_dots
    syntax, SHEET(string) VAR(string) STAT(string) FMT(string) XTITLE(string) LEGEND(string) ///
        TITLE(string) NOTE(string asis) OUTSHEET(string) FILE(string) [MINN(integer 0) PREFIX(string)]
    import excel using "$FIG_XLSX", sheet("`sheet'") firstrow clear
    capture confirm string variable group
    if _rc tostring group, replace
    keep if variable == "`var'" & period == "pool" & n >= `minn'
    gsort -`stat'
    generate pos = _n
    generate str16 lab = strtrim(string(`stat', "`fmt'"))
    generate str48 name = "`prefix'" + group
    keep pos name n `stat' lab
    export excel using "$FIG_XLSX", sheet("`outsheet'", replace) firstrow(variables)
    local ylab ""
    forvalues i = 1/`=_N' {
        local ylab `"`ylab' `i' "`=name[`i']'""'
    }
    summarize `stat', meanonly
    local xlo = r(min) - 0.05 * (r(max) - r(min))
    local xhi = r(max) + 0.25 * (r(max) - r(min))
    local ys = min(9, max(4.5, 0.22 * _N + 2.5))
    local ns = cond(`ys' > 6, "tiny", "vsmall")
    twoway (scatter pos `stat', msymbol(O) mcolor("$C1") ///
            mlabel(lab) mlabpos(3) mlabsize(vsmall) mlabcolor(black)), ///
        legend(on order(1 "`legend'") size(small) region(lcolor(white))) ///
        ylabel(`ylab', angle(0) labsize(vsmall) nogrid) yscale(reverse range(0.5 `=_N + 0.5')) ///
        xscale(range(`xlo' `xhi')) xlabel(, labsize(small) format(`fmt')) ///
        ytitle("") xtitle("`xtitle'", size(small)) ///
        title("`title'", size(medsmall)) note(`note', size(`ns')) ///
        scheme(s1color) graphregion(color(white)) plotregion(color(white)) xsize(7) ysize(`ys')
    graph export "$FIG_OUT/`file'.png", replace width(2200)
end

* ---------------------------------------------------------------------------
* ch_shares, sheet() title() note() outsheet() file() [prefix() group()]
*   pooled % of firm-years per category from a _shares.do sheet
* ---------------------------------------------------------------------------
capture program drop ch_shares
program define ch_shares
    syntax, SHEET(string) TITLE(string) NOTE(string asis) OUTSHEET(string) FILE(string) ///
        [PREFIX(string) GROUP(string)]
    import excel using "$FIG_XLSX", sheet("`sheet'") firstrow clear
    foreach v in group category {
        capture confirm string variable `v'
        if _rc tostring `v', replace
    }
    keep if period == "pool"
    if "`group'" != "" keep if group == "`group'"
    gsort -pct_firms
    generate order = _n
    generate str16 lab = strtrim(string(pct_firms, "%4.1f"))
    generate str48 name = "`prefix'" + category
    keep order name n_firms pct_firms lab
    export excel using "$FIG_XLSX", sheet("`outsheet'", replace) firstrow(variables)
    summarize pct_firms, meanonly
    local hi = r(max) * 1.15
    local ys = min(9, max(4.5, 0.22 * _N + 2.5))
    local ns = cond(`ys' > 6, "tiny", "vsmall")
    graph hbar (asis) pct_firms, over(name, sort(order) label(labsize(vsmall))) ///
        bar(1, color("$C1")) blabel(bar, format(%4.1f) size(vsmall)) ///
        legend(on order(1 "% of firm-years (pooled)") size(small) region(lcolor(white))) ///
        ytitle("% of firm-years", size(small)) yscale(range(0 `hi')) ylabel(, labsize(small)) ///
        title("`title'", size(medsmall)) note(`note', size(`ns')) ///
        scheme(s1color) graphregion(color(white)) plotregion(color(white)) xsize(7) ysize(`ys')
    graph export "$FIG_OUT/`file'.png", replace width(2200)
end

* ---------------------------------------------------------------------------
* ch_profile, sheet() title() note() outsheet() file()
*   pooled % of each group that exports / imports / is FDI / large / does
*   R&D / is in Java (the means of the 0/1 variables of a _sumstats sheet)
* ---------------------------------------------------------------------------
capture program drop ch_profile
program define ch_profile
    syntax, SHEET(string) TITLE(string) NOTE(string asis) OUTSHEET(string) FILE(string)
    import excel using "$FIG_XLSX", sheet("`sheet'") firstrow clear
    capture confirm string variable group
    if _rc tostring group, replace
    keep if period == "pool"
    generate pct = 100 * mean
    generate str32 rate = ""
    replace rate = "Exporting"            if variable == "exporter"
    replace rate = "Importing"            if variable == "importer"
    replace rate = "FDI (>=10%)"          if variable == "fdi"
    replace rate = "Large (>100)"         if variable == "large"
    replace rate = "R&D (2017-22)"        if variable == "rnd"
    replace rate = "Java"                 if variable == "java"
    keep if rate != ""
    generate long order = _n
    bysort variable (order): generate long rate_order = order[1]
    bysort group (order): generate long group_order = order[1]
    generate str16 lab = strtrim(string(pct, "%4.1f"))
    sort rate_order group_order
    keep rate group n pct lab rate_order group_order
    export excel using "$FIG_XLSX", sheet("`outsheet'", replace) firstrow(variables)
    * groups in code order (same colours as the line charts), labelled by name
    egen gnum = group(group_order)
    quietly levelsof gnum, local(gs)
    local ng : word count `gs'
    foreach i of local gs {
        quietly levelsof group if gnum == `i', local(gname) clean
        label define gnum `i' `"`gname'"', add
    }
    label values gnum gnum
    local colors `""$C1" "$C2" "$C3" "$C4""'
    local bars ""
    forvalues k = 1/`=min(`ng', 4)' {
        local c : word `k' of `colors'
        local bars `"`bars' bar(`k', color("`c'"))"'
    }
    summarize pct, meanonly
    local hi = r(max) * 1.15
    graph hbar (asis) pct, over(gnum, label(labsize(vsmall))) ///
        over(rate, sort(rate_order) label(labsize(vsmall))) asyvars `bars' ///
        blabel(bar, format(%4.1f) size(vsmall)) ///
        legend(rows(1) size(small) region(lcolor(white))) ///
        ytitle("% of firm-years in the group (pooled)", size(small)) yscale(range(0 `hi')) ylabel(, labsize(small)) ///
        title("`title'", size(medsmall)) note(`note', size(tiny)) ///
        scheme(s1color) graphregion(color(white)) plotregion(color(white)) xsize(7) ysize(6)
    graph export "$FIG_OUT/`file'.png", replace width(2200)
end

* ---------------------------------------------------------------------------
* ch_counts, sheet() var() title() note() outsheet() file()
*   firm-years per year = n of a variable observed for every record
* ---------------------------------------------------------------------------
capture program drop ch_counts
program define ch_counts
    syntax, SHEET(string) VAR(string) TITLE(string) NOTE(string asis) OUTSHEET(string) FILE(string)
    import excel using "$FIG_XLSX", sheet("`sheet'") firstrow clear
    keep if variable == "`var'" & period != "pool"
    generate year = real(period)
    keep year n
    generate str16 lab_n = strtrim(string(n, "%9.0fc"))
    sort year
    export excel using "$FIG_XLSX", sheet("`outsheet'", replace) firstrow(variables)
    summarize n, meanonly
    local hi = r(max) * 1.15
    set obs `=_N + 1'
    replace year = 2016 in `=_N'
    generate band_hi = `hi' if year == 2016
    generate band_lo = 0 if year == 2016
    sort year
    twoway (rbar band_lo band_hi year, barwidth(0.8) color($BAND) lwidth(none)) ///
           (bar n year, barwidth(0.7) color("$C1")) ///
           (scatter n year, msymbol(none) mlabel(lab_n) mlabpos(12) mlabsize(vsmall) mlabcolor(black)), ///
        legend(order(2 "Firm-years in the file" 1 "No annual file") rows(1) size(small) region(lcolor(white))) ///
        yscale(range(0 `hi')) ylabel(, angle(0) labsize(small) format(%9.0fc)) ///
        xlabel(2010(2)2022, labsize(small)) xtitle("") ytitle("Firm-years", size(small) margin(0 3 0 0)) ///
        title("`title'", size(medsmall)) note(`note', size(vsmall)) $GOPT
    graph export "$FIG_OUT/`file'.png", replace width(2200)
end
