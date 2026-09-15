* WFDOC: Development meminta psid_status synthetic_development, actual meminta verified; assert menolak linkage yang tidak sesuai mode.
* WFDOC: Flag L/L2 berasal dari tahun kalender dan ditempel lewat obs_id; tidak ada index urut-baris atau konversi obs_id menjadi perusahaan.
gen byte g1_panel_usable = !missing(psid) & psid_status == "synthetic_development" if "$G1_MODE"=="development"
replace g1_panel_usable = !missing(psid) & psid_status == "verified" if "$G1_MODE"=="actual"
assert g1_panel_usable==1
gen byte g1_lag1 = .
gen byte g1_lag2 = .
quietly count if g1_panel_usable
if r(N) > 0 {
    preserve
    keep if g1_panel_usable
    isid psid source_year
* WFDOC: L/L2 memakai tahun aktual; karena 2016 tidak ada, 2017 tidak memperoleh lag dari 2015.
    xtset psid source_year
    gen byte g1_observed = 1
    replace g1_lag1 = !missing(L.g1_observed)
    replace g1_lag2 = !missing(L2.g1_observed)
    assert g1_lag1==0 if source_year==2017
    keep obs_id g1_lag1 g1_lag2
    save "$G1_RUN/verified_calendar.dta", replace
    restore
    drop g1_lag1 g1_lag2
* WFDOC: Sidecar kalender digabung satu-ke-satu lewat obs_id; assert menjaga master dan menolak sidecar tanpa pasangan.
    merge 1:1 obs_id using "$G1_RUN/verified_calendar.dta", assert(master match) nogen
}
* No row-order time index or obs_id-to-firm conversion is permitted.
save "$G1_RUN/S03_calendar.dta", replace
