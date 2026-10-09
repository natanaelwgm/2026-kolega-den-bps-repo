/*==========================================================================
  Line 16: "Follow recovery sampai 2022"
  Data  : data/b20_si.dta (clean == 1) + data/b20_traj.dta (from 09-14)
  Follows the 2019 cohort, per trajectory and all together, from 2017 to
  2022 (2017-18 show the pre-covid trend).
  Output sheet:
    t16_index   per trajectory x year: n firms present, total and median of
                workers, VA and output, and each as an index (2019 = 100)
  Read with care:
    - firms that are gone add nothing, so a group's total falls when its
      firms leave (e.g. "Disappear in 2020" has nothing after 2019). Use the
      medians, or groups 3 and 4 (present in 2019, 2020 and 2022), to see
      how the firms that stayed recovered.
    - VA and output are nominal (and masked in the development data):
      part of any rise to 2022 is prices.
  FIRM LINKS ARE FICTIONAL IN THE DEVELOPMENT DATA: following the cohort
  only means something on the real BPS data.
==========================================================================*/
if "$B20" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B20_DATA/b20_si.dta", clear
keep if clean == 1 & inrange(year, 2017, 2022)
merge m:1 firm_id using "$B20_DATA/b20_traj.dta", nogenerate keep(match) keepusing(traj)

* copy every row as group 0 = all 2019 cohort firms
expand 2, generate(copy)
replace traj = 0 if copy == 1
label define traj 0 "All 2019 cohort", add

generate n_firms = 1
collapse (sum) n_firms tot_workers = workers tot_va = va tot_output = output ///
         (p50) med_workers = workers med_va = va med_output = output, by(traj year)

* index: 2019 = 100, within each trajectory
foreach v in n_firms tot_workers tot_va tot_output med_workers med_va med_output {
    generate base = `v' if year == 2019
    bysort traj: egen base_`v' = max(base)
    generate idx_`v' = 100 * `v' / base_`v'
    drop base base_`v'
}
sort traj year
order traj year n_firms idx_n_firms
list traj year n_firms idx_n_firms idx_tot_workers idx_med_workers, clean noobs sepby(traj)
export excel using "$B20_XLSX", sheet("t16_index", replace) firstrow(variables)
