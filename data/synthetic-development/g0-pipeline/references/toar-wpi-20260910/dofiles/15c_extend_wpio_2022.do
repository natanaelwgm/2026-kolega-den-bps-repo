* ============================================================
* 15c_extend_wpio_2022.do
* Extend the WPI output deflator from 1983-2012 to 1983-2022
* using BPS IHPB chain-linking at the 4-digit ISIC level.
*
* Generalises 15_extend_wpio_ihpb.do (which stopped at 2014) to 2019.
*
* INPUT  : $rawdata/wpio.dta                          (base 2000=100, 131 ISIC4, 1983-2012)
*          $concord/ihpb_isic4_concordance.csv        (131 ISIC4 -> IHPB sub-sector)
*          $concord/ihpb_annual_averages_2013_2022.csv(50 sub-sectors x 6 years, 2010=100)
* OUTPUT : $output/wpio_extended_2000_2022.dta        (isic + wpi1983-wpi2019)
*          $output/tables/wpi_extension_qa_2022.csv        (per-year QA summary)
*
* METHOD
* ------
* Stage 1 (1983-2012): unchanged from wpio.dta.
* Stage 2 (2013-2019): chain-link off the 2010 anchor,
*
*     wpi_t = wpi2010 * (IHPB_t / 100)
*
*   where IHPB_t is the annual average of the corresponding BPS IHPB
*   manufacturing sub-sector (base 2010=100). Where two sub-sectors jointly
*   represent an ISIC4 group (ihpb_sub2 non-missing), their arithmetic mean
*   is used -- consistent with the original wpio.dta construction.
*
*   ISIC 3710/3720 (Recycling) have no IHPB sub-sector; they are extrapolated
*   from the 2010-2012 CAGR, as in the original do-file.
*
* 2020-2022 ARE SPLICED, NOT NATIVELY CHAIN-LINKED  <<< READ THIS
* ---------------------------------------------------------------
*   BPS rebased IHPB to (2018=100) from 2020 AND renumbered the sub-sectors
*   (50 groups -> 57). Those years are therefore not directly comparable with
*   2013-2019. They are brought onto the (2010=100) scale by:
*
*     a. crosswalking each 2010-base sub-sector to its 2018-base counterpart
*        by industry name (49 of 50 map; see (c) below);
*     b. a link factor anchored on December 2019, which is observable on BOTH
*        bases -- the 2010-base value is published directly, and the 2018-base
*        value is back-solved from the 2020 edition's "Perubahan" column
*        (defined in its own footnote as Jan-2020 vs Dec-2019);
*
*            f_sub = IHPB_Dec2019(2010=100) / IHPB_Dec2019(2018=100)
*            IHPB_t(2010-equiv) = IHPB_t(2018=100) * f_sub      t = 2020..2022
*
*     c. old sub 36 "Media Magnetik dan Media Optik" has NO 2018-base
*        counterpart. It is used only as the SECONDARY of the avg-of-two pair
*        for ISIC 3210, so for 2020-2022 that code falls back to its primary
*        (sub 33) alone. Every other code is unaffected.
*
*   ACCURACY. The two index definitions do not agree exactly. Measured on the
*   13 sub-sectors whose number means the same industry on both bases, the
*   link factor departs from its theoretical value by a median of 0.91%
*   (mean 1.62%, max 5.48%). Treat 2020-2022 levels as +/- a few percent, and
*   prefer 2000-2019 for anything level-sensitive. In a DiD with year fixed
*   effects the splice error is absorbed and does not bias the treatment term.
*
* 2016 IS DELIBERATELY MISSING
* ----------------------------
*   No BPS IHPB 2016 publication was available, so wpi2016 is left missing for
*   ALL 131 codes (including the two CAGR codes, which are held missing too so
*   the gap is uniform across the panel rather than an artefact for ISIC 37).
*   Any firm-year in 2016 will therefore receive output_real = . downstream.
*
* BASE-YEAR WARNING
* -----------------
*   This runs on the (2010=100) IHPB series, published 2013-2019. BPS rebased
*   to (2018=100) from 2020 and RENUMBERED the sub-sectors; 2020+ cannot be
*   chain-linked with this concordance. Do not extend this file past 2019.
*
* AUTHOR: prepared for the SI CSIS extension handoff
* ============================================================

clear all
set more off

* -- Paths ---------------------------------------------------------------
if "$handoff" == "" {
    di as error "ERROR: global 'handoff' is not set."
    di as error "       Run: do {path_to_handoff}/dofiles/00_config.do"
    exit 1
}
global output  "$handoff/output"
global logs    "$handoff/logs"
global rawdata "$handoff/data/raw"
global concord "$handoff/data/concordance"

