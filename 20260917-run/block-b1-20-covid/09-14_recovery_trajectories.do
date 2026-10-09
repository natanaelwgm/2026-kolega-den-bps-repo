/*==========================================================================
  Lines 9-14: "Resilience and recovery trajectories:" / "Classify firms menjadi:"
              "Disappear in 2020 and never return" / "Disappear temporarily then return"
              "Survive but shrink" / "Survive and grow"
  Data  : data/b20_firm.dta (presence, ALL rows) + data/b20_si.dta (size)
  Cohort: every firm_id present in 2019 (the last year before covid).

  Classification (every cohort firm gets exactly one):
    1 Disappear in 2020, never return  in 2019; absent in 2020, 2021 and 2022
    2 Disappear temporarily, return    in 2019; absent in 2020; back in 2021 or 2022
    3 Survive but shrink               in 2019, 2020 and 2022; workers 2022 <  2019
    4 Survive and grow                 in 2019, 2020 and 2022; workers 2022 >= 2019
    5 Survived 2020, gone by 2022      in 2019 and 2020; absent in 2022
    6 Survived, size not comparable    in 2019, 2020 and 2022; workers missing
                                       in 2019 or 2022
  Groups 5 and 6 are not in the to-do list but are needed so that every
  cohort firm is counted.
  Size measure: workers (main). The same split on value added and on gross
  output (nominal) is in t09_traj_by_measure.

  Output: data/b20_traj.dta  firm_id traj traj_va traj_output (used by 15, 16)
  Output sheets:
    t09_trajectories      n firms and % of the 2019 cohort per group, with
                          median workers 2019 and 2022
    t09_traj_by_measure   the same split with workers / VA / output as size
    t09_cohort_presence   % of the 2019 cohort present in 2020, 2021, 2022

  FIRM LINKS ARE FICTIONAL IN THE DEVELOPMENT DATA: these groups only mean
  something on the real BPS data. Group 2 is EMPTY in the development data
  because block 0 simulated every firm as present in an unbroken run of
  years (no gaps, see 01b). It is not a finding; the real data will fill it.
==========================================================================*/
if "$B20" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- size in 2019 and 2022, one row per firm ----
use "$B20_DATA/b20_si.dta", clear
keep if inlist(year, 2019, 2022)
keep firm_id year workers va output
rename (workers va output) (workers_ va_ output_)
reshape wide workers_ va_ output_, i(firm_id) j(year)
tempfile size
save `size'

* ---- the 2019 cohort ----
use "$B20_DATA/b20_firm.dta", clear
keep if in2019 == 1
merge 1:1 firm_id using `size', nogenerate keep(master match)

* loop: workers (main), va, output as the size measure
foreach m in workers va output {
    generate traj_`m' = .
    replace traj_`m' = 1 if in2020 == 0 & in2021 == 0 & in2022 == 0
    replace traj_`m' = 2 if in2020 == 0 & (in2021 == 1 | in2022 == 1)
    replace traj_`m' = 3 if in2020 == 1 & in2022 == 1 & `m'_2022 <  `m'_2019 & !missing(`m'_2019, `m'_2022)
    replace traj_`m' = 4 if in2020 == 1 & in2022 == 1 & `m'_2022 >= `m'_2019 & !missing(`m'_2019, `m'_2022)
    replace traj_`m' = 5 if in2020 == 1 & in2022 == 0
    replace traj_`m' = 6 if in2020 == 1 & in2022 == 1 & missing(`m'_2019, `m'_2022)
    assert !missing(traj_`m')         // every cohort firm is in one group
}
rename traj_workers traj
label define traj 1 "Disappear in 2020, never return" 2 "Disappear temporarily, return" ///
                  3 "Survive but shrink" 4 "Survive and grow" ///
                  5 "Survived 2020, gone by 2022" 6 "Survived, size not comparable"
label values traj traj_va traj_output traj
label variable traj "Covid trajectory of the 2019 cohort (size = workers)"
compress
save "$B20_DATA/b20_traj.dta", replace

* ---- A. counts per group ----
* a group with no firms still gets a row (0), so the table always has all 6
generate n_firms = 1
collapse (sum) n_firms (p50) med_workers_2019 = workers_2019 med_workers_2022 = workers_2022, by(traj)
tempfile counts
save `counts'
clear
set obs 6
generate traj = _n
label values traj traj
merge 1:1 traj using `counts', nogenerate
replace n_firms = 0 if missing(n_firms)
egen cohort = total(n_firms)
generate pct_of_cohort = 100 * n_firms / cohort
drop cohort
order traj n_firms pct_of_cohort
list, clean noobs
export excel using "$B20_XLSX", sheet("t09_trajectories", replace) firstrow(variables)

* ---- B. the same split with VA and output as the size measure ----
use "$B20_DATA/b20_traj.dta", clear
generate measure = "workers"
generate group = traj
tempfile long
save `long'
foreach m in va output {
    use "$B20_DATA/b20_traj.dta", clear
    generate measure = "`m'"
    generate group = traj_`m'
    append using `long'
    save `long', replace
}
label values group traj
generate n_firms = 1
collapse (sum) n_firms, by(measure group)
bysort measure: egen cohort = total(n_firms)
generate pct_of_cohort = 100 * n_firms / cohort
drop cohort
sort measure group
list, clean noobs sepby(measure)
export excel using "$B20_XLSX", sheet("t09_traj_by_measure", replace) firstrow(variables)

* ---- C. how much of the 2019 cohort is still there ----
use "$B20_DATA/b20_traj.dta", clear
generate cohort_2019 = 1
collapse (sum) cohort_2019 in2020 in2021 in2022
foreach y in 2020 2021 2022 {
    generate pct_in`y' = 100 * in`y' / cohort_2019
}
list, clean noobs
export excel using "$B20_XLSX", sheet("t09_cohort_presence", replace) firstrow(variables)
