/*==========================================================================
  Line 16: "domestic/import mix"
  Data  : Bahan Baku roster 2021-2022 (data/b18_bb_firm.dta, from 13)
  mix: 1 All domestic, 2 Mixed, 3 All imported
  Output sheets:
    t16_mix          per mix group: % of firms and % of raw material value,
                     pool + by year
    t16_mix_sector   % of firms in each mix group per KBLI 2-digit (pool),
                     wide format, ready for a stacked bar chart
==========================================================================*/
if "$B18" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B18_DATA/b18_bb_firm.dta", clear
generate one = 1

* ---- by year + pool ----
preserve
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms = one val_total, by(mix year)
bysort year: egen tot_firms = total(n_firms)
bysort year: egen tot_val   = total(val_total)
generate pct_firms     = 100 * n_firms / tot_firms
generate pct_bb_value  = 100 * val_total / tot_val
generate period = cond(year == 0, "pool", string(year))
sort year mix
order period mix n_firms pct_firms pct_bb_value
keep  period mix n_firms pct_firms pct_bb_value
list, clean noobs
export excel using "$B18_XLSX", sheet("t16_mix", replace) firstrow(variables)
restore

* ---- by sector (pool) ----
collapse (sum) n_firms = one, by(kbli2 mix)
bysort kbli2: egen tot_firms = total(n_firms)
generate pct_firms = 100 * n_firms / tot_firms
keep kbli2 mix pct_firms
* wide: 1 row per sector, 1 column per mix group
reshape wide pct_firms, i(kbli2) j(mix)
rename (pct_firms1 pct_firms2 pct_firms3) (pct_all_domestic pct_mixed pct_all_imported)
export excel using "$B18_XLSX", sheet("t16_mix_sector", replace) firstrow(variables)
