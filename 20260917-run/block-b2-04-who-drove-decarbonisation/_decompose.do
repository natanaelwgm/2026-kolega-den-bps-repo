/*==========================================================================
  _decompose.do -- helper: FHK (2001) and Melitz-Polanec (2015) decomposition
                   of the change in an aggregate intensity between two years

  Usage:
      do "$B204/_decompose.do" co2_va 2010 2022
      do "$B204/_decompose.do" co2_va 2010 2021 "exporter == 1" "Exporter"

      argument 1 = indicator: co2_va (CO2 / VA, carbon intensity)
                              gj_va  (GJ / VA,  energy intensity)
      argument 2 = start year (t0)
      argument 3 = end year   (t1)
      argument 4 = optional condition that defines the group, e.g. "fdi == 1"
                   (applied to each firm-year, so a firm that changes group
                   leaves one group and enters the other)
      argument 5 = optional group label for the table ("All firms" if empty)

  Result: ONE row is appended to data/b204_decomp_rows.dta. The calling file
  erases that file first and exports it at the end. The helper loads the data
  itself, so nothing needs to be in memory.

  The aggregate intensity in year t is
      I_t = sum_i s_it * phi_it  = total CO2 / total VA
      phi_it = firm intensity (CO2_it / VA_it)
      s_it   = firm share of the group's VA in year t
  Firms are matched by firm_id:
      continuers (C) = in t0 and t1, entrants (N) = t1 only, exiters (X) = t0 only
  FIRM LINKS ARE FICTIONAL IN THE DEVELOPMENT DATA: the split into continuers,
  entrants and exiters, and so every term below, only means something on the
  real BPS data. The total change (I_t1 - I_t0) does not depend on the links.

  FHK (Foster, Haltiwanger and Krizan 2001), with I_t0 as the reference:
      within  = sum_C s_i0 * (phi_i1 - phi_i0)
      between = sum_C (phi_i0 - I_t0) * (s_i1 - s_i0)
      cross   = sum_C (s_i1 - s_i0) * (phi_i1 - phi_i0)
      entry   = sum_N s_i1 * (phi_i1 - I_t0)
      exit    = - sum_X s_i0 * (phi_i0 - I_t0)
  Melitz-Polanec (2015):
      survivors' mean      = change in the unweighted mean of phi among C
      survivors' covariance = change in sum_C (s_i/S_C - 1/n_C) * (phi_i - mean phi)
      entry = S_N1 * (I_N1 - I_C1)      S = group share, I = group intensity
      exit  = S_X0 * (I_C0 - I_X0)
  Both sets of components must add up to I_t1 - I_t0; the difference is
  displayed and written to the table (column fhk_diff, mp_diff).
==========================================================================*/
args ind y0 y1 cond label
if "`cond'" == ""  local cond "1 == 1"
if "`label'" == "" local label "All firms"

* ---- which numerator / denominator ------------------------------------
if "`ind'" == "co2_va" {
    local num co2_total
    local den va
    local ind_label "CO2 / VA (carbon intensity)"
}
else if "`ind'" == "gj_va" {
    local num gj_total
    local den va
    local ind_label "GJ / VA (energy intensity)"
}
else {
    display as error "_decompose.do: unknown indicator `ind' (use co2_va or gj_va)"
    exit 198
}

* ---- the firms in the two years ---------------------------------------
use "$B204_DATA/b204_si.dta", clear
keep if clean == 1 & inlist(year, `y0', `y1') & (`cond')
keep if `den' > 0 & !missing(`den') & !missing(`num')
quietly count if year == `y0'
local n_t0 = r(N)
quietly count if year == `y1'
local n_t1 = r(N)
if `n_t0' == 0 | `n_t1' == 0 {
    display as error "  `label', `ind' `y0'-`y1': no firms in one of the two years, nothing written"
    exit
}
keep firm_id year `num' `den'

