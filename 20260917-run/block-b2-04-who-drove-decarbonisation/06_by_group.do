/*==========================================================================
  Line 6: "Dilakukan untuk total firms, sektor 2 digit, exporters/non
           exporters, domesitic/fdi, importers/non importers."
  Data  : SI 2010-2022 (data/b204_si.dta), clean == 1, VA > 0
  The same helper as lines 2-5 (_decompose.do), looped over the groups.
  Each group is decomposed on its own: its intensity is total CO2 (GJ) /
  total VA of the firms in that group.

  Period: 2010-2022. Exporter groups: 2010-2021, because the 2022 export
          flag is missing (the 2022 form only asks about direct exports).
  Group membership is taken in each year: a firm that becomes an exporter
  counts as an exiter from "Non-exporter" and an entrant into "Exporter".

  Output sheets:
    t06_fhk_by_group   FHK components per group (+ sum, total change, diff)
    t06_mp_by_group    Melitz-Polanec components per group
    t06_summary        both methods mapped to within / reallocation /
                       entry-exit, as % of the group's start-year intensity
  Dataset: data/b204_decomp_groups.dta

  NOTE: FIRM LINKS ARE FICTIONAL in the development data (see 02-05). With
        few continuers in a small group (e.g. a sector) the components are
        noisy even on real data; check n_continuers.
  NOTE: FDI 2020 and exporter 2022 are set missing (see 01a); they are not
        endpoints here, so they do not matter for these periods.
==========================================================================*/
if "$B204" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* the 2-digit sectors in the data
use "$B204_DATA/b204_si.dta", clear
levelsof kbli2 if clean == 1, local(sectors)

capture erase "$B204_DATA/b204_decomp_rows.dta"
foreach ind in co2_va gj_va {
    do "$B204/_decompose.do" `ind' 2010 2022 "" "All firms"
    do "$B204/_decompose.do" `ind' 2010 2021 "exporter == 1" "Exporter"
    do "$B204/_decompose.do" `ind' 2010 2021 "exporter == 0" "Non-exporter"
    do "$B204/_decompose.do" `ind' 2010 2022 "fdi == 0" "Domestic"
    do "$B204/_decompose.do" `ind' 2010 2022 "fdi == 1" "FDI"
    do "$B204/_decompose.do" `ind' 2010 2022 "importer == 1" "Importer"
    do "$B204/_decompose.do" `ind' 2010 2022 "importer == 0" "Non-importer"
    foreach k of local sectors {
        do "$B204/_decompose.do" `ind' 2010 2022 "kbli2 == `k'" "KBLI `k'"
    }
}
use "$B204_DATA/b204_decomp_rows.dta", clear
generate str24 dimension = "Sector (KBLI 2-digit)"
replace dimension = "Total"           if group == "All firms"
replace dimension = "Export status"   if inlist(group, "Exporter", "Non-exporter")
replace dimension = "Ownership"       if inlist(group, "Domestic", "FDI")
replace dimension = "Import status"   if inlist(group, "Importer", "Non-importer")
save "$B204_DATA/b204_decomp_groups.dta", replace

* ---- how many groups add up? -------------------------------------------
generate bad = abs(fhk_diff) > 1e-9 * max(abs(change), abs(I_t0)) | ///
               abs(mp_diff)  > 1e-9 * max(abs(change), abs(I_t0))
count if bad == 1
display as result "Groups whose components do not add up (or cannot be computed): " r(N)
list indicator group n_continuers fhk_diff mp_diff if bad == 1, clean noobs

* ---- FHK table ------------------------------------------------------------
use "$B204_DATA/b204_decomp_groups.dta", clear
keep indicator dimension group period n_continuers n_entrants n_exiters I_t0 I_t1 change fhk_*
order indicator dimension group period n_continuers n_entrants n_exiters I_t0 I_t1 change ///
      fhk_within fhk_between fhk_cross fhk_entry fhk_exit fhk_sum fhk_diff
export excel using "$B204_XLSX", sheet("t06_fhk_by_group", replace) firstrow(variables)

* ---- Melitz-Polanec table ---------------------------------------------------
use "$B204_DATA/b204_decomp_groups.dta", clear
keep indicator dimension group period n_continuers n_entrants n_exiters I_t0 I_t1 change mp_* share_va_*
order indicator dimension group period n_continuers n_entrants n_exiters I_t0 I_t1 change ///
      mp_mean mp_cov mp_entry mp_exit mp_sum mp_diff share_va_entrants_t1 share_va_exiters_t0
export excel using "$B204_XLSX", sheet("t06_mp_by_group", replace) firstrow(variables)

* ---- summary: % of the start-year intensity, one row per group -----------
use "$B204_DATA/b204_decomp_groups.dta", clear
generate double change_pct      = 100 * change / I_t0
generate double fhk_within_pct  = 100 * fhk_within / I_t0
generate double fhk_realloc_pct = 100 * (fhk_between + fhk_cross) / I_t0
generate double fhk_entexit_pct = 100 * (fhk_entry + fhk_exit) / I_t0
generate double mp_within_pct   = 100 * mp_mean / I_t0
generate double mp_realloc_pct  = 100 * mp_cov / I_t0
generate double mp_entexit_pct  = 100 * (mp_entry + mp_exit) / I_t0
keep indicator dimension group period n_continuers change_pct fhk_*_pct mp_*_pct
order indicator dimension group period n_continuers change_pct ///
      fhk_within_pct fhk_realloc_pct fhk_entexit_pct mp_within_pct mp_realloc_pct mp_entexit_pct
list indicator group change_pct fhk_within_pct fhk_realloc_pct fhk_entexit_pct ///
     if dimension != "Sector (KBLI 2-digit)", clean noobs
export excel using "$B204_XLSX", sheet("t06_summary", replace) firstrow(variables)
