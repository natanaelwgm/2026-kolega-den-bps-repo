* Periksa panel dalam kalender asli. Ketiadaan 2016 bukan alasan membuat indeks
* tahun berurutan. Perusahaan tidak terlihat bukan berarti perusahaan tutup.
capture log close PANEL
log using "$DR_RUN/logs/panel.log", name(PANEL) text replace
use obs_id source_year psid psid_status province_code industry_code workers using "$DR_INPUT", clear
local total=_N
quietly count if missing(psid)
local missing_ids=r(N)
local ready=(`missing_ids'==0)
if "$DR_MODE"=="actual" {
    quietly count if psid_status!="verified"
    if r(N)>0 local ready=0
}
local firms=.
local consecutive=.
local gaplinks=.
local multi=.
if `ready' {
    isid psid source_year
    bysort psid (source_year): generate int gap=source_year-source_year[_n-1] if _n>1
    by psid: generate byte firm_tag=_n==1
    by psid: generate byte multiwave=_N>1
    quietly count if firm_tag
    local firms=r(N)
    quietly count if firm_tag & multiwave
    local multi=r(N)
    quietly count if gap==1
    local consecutive=r(N)
    quietly count if gap>1 & !missing(gap)
    local gaplinks=r(N)
    * Batas wajib berlaku pada ID fiktif hasil generator, bukan klaim perusahaan riil.
    by psid: assert province_code==province_code[1] if psid_status=="synthetic_development"
    by psid: assert substr(industry_code,1,2)==substr(industry_code[1],1,2) if psid_status=="synthetic_development"
    xtset psid source_year, delta(1)
    generate double lag_workers=L.workers
    bysort psid (source_year): assert lag_workers==workers[_n-1] if gap==1
    assert missing(lag_workers) if gap>1 & !missing(gap)
    preserve
    keep if !missing(gap)
    * Satu wave atau seluruh perusahaan singleton adalah input yang sah.
    * Tetap tulis tabel kosong ber-header ketika belum ada hubungan antar-tahun.
    if _N>0 contract source_year gap, freq(links)
    else {
        keep source_year gap
        generate long links=.
    }
    export delimited using "$DR_RUN/tables/panel_calendar_links.csv", replace
    restore
}
tempname p
postfile `p' long rows long missing_firm_ids byte panel_ready long firms long multiwave_firms long adjacent_year_links long longer_calendar_gap_links str20 data_mode using "$DR_RUN/intermediate/panel_summary.dta", replace
post `p' (`total') (`missing_ids') (`ready') (`firms') (`multi') (`consecutive') (`gaplinks') ("$DR_MODE")
postclose `p'
use "$DR_RUN/intermediate/panel_summary.dta", clear
export delimited using "$DR_RUN/tables/panel_summary.csv", replace
log close PANEL