* ---- firm intensity (phi), firm share (s), aggregate intensity (I) -----
generate double phi = `num' / `den'
bysort year: egen double den_total = total(`den')
generate double s = `den' / den_total
generate double s_phi = s * phi
quietly summarize s_phi if year == `y0', meanonly
local I0 = r(sum)                                  // I_t0 = sum s_i0 * phi_i0
quietly summarize s_phi if year == `y1', meanonly
local I1 = r(sum)                                  // I_t1 = sum s_i1 * phi_i1
local dI = `I1' - `I0'                             // total change to decompose

* ---- one row per firm: s0 phi0 (start year), s1 phi1 (end year) -------
generate t = cond(year == `y0', 0, 1)
keep firm_id t s phi
reshape wide s phi, i(firm_id) j(t)
generate status = 1 if !missing(s0) & !missing(s1)       // continuer
replace  status = 2 if  missing(s0) & !missing(s1)       // entrant
replace  status = 3 if !missing(s0) &  missing(s1)       // exiter
quietly count if status == 1
local n_cont = r(N)
quietly count if status == 2
local n_entry = r(N)
quietly count if status == 3
local n_exit = r(N)

* ---- FHK: one term per firm, then summed --------------------------------
generate double fhk_within  = s0 * (phi1 - phi0)          if status == 1   // within
generate double fhk_between = (phi0 - `I0') * (s1 - s0)   if status == 1   // between
generate double fhk_cross   = (s1 - s0) * (phi1 - phi0)   if status == 1   // cross
generate double fhk_entry   = s1 * (phi1 - `I0')          if status == 2   // entry
generate double fhk_exit    = -s0 * (phi0 - `I0')         if status == 3   // exit
foreach c in within between cross entry exit {
    quietly summarize fhk_`c', meanonly
    local fhk_`c' = r(sum)
}
local fhk_sum = `fhk_within' + `fhk_between' + `fhk_cross' + `fhk_entry' + `fhk_exit'

* ---- Melitz-Polanec ------------------------------------------------------
* group shares: S_C0, S_X0 (start year), S_C1, S_N1 (end year)
quietly summarize s0 if status == 1, meanonly
local S_C0 = r(sum)
quietly summarize s0 if status == 3, meanonly
local S_X0 = r(sum)
quietly summarize s1 if status == 1, meanonly
local S_C1 = r(sum)
quietly summarize s1 if status == 2, meanonly
local S_N1 = r(sum)
* group intensities: I_g = sum_g s_i * phi_i / S_g
generate double sphi0 = s0 * phi0
generate double sphi1 = s1 * phi1
quietly summarize sphi0 if status == 1, meanonly
local I_C0 = r(sum) / `S_C0'
quietly summarize sphi1 if status == 1, meanonly
local I_C1 = r(sum) / `S_C1'
quietly summarize sphi0 if status == 3, meanonly
local I_X0 = cond(`S_X0' > 0, r(sum) / `S_X0', 0)
quietly summarize sphi1 if status == 2, meanonly
local I_N1 = cond(`S_N1' > 0, r(sum) / `S_N1', 0)
* survivors: I_C = unweighted mean of phi + covariance term (Olley-Pakes)
quietly summarize phi0 if status == 1, meanonly
local mean0 = r(mean)
quietly summarize phi1 if status == 1, meanonly
local mean1 = r(mean)
generate double cov0 = (s0 / `S_C0' - 1 / `n_cont') * (phi0 - `mean0') if status == 1
generate double cov1 = (s1 / `S_C1' - 1 / `n_cont') * (phi1 - `mean1') if status == 1
quietly summarize cov0, meanonly
local cov0 = r(sum)
quietly summarize cov1, meanonly
local cov1 = r(sum)
local mp_mean  = `mean1' - `mean0'                          // within (survivors' mean)
local mp_cov   = `cov1' - `cov0'                            // reallocation (survivors' covariance)
local mp_entry = cond(`S_N1' > 0, `S_N1' * (`I_N1' - `I_C1'), 0)   // entry
local mp_exit  = cond(`S_X0' > 0, `S_X0' * (`I_C0' - `I_X0'), 0)   // exit
local mp_sum   = `mp_mean' + `mp_cov' + `mp_entry' + `mp_exit'
if `n_cont' == 0 {
    display as error "  no continuers: the Melitz-Polanec survivor terms cannot be computed"
}

* ---- the check: components must add up to the total change -------------
local fhk_diff = `dI' - `fhk_sum'
local mp_diff  = `dI' - `mp_sum'
display as result "  `label' | `ind' `y0'-`y1' | continuers `n_cont', entrants `n_entry', exiters `n_exit'"
display as result "    total change " %10.3g `dI' "   FHK sum " %10.3g `fhk_sum' "   difference " %9.2g `fhk_diff'
display as result "    total change " %10.3g `dI' "   MP sum  " %10.3g `mp_sum'  "   difference " %9.2g `mp_diff'
if abs(`fhk_diff') > 1e-9 * max(abs(`dI'), abs(`I0')) | abs(`mp_diff') > 1e-9 * max(abs(`dI'), abs(`I0')) {
    display as error "  WARNING: the components do not add up to the total change (see diff)"
}

* ---- write one result row --------------------------------------------
clear
set obs 1
generate str40 group     = "`label'"
generate str40 condition = "`cond'"
generate str32 indicator = "`ind_label'"
generate str9  period    = "`y0'-`y1'"
generate year_from = `y0'
generate year_to   = `y1'
generate n_firms_t0   = `n_t0'
generate n_firms_t1   = `n_t1'
generate n_continuers = `n_cont'
generate n_entrants   = `n_entry'
generate n_exiters    = `n_exit'
generate double I_t0   = `I0'
generate double I_t1   = `I1'
generate double change = `dI'
foreach c in within between cross entry exit sum diff {
    generate double fhk_`c' = `fhk_`c''
}
foreach c in mean cov entry exit sum diff {
    generate double mp_`c' = `mp_`c''
}
* the shares of VA behind the entry and exit terms
generate double share_va_entrants_t1 = `S_N1'
generate double share_va_exiters_t0  = `S_X0'
* add the row at the bottom of the results file (create it on the first call)
tempfile row
save `row'
capture confirm file "$B204_DATA/b204_decomp_rows.dta"
if _rc == 0 {
    use "$B204_DATA/b204_decomp_rows.dta", clear
    append using `row'
}
save "$B204_DATA/b204_decomp_rows.dta", replace
