/*==========================================================================
  Line 15: "Compare pre covid characteristics: TFP, export import, fdi size,
            energy intensity, self generation, location"
  Data  : each 2019 cohort firm's 2019 record (data/b20_si.dta, clean == 1)
          + its trajectory (data/b20_traj.dta, from 09-14)
  Output sheets:
    t15_profile    per trajectory: n firms, % exporter, % importer, % FDI,
                   % large, % Java, % own generation, medians of workers, VA,
                   VA per worker, TFP (op, lp, acf, wrdg), energy per VA and
                   per output, CO2 per VA, own-generation share
    t15_stats      n mean sd p10-p90 min max of the same (level and ln) per
                   trajectory (only 2019, so "pool" = 2019)
    t15_province   share of each trajectory's firms by province
  Self generation: has_owngen = some own-generated electricity;
                   owngen_share = own / (own + purchased) kWh.
  FIRM LINKS ARE FICTIONAL IN THE DEVELOPMENT DATA: the trajectory groups
  only mean something on the real BPS data. In the development data block 0
  matched firms across years within province x industry cells, so location
  and sector differences between groups here reflect the simulation.
  TFP: development residuals; tfp_op has far fewer observations.
==========================================================================*/
if "$B20" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B20_DATA/b20_si.dta", clear
keep if year == 2019 & clean == 1
merge 1:1 firm_id using "$B20_DATA/b20_traj.dta", nogenerate keep(match) keepusing(traj)
tempfile pre
save `pre'

* ---- A. profile per trajectory ----
generate n_firms = 1
collapse (sum) n_firms (mean) pct_exporter = exporter pct_importer = importer pct_fdi = fdi ///
         pct_large = large pct_java = java pct_owngen = has_owngen ///
         (p50) med_workers = workers med_va = va med_va_pw = va_pw ///
         med_tfp_op = tfp_op med_tfp_lp = tfp_lp med_tfp_acf = tfp_acf med_tfp_wrdg = tfp_wrdg ///
         med_gj_per_va = gj_per_va med_gj_per_out = gj_per_out med_co2_per_va = co2_per_va ///
         med_owngen_share = owngen_share, by(traj)
foreach v in pct_exporter pct_importer pct_fdi pct_large pct_java pct_owngen {
    replace `v' = 100 * `v'
}
list traj n_firms pct_exporter pct_importer pct_fdi pct_large pct_java med_workers, clean noobs
export excel using "$B20_XLSX", sheet("t15_profile", replace) firstrow(variables)

* ---- B. full distribution ----
use `pre', clear
do "$B20/_sumstats.do" "workers va output capital va_pw cap_pw tfp_op tfp_lp tfp_acf tfp_wrdg gj_per_va gj_per_out co2_per_va owngen_share ln_workers ln_va ln_output ln_va_pw ln_gj_per_va" "traj" "t15_stats"

* ---- C. location: province mix per trajectory ----
use `pre', clear
keep if !missing(prov)
generate n_firms = 1
collapse (sum) n_firms, by(traj prov)
bysort traj: egen traj_total = total(n_firms)
generate pct_of_traj = 100 * n_firms / traj_total
drop traj_total
sort traj prov
export excel using "$B20_XLSX", sheet("t15_province", replace) firstrow(variables)