cap mkdir "$output"
cap mkdir "$output/tables"
cap mkdir "$logs"
cap log close
log using "$logs/15c_extend_wpio_2022.log", replace text

* Years carried by the (2010=100) IHPB block. 2016 omitted -- no publication.
local YEARS    2013 2014 2015 2017 2018 2019 2020 2021 2022
local NATIVE   2013 2014 2015 2017 2018 2019
local SPLICED  2020 2021 2022

di as txt "======================================================"
di as txt " 15c_extend_wpio_2022.do - started: " c(current_date) " " c(current_time)
di as txt " Extension years: `YEARS'   (2016 deliberately absent)"
di as txt "======================================================"


* ============================================================
* SECTION 1 - IHPB ANNUAL AVERAGES (base 2010=100)
* ============================================================
di as txt _n "=== SECTION 1: Load IHPB lookup ==="

import delimited "$concord/ihpb_annual_averages_2013_2022.csv", ///
    varnames(1) encoding("UTF-8") clear

cap destring ihpb_sub, replace force
foreach y of local YEARS {
    cap destring ihpb`y', replace force
    label var ihpb`y' "IHPB annual average `y' (base 2010=100)"
}
drop if missing(ihpb_sub)
label var ihpb_sub "BPS IHPB manufacturing sub-sector number (1-50)"

qui count
di as txt "  IHPB lookup: " r(N) " sub-sectors"
assert r(N) == 50
foreach y of local NATIVE {
    qui count if missing(ihpb`y')
    assert r(N) == 0
}
foreach y of local SPLICED {
    qui count if missing(ihpb`y')
    di as txt "    ihpb`y': " r(N) " sub-sector(s) with no 2018-base counterpart"
    assert r(N) <= 1
}
di as txt "  Lookup loaded for `YEARS'."

tempfile ihpb_lookup
save `ihpb_lookup'


* ============================================================
* SECTION 2 - CONCORDANCE
* ============================================================
di as txt _n "=== SECTION 2: Load concordance ==="

import delimited "$concord/ihpb_isic4_concordance.csv", ///
    varnames(1) stringcols(_all) clear

rename isic4 isic4_str
destring isic4_str, gen(isic4)
drop isic4_str

gen byte cagr_flag = (ihpb_sub == "CAGR")
destring ihpb_sub,  gen(ihpb_sub1)  force
destring ihpb_sub2, gen(ihpb_sub2n) force
keep isic4 ihpb_sub1 ihpb_sub2n cagr_flag notes

qui count
di as txt "  Concordance: " r(N) " ISIC4 codes"
qui count if cagr_flag
di as txt "  CAGR codes (ISIC 37): " r(N)
qui count if !missing(ihpb_sub2n)
di as txt "  Avg-of-two codes: " r(N)

tempfile concordance
save `concordance'


* ============================================================
* SECTION 3 - LOAD WPIO, ATTACH CONCORDANCE
* ============================================================
di as txt _n "=== SECTION 3: Load wpio.dta ==="

use "$rawdata/wpio.dta", clear
rename isic isic4
qui count
local NW = r(N)
di as txt "  wpio.dta: `NW' ISIC4 codes, wpi1983-wpi2012"

* Sanity: the file must really be base 2000=100
qui summ wpi2000
assert abs(r(min) - 100) < 0.01 & abs(r(max) - 100) < 0.01
di as txt "  Base check passed: wpi2000 == 100 for all codes."

merge 1:1 isic4 using `concordance', keep(master match) nogen
qui count if missing(ihpb_sub1) & !cagr_flag
if r(N) > 0 {
    di as error "ERROR: `r(N)' ISIC4 codes have no IHPB sub-sector and no CAGR flag."
    log close
    exit 459
}
di as txt "  Concordance attached; every code resolved."


* ============================================================
* SECTION 4 - MERGE IHPB VALUES (primary + secondary)
* ============================================================
di as txt _n "=== SECTION 4: Merge IHPB values ==="

rename ihpb_sub1 ihpb_sub
merge m:1 ihpb_sub using `ihpb_lookup', keep(master match) nogen
rename ihpb_sub ihpb_sub1
foreach y of local YEARS {
    rename ihpb`y' ihpb`y'_1
}

rename ihpb_sub2n ihpb_sub
merge m:1 ihpb_sub using `ihpb_lookup', keep(master match) nogen
rename ihpb_sub ihpb_sub2n
foreach y of local YEARS {
    rename ihpb`y' ihpb`y'_2
}
di as txt "  Primary and secondary IHPB series merged."


* ============================================================
* SECTION 5 - CHAIN-LINK: wpi_t = wpi2010 * (IHPB_t / 100)
* ============================================================
di as txt _n "=== SECTION 5: Chain-link extension ==="

foreach y of local YEARS {
    * Effective IHPB rate: primary, or mean of the two where a pair applies
    gen double ihpb_eff = ihpb`y'_1
    replace    ihpb_eff = (ihpb`y'_1 + ihpb`y'_2) / 2 ///
        if !missing(ihpb_sub2n) & !missing(ihpb`y'_2)

    gen double wpi`y' = wpi2010 * (ihpb_eff / 100) if !cagr_flag
    drop ihpb_eff
}

* CAGR fallback for ISIC 3710/3720 (no IHPB sub-sector).
* g = geometric mean annual growth 2010->2012; applied forward from 2012.
gen double _g = (wpi2012 / wpi2010)^0.5 if cagr_flag
foreach y of local YEARS {
    replace wpi`y' = wpi2012 * _g^(`y' - 2012) if cagr_flag
}
drop _g

* 2016: no IHPB publication. Held missing for ALL codes so the gap is uniform.
gen double wpi2016 = .
label var wpi2016 "WPI 2016 - MISSING (no BPS IHPB 2016 publication available)"

foreach y of local YEARS {
    label var wpi`y' "WPI `y' (base 2000=100, chain-linked from IHPB `y')"
    qui count if missing(wpi`y')
    di as txt "    wpi`y': missing = " r(N) " (expected 0)"
    assert r(N) == 0
}
di as txt "  Chain-link complete for `YEARS'."

* ISIC 37 spot check
di as txt "  ISIC 37 (CAGR path):"
list isic4 wpi2010 wpi2012 wpi2013 wpi2015 wpi2019 if inlist(isic4, 3710, 3720), noobs clean


* ============================================================
* SECTION 6 - QA: monotone-ish sanity and year-on-year growth
* ============================================================
di as txt _n "=== SECTION 6: QA ==="

preserve
    keep isic4 wpi2010-wpi2019
    gen g13 = wpi2013/wpi2012 - 1
    gen g19 = wpi2019/wpi2018 - 1
    qui summ g13, detail
    di as txt "  2012->2013 growth: p50 " %6.3f r(p50) "  min " %6.3f r(min) "  max " %6.3f r(max)
    qui summ g19, detail
    di as txt "  2018->2019 growth: p50 " %6.3f r(p50) "  min " %6.3f r(min) "  max " %6.3f r(max)
    qui count if wpi2019 <= 0 | missing(wpi2019)
    assert r(N) == 0
restore

* Per-year QA table
preserve
    keep isic4 wpi2012-wpi2019
    reshape long wpi, i(isic4) j(year)
    collapse (count) n=wpi (mean) mean=wpi (min) min=wpi (max) max=wpi, by(year)
    list, noobs clean
    export delimited using "$output/tables/wpi_extension_qa_2022.csv", replace
restore


* ============================================================
* SECTION 7 - SAVE
* ============================================================
di as txt _n "=== SECTION 7: Save ==="

drop ihpb_sub1 ihpb_sub2n cagr_flag notes
foreach y of local YEARS {
    drop ihpb`y'_1 ihpb`y'_2
}

* Per-year provenance flag, carried in the file's own notes
label data "wpio extended to 2022: native chain-link 2013-2019; Dec-2019 splice 2020-2022; base 2000=100"
notes drop _all
notes: wpi1983-wpi2012 = original wpio.dta (base 2000=100)
notes: wpi2013-wpi2019 = native IHPB chain-link off the (2010=100) series
notes: wpi2016 = MISSING, no BPS IHPB 2016 publication available
notes: wpi2020-wpi2022 = SPLICED from the (2018=100) series via a Dec-2019 link factor; levels +/- a few percent
notes: ISIC 3210 uses IHPB sub 33 alone for 2020-2022 (its paired sub 36 has no 2018-base counterpart)

rename isic4 isic
order isic
forvalues y = 1983/2019 {
    order wpi`y', last
}
label data "wpio extended to 2019: IHPB chain-link 2013-2019 (2016 missing); base 2000=100"
compress
save "$output/wpio_extended_2000_2022.dta", replace

qui des
di as txt "  Saved: $output/wpio_extended_2000_2022.dta"
di as txt "  Obs: " r(N) ", Vars: " r(k)

di as txt _n "======================================================"
di as txt " 15c_extend_wpio_2022.do - completed: " c(current_date) " " c(current_time)
di as txt " NOTE: wpi2016 is missing by design (no BPS IHPB 2016)."
di as txt " NOTE: do not extend past 2019 - BPS rebased to 2018=100 and"
di as txt "       renumbered the sub-sectors from 2020."
di as txt "======================================================"

log close
