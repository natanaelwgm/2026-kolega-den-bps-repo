* Tujuan: Bandingkan nilai baseline dengan kolom koreksi dan ringkas perubahan, missing, serta status per variabel/tahun. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: corrections/reports/change_audit.dta; corrections/data/C150.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "C150_change_audit"
* Ringkas jumlah nilai yang berubah, kosong, atau berbeda dari nilai lama untuk setiap turunan yang ditinjau. // WFDOC-INJECTED
use  using "data/analysis/G0_analysis_ready.dta", clear
tempname p
postfile `p' int source_year str32 variable long changed_n long old_missing_new_valid_n long old_valid_new_missing_n long finite_changed_n double max_absolute_difference using "corrections/reports/change_audit.dta", replace
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & labor_productivity_nominal!=r_labor_productivity_nominal
    local changed=r(N)
    quietly count if source_year==`y' & missing(labor_productivity_nominal) & !missing(r_labor_productivity_nominal)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(labor_productivity_nominal) & missing(r_labor_productivity_nominal)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(labor_productivity_nominal,r_labor_productivity_nominal) & labor_productivity_nominal!=r_labor_productivity_nominal
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(labor_productivity_nominal-r_labor_productivity_nominal) if source_year==`y' & !missing(labor_productivity_nominal,r_labor_productivity_nominal)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_labor_productivity_nominal") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & output_per_worker_nominal!=r_output_per_worker_nominal
    local changed=r(N)
    quietly count if source_year==`y' & missing(output_per_worker_nominal) & !missing(r_output_per_worker_nominal)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(output_per_worker_nominal) & missing(r_output_per_worker_nominal)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(output_per_worker_nominal,r_output_per_worker_nominal) & output_per_worker_nominal!=r_output_per_worker_nominal
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(output_per_worker_nominal-r_output_per_worker_nominal) if source_year==`y' & !missing(output_per_worker_nominal,r_output_per_worker_nominal)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_output_per_worker_nominal") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & capital_per_worker_nominal!=r_capital_per_worker_nominal
    local changed=r(N)
    quietly count if source_year==`y' & missing(capital_per_worker_nominal) & !missing(r_capital_per_worker_nominal)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(capital_per_worker_nominal) & missing(r_capital_per_worker_nominal)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(capital_per_worker_nominal,r_capital_per_worker_nominal) & capital_per_worker_nominal!=r_capital_per_worker_nominal
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(capital_per_worker_nominal-r_capital_per_worker_nominal) if source_year==`y' & !missing(capital_per_worker_nominal,r_capital_per_worker_nominal)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_capital_per_worker_nominal") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & inputs_per_worker_nominal!=r_inputs_per_worker_nominal
    local changed=r(N)
    quietly count if source_year==`y' & missing(inputs_per_worker_nominal) & !missing(r_inputs_per_worker_nominal)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(inputs_per_worker_nominal) & missing(r_inputs_per_worker_nominal)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(inputs_per_worker_nominal,r_inputs_per_worker_nominal) & inputs_per_worker_nominal!=r_inputs_per_worker_nominal
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(inputs_per_worker_nominal-r_inputs_per_worker_nominal) if source_year==`y' & !missing(inputs_per_worker_nominal,r_inputs_per_worker_nominal)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_inputs_per_worker_nominal") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & rd_cost_per_worker_nominal!=r_rd_cost_per_worker_nominal
    local changed=r(N)
    quietly count if source_year==`y' & missing(rd_cost_per_worker_nominal) & !missing(r_rd_cost_per_worker_nominal)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(rd_cost_per_worker_nominal) & missing(r_rd_cost_per_worker_nominal)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(rd_cost_per_worker_nominal,r_rd_cost_per_worker_nominal) & rd_cost_per_worker_nominal!=r_rd_cost_per_worker_nominal
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(rd_cost_per_worker_nominal-r_rd_cost_per_worker_nominal) if source_year==`y' & !missing(rd_cost_per_worker_nominal,r_rd_cost_per_worker_nominal)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_rd_cost_per_worker_nominal") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & energy_cost_per_worker!=r_energy_cost_per_worker
    local changed=r(N)
    quietly count if source_year==`y' & missing(energy_cost_per_worker) & !missing(r_energy_cost_per_worker)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(energy_cost_per_worker) & missing(r_energy_cost_per_worker)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(energy_cost_per_worker,r_energy_cost_per_worker) & energy_cost_per_worker!=r_energy_cost_per_worker
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(energy_cost_per_worker-r_energy_cost_per_worker) if source_year==`y' & !missing(energy_cost_per_worker,r_energy_cost_per_worker)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_energy_cost_per_worker") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & total_gj_per_worker!=r_total_gj_per_worker
    local changed=r(N)
    quietly count if source_year==`y' & missing(total_gj_per_worker) & !missing(r_total_gj_per_worker)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(total_gj_per_worker) & missing(r_total_gj_per_worker)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(total_gj_per_worker,r_total_gj_per_worker) & total_gj_per_worker!=r_total_gj_per_worker
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(total_gj_per_worker-r_total_gj_per_worker) if source_year==`y' & !missing(total_gj_per_worker,r_total_gj_per_worker)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_total_gj_per_worker") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & co2_per_worker!=r_co2_per_worker
    local changed=r(N)
    quietly count if source_year==`y' & missing(co2_per_worker) & !missing(r_co2_per_worker)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(co2_per_worker) & missing(r_co2_per_worker)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(co2_per_worker,r_co2_per_worker) & co2_per_worker!=r_co2_per_worker
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(co2_per_worker-r_co2_per_worker) if source_year==`y' & !missing(co2_per_worker,r_co2_per_worker)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_co2_per_worker") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & capital_stock_per_worker!=r_capital_stock_per_worker
    local changed=r(N)
    quietly count if source_year==`y' & missing(capital_stock_per_worker) & !missing(r_capital_stock_per_worker)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(capital_stock_per_worker) & missing(r_capital_stock_per_worker)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(capital_stock_per_worker,r_capital_stock_per_worker) & capital_stock_per_worker!=r_capital_stock_per_worker
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(capital_stock_per_worker-r_capital_stock_per_worker) if source_year==`y' & !missing(capital_stock_per_worker,r_capital_stock_per_worker)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_capital_stock_per_worker") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & capital_additions_per_worker!=r_capital_additions_per_worker
    local changed=r(N)
    quietly count if source_year==`y' & missing(capital_additions_per_worker) & !missing(r_capital_additions_per_worker)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(capital_additions_per_worker) & missing(r_capital_additions_per_worker)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(capital_additions_per_worker,r_capital_additions_per_worker) & capital_additions_per_worker!=r_capital_additions_per_worker
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(capital_additions_per_worker-r_capital_additions_per_worker) if source_year==`y' & !missing(capital_additions_per_worker,r_capital_additions_per_worker)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_capital_additions_per_worker") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_cbdacu!=r_pw_val_cbdacu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_cbdacu) & !missing(r_pw_val_cbdacu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_cbdacu) & missing(r_pw_val_cbdacu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_cbdacu,r_pw_val_cbdacu) & pw_val_cbdacu!=r_pw_val_cbdacu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_cbdacu-r_pw_val_cbdacu) if source_year==`y' & !missing(pw_val_cbdacu,r_pw_val_cbdacu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_cbdacu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_cbfpcu!=r_pw_val_cbfpcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_cbfpcu) & !missing(r_pw_val_cbfpcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_cbfpcu) & missing(r_pw_val_cbfpcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_cbfpcu,r_pw_val_cbfpcu) & pw_val_cbfpcu!=r_pw_val_cbfpcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_cbfpcu-r_pw_val_cbfpcu) if source_year==`y' & !missing(pw_val_cbfpcu,r_pw_val_cbfpcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_cbfpcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_cbsacu!=r_pw_val_cbsacu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_cbsacu) & !missing(r_pw_val_cbsacu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_cbsacu) & missing(r_pw_val_cbsacu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_cbsacu,r_pw_val_cbsacu) & pw_val_cbsacu!=r_pw_val_cbsacu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_cbsacu-r_pw_val_cbsacu) if source_year==`y' & !missing(pw_val_cbsacu,r_pw_val_cbsacu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_cbsacu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_cbttcu!=r_pw_val_cbttcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_cbttcu) & !missing(r_pw_val_cbttcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_cbttcu) & missing(r_pw_val_cbttcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_cbttcu,r_pw_val_cbttcu) & pw_val_cbttcu!=r_pw_val_cbttcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_cbttcu-r_pw_val_cbttcu) if source_year==`y' & !missing(pw_val_cbttcu,r_pw_val_cbttcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_cbttcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_cldacu!=r_pw_val_cldacu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_cldacu) & !missing(r_pw_val_cldacu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_cldacu) & missing(r_pw_val_cldacu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_cldacu,r_pw_val_cldacu) & pw_val_cldacu!=r_pw_val_cldacu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_cldacu-r_pw_val_cldacu) if source_year==`y' & !missing(pw_val_cldacu,r_pw_val_cldacu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_cldacu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_clfpcu!=r_pw_val_clfpcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_clfpcu) & !missing(r_pw_val_clfpcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_clfpcu) & missing(r_pw_val_clfpcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_clfpcu,r_pw_val_clfpcu) & pw_val_clfpcu!=r_pw_val_clfpcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_clfpcu-r_pw_val_clfpcu) if source_year==`y' & !missing(pw_val_clfpcu,r_pw_val_clfpcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_clfpcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_clsacu!=r_pw_val_clsacu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_clsacu) & !missing(r_pw_val_clsacu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_clsacu) & missing(r_pw_val_clsacu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_clsacu,r_pw_val_clsacu) & pw_val_clsacu!=r_pw_val_clsacu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_clsacu-r_pw_val_clsacu) if source_year==`y' & !missing(pw_val_clsacu,r_pw_val_clsacu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_clsacu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_clttcu!=r_pw_val_clttcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_clttcu) & !missing(r_pw_val_clttcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_clttcu) & missing(r_pw_val_clttcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_clttcu,r_pw_val_clttcu) & pw_val_clttcu!=r_pw_val_clttcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_clttcu-r_pw_val_clttcu) if source_year==`y' & !missing(pw_val_clttcu,r_pw_val_clttcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_clttcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_cmdacu!=r_pw_val_cmdacu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_cmdacu) & !missing(r_pw_val_cmdacu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_cmdacu) & missing(r_pw_val_cmdacu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_cmdacu,r_pw_val_cmdacu) & pw_val_cmdacu!=r_pw_val_cmdacu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_cmdacu-r_pw_val_cmdacu) if source_year==`y' & !missing(pw_val_cmdacu,r_pw_val_cmdacu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_cmdacu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_cmfpcu!=r_pw_val_cmfpcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_cmfpcu) & !missing(r_pw_val_cmfpcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_cmfpcu) & missing(r_pw_val_cmfpcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_cmfpcu,r_pw_val_cmfpcu) & pw_val_cmfpcu!=r_pw_val_cmfpcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_cmfpcu-r_pw_val_cmfpcu) if source_year==`y' & !missing(pw_val_cmfpcu,r_pw_val_cmfpcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_cmfpcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_cmsacu!=r_pw_val_cmsacu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_cmsacu) & !missing(r_pw_val_cmsacu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_cmsacu) & missing(r_pw_val_cmsacu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_cmsacu,r_pw_val_cmsacu) & pw_val_cmsacu!=r_pw_val_cmsacu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_cmsacu-r_pw_val_cmsacu) if source_year==`y' & !missing(pw_val_cmsacu,r_pw_val_cmsacu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_cmsacu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_cmttcu!=r_pw_val_cmttcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_cmttcu) & !missing(r_pw_val_cmttcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_cmttcu) & missing(r_pw_val_cmttcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_cmttcu,r_pw_val_cmttcu) & pw_val_cmttcu!=r_pw_val_cmttcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_cmttcu-r_pw_val_cmttcu) if source_year==`y' & !missing(pw_val_cmttcu,r_pw_val_cmttcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_cmttcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_codacu!=r_pw_val_codacu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_codacu) & !missing(r_pw_val_codacu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_codacu) & missing(r_pw_val_codacu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_codacu,r_pw_val_codacu) & pw_val_codacu!=r_pw_val_codacu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_codacu-r_pw_val_codacu) if source_year==`y' & !missing(pw_val_codacu,r_pw_val_codacu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_codacu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_cofpcu!=r_pw_val_cofpcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_cofpcu) & !missing(r_pw_val_cofpcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_cofpcu) & missing(r_pw_val_cofpcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_cofpcu,r_pw_val_cofpcu) & pw_val_cofpcu!=r_pw_val_cofpcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_cofpcu-r_pw_val_cofpcu) if source_year==`y' & !missing(pw_val_cofpcu,r_pw_val_cofpcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_cofpcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_cosacu!=r_pw_val_cosacu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_cosacu) & !missing(r_pw_val_cosacu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_cosacu) & missing(r_pw_val_cosacu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_cosacu,r_pw_val_cosacu) & pw_val_cosacu!=r_pw_val_cosacu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_cosacu-r_pw_val_cosacu) if source_year==`y' & !missing(pw_val_cosacu,r_pw_val_cosacu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_cosacu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_costrd!=r_pw_val_costrd
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_costrd) & !missing(r_pw_val_costrd)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_costrd) & missing(r_pw_val_costrd)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_costrd,r_pw_val_costrd) & pw_val_costrd!=r_pw_val_costrd
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_costrd-r_pw_val_costrd) if source_year==`y' & !missing(pw_val_costrd,r_pw_val_costrd)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_costrd") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_cottcu!=r_pw_val_cottcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_cottcu) & !missing(r_pw_val_cottcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_cottcu) & missing(r_pw_val_cottcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_cottcu,r_pw_val_cottcu) & pw_val_cottcu!=r_pw_val_cottcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_cottcu-r_pw_val_cottcu) if source_year==`y' & !missing(pw_val_cottcu,r_pw_val_cottcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_cottcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_csdacu!=r_pw_val_csdacu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_csdacu) & !missing(r_pw_val_csdacu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_csdacu) & missing(r_pw_val_csdacu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_csdacu,r_pw_val_csdacu) & pw_val_csdacu!=r_pw_val_csdacu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_csdacu-r_pw_val_csdacu) if source_year==`y' & !missing(pw_val_csdacu,r_pw_val_csdacu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_csdacu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_csfpcu!=r_pw_val_csfpcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_csfpcu) & !missing(r_pw_val_csfpcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_csfpcu) & missing(r_pw_val_csfpcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_csfpcu,r_pw_val_csfpcu) & pw_val_csfpcu!=r_pw_val_csfpcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_csfpcu-r_pw_val_csfpcu) if source_year==`y' & !missing(pw_val_csfpcu,r_pw_val_csfpcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_csfpcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_cssacu!=r_pw_val_cssacu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_cssacu) & !missing(r_pw_val_cssacu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_cssacu) & missing(r_pw_val_cssacu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_cssacu,r_pw_val_cssacu) & pw_val_cssacu!=r_pw_val_cssacu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_cssacu-r_pw_val_cssacu) if source_year==`y' & !missing(pw_val_cssacu,r_pw_val_cssacu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_cssacu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_csttcu!=r_pw_val_csttcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_csttcu) & !missing(r_pw_val_csttcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_csttcu) & missing(r_pw_val_csttcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_csttcu,r_pw_val_csttcu) & pw_val_csttcu!=r_pw_val_csttcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_csttcu-r_pw_val_csttcu) if source_year==`y' & !missing(pw_val_csttcu,r_pw_val_csttcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_csttcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_ctdacu!=r_pw_val_ctdacu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_ctdacu) & !missing(r_pw_val_ctdacu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_ctdacu) & missing(r_pw_val_ctdacu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_ctdacu,r_pw_val_ctdacu) & pw_val_ctdacu!=r_pw_val_ctdacu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_ctdacu-r_pw_val_ctdacu) if source_year==`y' & !missing(pw_val_ctdacu,r_pw_val_ctdacu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_ctdacu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_ctfpcu!=r_pw_val_ctfpcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_ctfpcu) & !missing(r_pw_val_ctfpcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_ctfpcu) & missing(r_pw_val_ctfpcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_ctfpcu,r_pw_val_ctfpcu) & pw_val_ctfpcu!=r_pw_val_ctfpcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_ctfpcu-r_pw_val_ctfpcu) if source_year==`y' & !missing(pw_val_ctfpcu,r_pw_val_ctfpcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_ctfpcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_ctsacu!=r_pw_val_ctsacu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_ctsacu) & !missing(r_pw_val_ctsacu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_ctsacu) & missing(r_pw_val_ctsacu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_ctsacu,r_pw_val_ctsacu) & pw_val_ctsacu!=r_pw_val_ctsacu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_ctsacu-r_pw_val_ctsacu) if source_year==`y' & !missing(pw_val_ctsacu,r_pw_val_ctsacu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_ctsacu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_cttcu!=r_pw_val_cttcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_cttcu) & !missing(r_pw_val_cttcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_cttcu) & missing(r_pw_val_cttcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_cttcu,r_pw_val_cttcu) & pw_val_cttcu!=r_pw_val_cttcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_cttcu-r_pw_val_cttcu) if source_year==`y' & !missing(pw_val_cttcu,r_pw_val_cttcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_cttcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_ctttcu!=r_pw_val_ctttcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_ctttcu) & !missing(r_pw_val_ctttcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_ctttcu) & missing(r_pw_val_ctttcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_ctttcu,r_pw_val_ctttcu) & pw_val_ctttcu!=r_pw_val_ctttcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_ctttcu-r_pw_val_ctttcu) if source_year==`y' & !missing(pw_val_ctttcu,r_pw_val_ctttcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_ctttcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_cvdacu!=r_pw_val_cvdacu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_cvdacu) & !missing(r_pw_val_cvdacu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_cvdacu) & missing(r_pw_val_cvdacu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_cvdacu,r_pw_val_cvdacu) & pw_val_cvdacu!=r_pw_val_cvdacu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_cvdacu-r_pw_val_cvdacu) if source_year==`y' & !missing(pw_val_cvdacu,r_pw_val_cvdacu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_cvdacu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_cvfpcu!=r_pw_val_cvfpcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_cvfpcu) & !missing(r_pw_val_cvfpcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_cvfpcu) & missing(r_pw_val_cvfpcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_cvfpcu,r_pw_val_cvfpcu) & pw_val_cvfpcu!=r_pw_val_cvfpcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_cvfpcu-r_pw_val_cvfpcu) if source_year==`y' & !missing(pw_val_cvfpcu,r_pw_val_cvfpcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_cvfpcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_cvsacu!=r_pw_val_cvsacu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_cvsacu) & !missing(r_pw_val_cvsacu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_cvsacu) & missing(r_pw_val_cvsacu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_cvsacu,r_pw_val_cvsacu) & pw_val_cvsacu!=r_pw_val_cvsacu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_cvsacu-r_pw_val_cvsacu) if source_year==`y' & !missing(pw_val_cvsacu,r_pw_val_cvsacu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_cvsacu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_cvttcu!=r_pw_val_cvttcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_cvttcu) & !missing(r_pw_val_cvttcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_cvttcu) & missing(r_pw_val_cvttcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_cvttcu,r_pw_val_cvttcu) & pw_val_cvttcu!=r_pw_val_cvttcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_cvttcu-r_pw_val_cvttcu) if source_year==`y' & !missing(pw_val_cvttcu,r_pw_val_cvttcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_cvttcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_devvcu!=r_pw_val_devvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_devvcu) & !missing(r_pw_val_devvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_devvcu) & missing(r_pw_val_devvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_devvcu,r_pw_val_devvcu) & pw_val_devvcu!=r_pw_val_devvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_devvcu-r_pw_val_devvcu) if source_year==`y' & !missing(pw_val_devvcu,r_pw_val_devvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_devvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_ecavce!=r_pw_val_ecavce
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_ecavce) & !missing(r_pw_val_ecavce)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_ecavce) & missing(r_pw_val_ecavce)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_ecavce,r_pw_val_ecavce) & pw_val_ecavce!=r_pw_val_ecavce
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_ecavce-r_pw_val_ecavce) if source_year==`y' & !missing(pw_val_ecavce,r_pw_val_ecavce)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_ecavce") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_ecavcu!=r_pw_val_ecavcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_ecavcu) & !missing(r_pw_val_ecavcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_ecavcu) & missing(r_pw_val_ecavcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_ecavcu,r_pw_val_ecavcu) & pw_val_ecavcu!=r_pw_val_ecavcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_ecavcu-r_pw_val_ecavcu) if source_year==`y' & !missing(pw_val_ecavcu,r_pw_val_ecavcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_ecavcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_ecbvce!=r_pw_val_ecbvce
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_ecbvce) & !missing(r_pw_val_ecbvce)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_ecbvce) & missing(r_pw_val_ecbvce)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_ecbvce,r_pw_val_ecbvce) & pw_val_ecbvce!=r_pw_val_ecbvce
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_ecbvce-r_pw_val_ecbvce) if source_year==`y' & !missing(pw_val_ecbvce,r_pw_val_ecbvce)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_ecbvce") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_ecbvcu!=r_pw_val_ecbvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_ecbvcu) & !missing(r_pw_val_ecbvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_ecbvcu) & missing(r_pw_val_ecbvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_ecbvcu,r_pw_val_ecbvcu) & pw_val_ecbvcu!=r_pw_val_ecbvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_ecbvcu-r_pw_val_ecbvcu) if source_year==`y' & !missing(pw_val_ecbvcu,r_pw_val_ecbvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_ecbvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_eckvce!=r_pw_val_eckvce
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_eckvce) & !missing(r_pw_val_eckvce)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_eckvce) & missing(r_pw_val_eckvce)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_eckvce,r_pw_val_eckvce) & pw_val_eckvce!=r_pw_val_eckvce
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_eckvce-r_pw_val_eckvce) if source_year==`y' & !missing(pw_val_eckvce,r_pw_val_eckvce)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_eckvce") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_eckvcu!=r_pw_val_eckvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_eckvcu) & !missing(r_pw_val_eckvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_eckvcu) & missing(r_pw_val_eckvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_eckvcu,r_pw_val_eckvcu) & pw_val_eckvcu!=r_pw_val_eckvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_eckvcu-r_pw_val_eckvcu) if source_year==`y' & !missing(pw_val_eckvcu,r_pw_val_eckvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_eckvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_eclvce!=r_pw_val_eclvce
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_eclvce) & !missing(r_pw_val_eclvce)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_eclvce) & missing(r_pw_val_eclvce)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_eclvce,r_pw_val_eclvce) & pw_val_eclvce!=r_pw_val_eclvce
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_eclvce-r_pw_val_eclvce) if source_year==`y' & !missing(pw_val_eclvce,r_pw_val_eclvce)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_eclvce") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_eclvcu!=r_pw_val_eclvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_eclvcu) & !missing(r_pw_val_eclvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_eclvcu) & missing(r_pw_val_eclvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_eclvcu,r_pw_val_eclvcu) & pw_val_eclvcu!=r_pw_val_eclvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_eclvcu-r_pw_val_eclvcu) if source_year==`y' & !missing(pw_val_eclvcu,r_pw_val_eclvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_eclvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_edivce!=r_pw_val_edivce
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_edivce) & !missing(r_pw_val_edivce)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_edivce) & missing(r_pw_val_edivce)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_edivce,r_pw_val_edivce) & pw_val_edivce!=r_pw_val_edivce
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_edivce-r_pw_val_edivce) if source_year==`y' & !missing(pw_val_edivce,r_pw_val_edivce)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_edivce") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_edivcu!=r_pw_val_edivcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_edivcu) & !missing(r_pw_val_edivcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_edivcu) & missing(r_pw_val_edivcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_edivcu,r_pw_val_edivcu) & pw_val_edivcu!=r_pw_val_edivcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_edivcu-r_pw_val_edivcu) if source_year==`y' & !missing(pw_val_edivcu,r_pw_val_edivcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_edivcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_efovce!=r_pw_val_efovce
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_efovce) & !missing(r_pw_val_efovce)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_efovce) & missing(r_pw_val_efovce)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_efovce,r_pw_val_efovce) & pw_val_efovce!=r_pw_val_efovce
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_efovce-r_pw_val_efovce) if source_year==`y' & !missing(pw_val_efovce,r_pw_val_efovce)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_efovce") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_efovcu!=r_pw_val_efovcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_efovcu) & !missing(r_pw_val_efovcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_efovcu) & missing(r_pw_val_efovcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_efovcu,r_pw_val_efovcu) & pw_val_efovcu!=r_pw_val_efovcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_efovcu-r_pw_val_efovcu) if source_year==`y' & !missing(pw_val_efovcu,r_pw_val_efovcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_efovcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_efuvce!=r_pw_val_efuvce
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_efuvce) & !missing(r_pw_val_efuvce)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_efuvce) & missing(r_pw_val_efuvce)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_efuvce,r_pw_val_efuvce) & pw_val_efuvce!=r_pw_val_efuvce
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_efuvce-r_pw_val_efuvce) if source_year==`y' & !missing(pw_val_efuvce,r_pw_val_efuvce)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_efuvce") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_efuvcu!=r_pw_val_efuvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_efuvcu) & !missing(r_pw_val_efuvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_efuvcu) & missing(r_pw_val_efuvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_efuvcu,r_pw_val_efuvcu) & pw_val_efuvcu!=r_pw_val_efuvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_efuvcu-r_pw_val_efuvcu) if source_year==`y' & !missing(pw_val_efuvcu,r_pw_val_efuvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_efuvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_egavce!=r_pw_val_egavce
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_egavce) & !missing(r_pw_val_egavce)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_egavce) & missing(r_pw_val_egavce)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_egavce,r_pw_val_egavce) & pw_val_egavce!=r_pw_val_egavce
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_egavce-r_pw_val_egavce) if source_year==`y' & !missing(pw_val_egavce,r_pw_val_egavce)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_egavce") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_egavcu!=r_pw_val_egavcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_egavcu) & !missing(r_pw_val_egavcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_egavcu) & missing(r_pw_val_egavcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_egavcu,r_pw_val_egavcu) & pw_val_egavcu!=r_pw_val_egavcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_egavcu-r_pw_val_egavcu) if source_year==`y' & !missing(pw_val_egavcu,r_pw_val_egavcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_egavcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_egovce!=r_pw_val_egovce
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_egovce) & !missing(r_pw_val_egovce)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_egovce) & missing(r_pw_val_egovce)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_egovce,r_pw_val_egovce) & pw_val_egovce!=r_pw_val_egovce
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_egovce-r_pw_val_egovce) if source_year==`y' & !missing(pw_val_egovce,r_pw_val_egovce)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_egovce") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_egovcu!=r_pw_val_egovcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_egovcu) & !missing(r_pw_val_egovcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_egovcu) & missing(r_pw_val_egovcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_egovcu,r_pw_val_egovcu) & pw_val_egovcu!=r_pw_val_egovcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_egovcu-r_pw_val_egovcu) if source_year==`y' & !missing(pw_val_egovcu,r_pw_val_egovcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_egovcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_elpvce!=r_pw_val_elpvce
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_elpvce) & !missing(r_pw_val_elpvce)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_elpvce) & missing(r_pw_val_elpvce)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_elpvce,r_pw_val_elpvce) & pw_val_elpvce!=r_pw_val_elpvce
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_elpvce-r_pw_val_elpvce) if source_year==`y' & !missing(pw_val_elpvce,r_pw_val_elpvce)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_elpvce") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_elpvcu!=r_pw_val_elpvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_elpvcu) & !missing(r_pw_val_elpvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_elpvcu) & missing(r_pw_val_elpvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_elpvcu,r_pw_val_elpvcu) & pw_val_elpvcu!=r_pw_val_elpvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_elpvcu-r_pw_val_elpvcu) if source_year==`y' & !missing(pw_val_elpvcu,r_pw_val_elpvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_elpvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_eluvce!=r_pw_val_eluvce
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_eluvce) & !missing(r_pw_val_eluvce)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_eluvce) & missing(r_pw_val_eluvce)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_eluvce,r_pw_val_eluvce) & pw_val_eluvce!=r_pw_val_eluvce
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_eluvce-r_pw_val_eluvce) if source_year==`y' & !missing(pw_val_eluvce,r_pw_val_eluvce)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_eluvce") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_eluvcu!=r_pw_val_eluvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_eluvcu) & !missing(r_pw_val_eluvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_eluvcu) & missing(r_pw_val_eluvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_eluvcu,r_pw_val_eluvcu) & pw_val_eluvcu!=r_pw_val_eluvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_eluvcu-r_pw_val_eluvcu) if source_year==`y' & !missing(pw_val_eluvcu,r_pw_val_eluvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_eluvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_encvce!=r_pw_val_encvce
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_encvce) & !missing(r_pw_val_encvce)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_encvce) & missing(r_pw_val_encvce)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_encvce,r_pw_val_encvce) & pw_val_encvce!=r_pw_val_encvce
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_encvce-r_pw_val_encvce) if source_year==`y' & !missing(pw_val_encvce,r_pw_val_encvce)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_encvce") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_encvcu!=r_pw_val_encvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_encvcu) & !missing(r_pw_val_encvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_encvcu) & missing(r_pw_val_encvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_encvcu,r_pw_val_encvcu) & pw_val_encvcu!=r_pw_val_encvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_encvcu-r_pw_val_encvcu) if source_year==`y' & !missing(pw_val_encvcu,r_pw_val_encvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_encvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_engvce!=r_pw_val_engvce
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_engvce) & !missing(r_pw_val_engvce)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_engvce) & missing(r_pw_val_engvce)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_engvce,r_pw_val_engvce) & pw_val_engvce!=r_pw_val_engvce
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_engvce-r_pw_val_engvce) if source_year==`y' & !missing(pw_val_engvce,r_pw_val_engvce)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_engvce") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_engvcu!=r_pw_val_engvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_engvcu) & !missing(r_pw_val_engvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_engvcu) & missing(r_pw_val_engvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_engvcu,r_pw_val_engvcu) & pw_val_engvcu!=r_pw_val_engvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_engvcu-r_pw_val_engvcu) if source_year==`y' & !missing(pw_val_engvcu,r_pw_val_engvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_engvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_enpvcu!=r_pw_val_enpvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_enpvcu) & !missing(r_pw_val_enpvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_enpvcu) & missing(r_pw_val_enpvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_enpvcu,r_pw_val_enpvcu) & pw_val_enpvcu!=r_pw_val_enpvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_enpvcu-r_pw_val_enpvcu) if source_year==`y' & !missing(pw_val_enpvcu,r_pw_val_enpvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_enpvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_eoivce!=r_pw_val_eoivce
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_eoivce) & !missing(r_pw_val_eoivce)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_eoivce) & missing(r_pw_val_eoivce)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_eoivce,r_pw_val_eoivce) & pw_val_eoivce!=r_pw_val_eoivce
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_eoivce-r_pw_val_eoivce) if source_year==`y' & !missing(pw_val_eoivce,r_pw_val_eoivce)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_eoivce") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_eoivcu!=r_pw_val_eoivcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_eoivcu) & !missing(r_pw_val_eoivcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_eoivcu) & missing(r_pw_val_eoivcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_eoivcu,r_pw_val_eoivcu) & pw_val_eoivcu!=r_pw_val_eoivcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_eoivcu-r_pw_val_eoivcu) if source_year==`y' & !missing(pw_val_eoivcu,r_pw_val_eoivcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_eoivcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_epevce!=r_pw_val_epevce
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_epevce) & !missing(r_pw_val_epevce)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_epevce) & missing(r_pw_val_epevce)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_epevce,r_pw_val_epevce) & pw_val_epevce!=r_pw_val_epevce
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_epevce-r_pw_val_epevce) if source_year==`y' & !missing(pw_val_epevce,r_pw_val_epevce)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_epevce") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_epevcu!=r_pw_val_epevcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_epevcu) & !missing(r_pw_val_epevcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_epevcu) & missing(r_pw_val_epevcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_epevcu,r_pw_val_epevcu) & pw_val_epevcu!=r_pw_val_epevcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_epevcu-r_pw_val_epevcu) if source_year==`y' & !missing(pw_val_epevcu,r_pw_val_epevcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_epevcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_eplvcu!=r_pw_val_eplvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_eplvcu) & !missing(r_pw_val_eplvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_eplvcu) & missing(r_pw_val_eplvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_eplvcu,r_pw_val_eplvcu) & pw_val_eplvcu!=r_pw_val_eplvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_eplvcu-r_pw_val_eplvcu) if source_year==`y' & !missing(pw_val_eplvcu,r_pw_val_eplvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_eplvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_esdvce!=r_pw_val_esdvce
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_esdvce) & !missing(r_pw_val_esdvce)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_esdvce) & missing(r_pw_val_esdvce)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_esdvce,r_pw_val_esdvce) & pw_val_esdvce!=r_pw_val_esdvce
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_esdvce-r_pw_val_esdvce) if source_year==`y' & !missing(pw_val_esdvce,r_pw_val_esdvce)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_esdvce") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_esdvcu!=r_pw_val_esdvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_esdvcu) & !missing(r_pw_val_esdvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_esdvcu) & missing(r_pw_val_esdvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_esdvcu,r_pw_val_esdvcu) & pw_val_esdvcu!=r_pw_val_esdvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_esdvcu-r_pw_val_esdvcu) if source_year==`y' & !missing(pw_val_esdvcu,r_pw_val_esdvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_esdvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_esovce!=r_pw_val_esovce
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_esovce) & !missing(r_pw_val_esovce)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_esovce) & missing(r_pw_val_esovce)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_esovce,r_pw_val_esovce) & pw_val_esovce!=r_pw_val_esovce
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_esovce-r_pw_val_esovce) if source_year==`y' & !missing(pw_val_esovce,r_pw_val_esovce)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_esovce") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_esovcu!=r_pw_val_esovcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_esovcu) & !missing(r_pw_val_esovcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_esovcu) & missing(r_pw_val_esovcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_esovcu,r_pw_val_esovcu) & pw_val_esovcu!=r_pw_val_esovcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_esovcu-r_pw_val_esovcu) if source_year==`y' & !missing(pw_val_esovcu,r_pw_val_esovcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_esovcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_ibrvcu!=r_pw_val_ibrvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_ibrvcu) & !missing(r_pw_val_ibrvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_ibrvcu) & missing(r_pw_val_ibrvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_ibrvcu,r_pw_val_ibrvcu) & pw_val_ibrvcu!=r_pw_val_ibrvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_ibrvcu-r_pw_val_ibrvcu) if source_year==`y' & !missing(pw_val_ibrvcu,r_pw_val_ibrvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_ibrvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_icovcu!=r_pw_val_icovcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_icovcu) & !missing(r_pw_val_icovcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_icovcu) & missing(r_pw_val_icovcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_icovcu,r_pw_val_icovcu) & pw_val_icovcu!=r_pw_val_icovcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_icovcu-r_pw_val_icovcu) if source_year==`y' & !missing(pw_val_icovcu,r_pw_val_icovcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_icovcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_idevcu!=r_pw_val_idevcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_idevcu) & !missing(r_pw_val_idevcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_idevcu) & missing(r_pw_val_idevcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_idevcu,r_pw_val_idevcu) & pw_val_idevcu!=r_pw_val_idevcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_idevcu-r_pw_val_idevcu) if source_year==`y' & !missing(pw_val_idevcu,r_pw_val_idevcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_idevcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_iinput!=r_pw_val_iinput
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_iinput) & !missing(r_pw_val_iinput)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_iinput) & missing(r_pw_val_iinput)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_iinput,r_pw_val_iinput) & pw_val_iinput!=r_pw_val_iinput
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_iinput-r_pw_val_iinput) if source_year==`y' & !missing(pw_val_iinput,r_pw_val_iinput)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_iinput") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_iinvcu!=r_pw_val_iinvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_iinvcu) & !missing(r_pw_val_iinvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_iinvcu) & missing(r_pw_val_iinvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_iinvcu,r_pw_val_iinvcu) & pw_val_iinvcu!=r_pw_val_iinvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_iinvcu-r_pw_val_iinvcu) if source_year==`y' & !missing(pw_val_iinvcu,r_pw_val_iinvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_iinvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_iisfov!=r_pw_val_iisfov
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_iisfov) & !missing(r_pw_val_iisfov)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_iisfov) & missing(r_pw_val_iisfov)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_iisfov,r_pw_val_iisfov) & pw_val_iisfov!=r_pw_val_iisfov
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_iisfov-r_pw_val_iisfov) if source_year==`y' & !missing(pw_val_iisfov,r_pw_val_iisfov)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_iisfov") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_iislov!=r_pw_val_iislov
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_iislov) & !missing(r_pw_val_iislov)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_iislov) & missing(r_pw_val_iislov)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_iislov,r_pw_val_iislov) & pw_val_iislov!=r_pw_val_iislov
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_iislov-r_pw_val_iislov) if source_year==`y' & !missing(pw_val_iislov,r_pw_val_iislov)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_iislov") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_iisvcu!=r_pw_val_iisvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_iisvcu) & !missing(r_pw_val_iisvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_iisvcu) & missing(r_pw_val_iisvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_iisvcu,r_pw_val_iisvcu) & pw_val_iisvcu!=r_pw_val_iisvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_iisvcu-r_pw_val_iisvcu) if source_year==`y' & !missing(pw_val_iisvcu,r_pw_val_iisvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_iisvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_ikivcu!=r_pw_val_ikivcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_ikivcu) & !missing(r_pw_val_ikivcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_ikivcu) & missing(r_pw_val_ikivcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_ikivcu,r_pw_val_ikivcu) & pw_val_ikivcu!=r_pw_val_ikivcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_ikivcu-r_pw_val_ikivcu) if source_year==`y' & !missing(pw_val_ikivcu,r_pw_val_ikivcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_ikivcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_iklvcu!=r_pw_val_iklvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_iklvcu) & !missing(r_pw_val_iklvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_iklvcu) & missing(r_pw_val_iklvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_iklvcu,r_pw_val_iklvcu) & pw_val_iklvcu!=r_pw_val_iklvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_iklvcu-r_pw_val_iklvcu) if source_year==`y' & !missing(pw_val_iklvcu,r_pw_val_iklvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_iklvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_ikovcu!=r_pw_val_ikovcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_ikovcu) & !missing(r_pw_val_ikovcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_ikovcu) & missing(r_pw_val_ikovcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_ikovcu,r_pw_val_ikovcu) & pw_val_ikovcu!=r_pw_val_ikovcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_ikovcu-r_pw_val_ikovcu) if source_year==`y' & !missing(pw_val_ikovcu,r_pw_val_ikovcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_ikovcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_ilrvcu!=r_pw_val_ilrvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_ilrvcu) & !missing(r_pw_val_ilrvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_ilrvcu) & missing(r_pw_val_ilrvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_ilrvcu,r_pw_val_ilrvcu) & pw_val_ilrvcu!=r_pw_val_ilrvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_ilrvcu-r_pw_val_ilrvcu) if source_year==`y' & !missing(pw_val_ilrvcu,r_pw_val_ilrvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_ilrvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_insvcu!=r_pw_val_insvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_insvcu) & !missing(r_pw_val_insvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_insvcu) & missing(r_pw_val_insvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_insvcu,r_pw_val_insvcu) & pw_val_insvcu!=r_pw_val_insvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_insvcu-r_pw_val_insvcu) if source_year==`y' & !missing(pw_val_insvcu,r_pw_val_insvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_insvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_intvcu!=r_pw_val_intvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_intvcu) & !missing(r_pw_val_intvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_intvcu) & missing(r_pw_val_intvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_intvcu,r_pw_val_intvcu) & pw_val_intvcu!=r_pw_val_intvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_intvcu-r_pw_val_intvcu) if source_year==`y' & !missing(pw_val_intvcu,r_pw_val_intvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_intvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_iotvcu!=r_pw_val_iotvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_iotvcu) & !missing(r_pw_val_iotvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_iotvcu) & missing(r_pw_val_iotvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_iotvcu,r_pw_val_iotvcu) & pw_val_iotvcu!=r_pw_val_iotvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_iotvcu-r_pw_val_iotvcu) if source_year==`y' & !missing(pw_val_iotvcu,r_pw_val_iotvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_iotvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_ipkvcu!=r_pw_val_ipkvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_ipkvcu) & !missing(r_pw_val_ipkvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_ipkvcu) & missing(r_pw_val_ipkvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_ipkvcu,r_pw_val_ipkvcu) & pw_val_ipkvcu!=r_pw_val_ipkvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_ipkvcu-r_pw_val_ipkvcu) if source_year==`y' & !missing(pw_val_ipkvcu,r_pw_val_ipkvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_ipkvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_iprvcu!=r_pw_val_iprvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_iprvcu) & !missing(r_pw_val_iprvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_iprvcu) & missing(r_pw_val_iprvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_iprvcu,r_pw_val_iprvcu) & pw_val_iprvcu!=r_pw_val_iprvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_iprvcu-r_pw_val_iprvcu) if source_year==`y' & !missing(pw_val_iprvcu,r_pw_val_iprvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_iprvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_irdvcu!=r_pw_val_irdvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_irdvcu) & !missing(r_pw_val_irdvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_irdvcu) & missing(r_pw_val_irdvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_irdvcu,r_pw_val_irdvcu) & pw_val_irdvcu!=r_pw_val_irdvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_irdvcu-r_pw_val_irdvcu) if source_year==`y' & !missing(pw_val_irdvcu,r_pw_val_irdvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_irdvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_irevcu!=r_pw_val_irevcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_irevcu) & !missing(r_pw_val_irevcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_irevcu) & missing(r_pw_val_irevcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_irevcu,r_pw_val_irevcu) & pw_val_irevcu!=r_pw_val_irevcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_irevcu-r_pw_val_irevcu) if source_year==`y' & !missing(pw_val_irevcu,r_pw_val_irevcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_irevcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_irrvcu!=r_pw_val_irrvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_irrvcu) & !missing(r_pw_val_irrvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_irrvcu) & missing(r_pw_val_irrvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_irrvcu,r_pw_val_irrvcu) & pw_val_irrvcu!=r_pw_val_irrvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_irrvcu-r_pw_val_irrvcu) if source_year==`y' & !missing(pw_val_irrvcu,r_pw_val_irrvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_irrvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_itxvcu!=r_pw_val_itxvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_itxvcu) & !missing(r_pw_val_itxvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_itxvcu) & missing(r_pw_val_itxvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_itxvcu,r_pw_val_itxvcu) & pw_val_itxvcu!=r_pw_val_itxvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_itxvcu-r_pw_val_itxvcu) if source_year==`y' & !missing(pw_val_itxvcu,r_pw_val_itxvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_itxvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_iuwvcu!=r_pw_val_iuwvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_iuwvcu) & !missing(r_pw_val_iuwvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_iuwvcu) & missing(r_pw_val_iuwvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_iuwvcu,r_pw_val_iuwvcu) & pw_val_iuwvcu!=r_pw_val_iuwvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_iuwvcu-r_pw_val_iuwvcu) if source_year==`y' & !missing(pw_val_iuwvcu,r_pw_val_iuwvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_iuwvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_nopvcu!=r_pw_val_nopvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_nopvcu) & !missing(r_pw_val_nopvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_nopvcu) & missing(r_pw_val_nopvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_nopvcu,r_pw_val_nopvcu) & pw_val_nopvcu!=r_pw_val_nopvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_nopvcu-r_pw_val_nopvcu) if source_year==`y' & !missing(pw_val_nopvcu,r_pw_val_nopvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_nopvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_othvcu!=r_pw_val_othvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_othvcu) & !missing(r_pw_val_othvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_othvcu) & missing(r_pw_val_othvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_othvcu,r_pw_val_othvcu) & pw_val_othvcu!=r_pw_val_othvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_othvcu-r_pw_val_othvcu) if source_year==`y' & !missing(pw_val_othvcu,r_pw_val_othvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_othvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_output!=r_pw_val_output
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_output) & !missing(r_pw_val_output)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_output) & missing(r_pw_val_output)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_output,r_pw_val_output) & pw_val_output!=r_pw_val_output
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_output-r_pw_val_output) if source_year==`y' & !missing(pw_val_output,r_pw_val_output)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_output") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_rdnvcu!=r_pw_val_rdnvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_rdnvcu) & !missing(r_pw_val_rdnvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_rdnvcu) & missing(r_pw_val_rdnvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_rdnvcu,r_pw_val_rdnvcu) & pw_val_rdnvcu!=r_pw_val_rdnvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_rdnvcu-r_pw_val_rdnvcu) if source_year==`y' & !missing(pw_val_rdnvcu,r_pw_val_rdnvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_rdnvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_renvcu!=r_pw_val_renvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_renvcu) & !missing(r_pw_val_renvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_renvcu) & missing(r_pw_val_renvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_renvcu,r_pw_val_renvcu) & pw_val_renvcu!=r_pw_val_renvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_renvcu-r_pw_val_renvcu) if source_year==`y' & !missing(pw_val_renvcu,r_pw_val_renvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_renvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_rimvcu!=r_pw_val_rimvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_rimvcu) & !missing(r_pw_val_rimvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_rimvcu) & missing(r_pw_val_rimvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_rimvcu,r_pw_val_rimvcu) & pw_val_rimvcu!=r_pw_val_rimvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_rimvcu-r_pw_val_rimvcu) if source_year==`y' & !missing(pw_val_rimvcu,r_pw_val_rimvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_rimvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_rtlvcu!=r_pw_val_rtlvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_rtlvcu) & !missing(r_pw_val_rtlvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_rtlvcu) & missing(r_pw_val_rtlvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_rtlvcu,r_pw_val_rtlvcu) & pw_val_rtlvcu!=r_pw_val_rtlvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_rtlvcu-r_pw_val_rtlvcu) if source_year==`y' & !missing(pw_val_rtlvcu,r_pw_val_rtlvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_rtlvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_sfbvcu!=r_pw_val_sfbvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_sfbvcu) & !missing(r_pw_val_sfbvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_sfbvcu) & missing(r_pw_val_sfbvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_sfbvcu,r_pw_val_sfbvcu) & pw_val_sfbvcu!=r_pw_val_sfbvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_sfbvcu-r_pw_val_sfbvcu) if source_year==`y' & !missing(pw_val_sfbvcu,r_pw_val_sfbvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_sfbvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_sfcvcu!=r_pw_val_sfcvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_sfcvcu) & !missing(r_pw_val_sfcvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_sfcvcu) & missing(r_pw_val_sfcvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_sfcvcu,r_pw_val_sfcvcu) & pw_val_sfcvcu!=r_pw_val_sfcvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_sfcvcu-r_pw_val_sfcvcu) if source_year==`y' & !missing(pw_val_sfcvcu,r_pw_val_sfcvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_sfcvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_sfdvcu!=r_pw_val_sfdvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_sfdvcu) & !missing(r_pw_val_sfdvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_sfdvcu) & missing(r_pw_val_sfdvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_sfdvcu,r_pw_val_sfdvcu) & pw_val_sfdvcu!=r_pw_val_sfdvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_sfdvcu-r_pw_val_sfdvcu) if source_year==`y' & !missing(pw_val_sfdvcu,r_pw_val_sfdvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_sfdvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_sfgvcu!=r_pw_val_sfgvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_sfgvcu) & !missing(r_pw_val_sfgvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_sfgvcu) & missing(r_pw_val_sfgvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_sfgvcu,r_pw_val_sfgvcu) & pw_val_sfgvcu!=r_pw_val_sfgvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_sfgvcu-r_pw_val_sfgvcu) if source_year==`y' & !missing(pw_val_sfgvcu,r_pw_val_sfgvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_sfgvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_sfjvcu!=r_pw_val_sfjvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_sfjvcu) & !missing(r_pw_val_sfjvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_sfjvcu) & missing(r_pw_val_sfjvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_sfjvcu,r_pw_val_sfjvcu) & pw_val_sfjvcu!=r_pw_val_sfjvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_sfjvcu-r_pw_val_sfjvcu) if source_year==`y' & !missing(pw_val_sfjvcu,r_pw_val_sfjvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_sfjvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_sfkvcu!=r_pw_val_sfkvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_sfkvcu) & !missing(r_pw_val_sfkvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_sfkvcu) & missing(r_pw_val_sfkvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_sfkvcu,r_pw_val_sfkvcu) & pw_val_sfkvcu!=r_pw_val_sfkvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_sfkvcu-r_pw_val_sfkvcu) if source_year==`y' & !missing(pw_val_sfkvcu,r_pw_val_sfkvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_sfkvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_sfnvcu!=r_pw_val_sfnvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_sfnvcu) & !missing(r_pw_val_sfnvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_sfnvcu) & missing(r_pw_val_sfnvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_sfnvcu,r_pw_val_sfnvcu) & pw_val_sfnvcu!=r_pw_val_sfnvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_sfnvcu-r_pw_val_sfnvcu) if source_year==`y' & !missing(pw_val_sfnvcu,r_pw_val_sfnvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_sfnvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_sfovcu!=r_pw_val_sfovcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_sfovcu) & !missing(r_pw_val_sfovcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_sfovcu) & missing(r_pw_val_sfovcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_sfovcu,r_pw_val_sfovcu) & pw_val_sfovcu!=r_pw_val_sfovcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_sfovcu-r_pw_val_sfovcu) if source_year==`y' & !missing(pw_val_sfovcu,r_pw_val_sfovcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_sfovcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_sfrvcu!=r_pw_val_sfrvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_sfrvcu) & !missing(r_pw_val_sfrvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_sfrvcu) & missing(r_pw_val_sfrvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_sfrvcu,r_pw_val_sfrvcu) & pw_val_sfrvcu!=r_pw_val_sfrvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_sfrvcu-r_pw_val_sfrvcu) if source_year==`y' & !missing(pw_val_sfrvcu,r_pw_val_sfrvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_sfrvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_sfsvcu!=r_pw_val_sfsvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_sfsvcu) & !missing(r_pw_val_sfsvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_sfsvcu) & missing(r_pw_val_sfsvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_sfsvcu,r_pw_val_sfsvcu) & pw_val_sfsvcu!=r_pw_val_sfsvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_sfsvcu-r_pw_val_sfsvcu) if source_year==`y' & !missing(pw_val_sfsvcu,r_pw_val_sfsvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_sfsvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_sfuvcu!=r_pw_val_sfuvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_sfuvcu) & !missing(r_pw_val_sfuvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_sfuvcu) & missing(r_pw_val_sfuvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_sfuvcu,r_pw_val_sfuvcu) & pw_val_sfuvcu!=r_pw_val_sfuvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_sfuvcu-r_pw_val_sfuvcu) if source_year==`y' & !missing(pw_val_sfuvcu,r_pw_val_sfuvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_sfuvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_shdvcu!=r_pw_val_shdvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_shdvcu) & !missing(r_pw_val_shdvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_shdvcu) & missing(r_pw_val_shdvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_shdvcu,r_pw_val_shdvcu) & pw_val_shdvcu!=r_pw_val_shdvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_shdvcu-r_pw_val_shdvcu) if source_year==`y' & !missing(pw_val_shdvcu,r_pw_val_shdvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_shdvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_shfvcu!=r_pw_val_shfvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_shfvcu) & !missing(r_pw_val_shfvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_shfvcu) & missing(r_pw_val_shfvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_shfvcu,r_pw_val_shfvcu) & pw_val_shfvcu!=r_pw_val_shfvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_shfvcu-r_pw_val_shfvcu) if source_year==`y' & !missing(pw_val_shfvcu,r_pw_val_shfvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_shfvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_shjvcu!=r_pw_val_shjvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_shjvcu) & !missing(r_pw_val_shjvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_shjvcu) & missing(r_pw_val_shjvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_shjvcu,r_pw_val_shjvcu) & pw_val_shjvcu!=r_pw_val_shjvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_shjvcu-r_pw_val_shjvcu) if source_year==`y' & !missing(pw_val_shjvcu,r_pw_val_shjvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_shjvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_srdvcu!=r_pw_val_srdvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_srdvcu) & !missing(r_pw_val_srdvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_srdvcu) & missing(r_pw_val_srdvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_srdvcu,r_pw_val_srdvcu) & pw_val_srdvcu!=r_pw_val_srdvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_srdvcu-r_pw_val_srdvcu) if source_year==`y' & !missing(pw_val_srdvcu,r_pw_val_srdvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_srdvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_srjvcu!=r_pw_val_srjvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_srjvcu) & !missing(r_pw_val_srjvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_srjvcu) & missing(r_pw_val_srjvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_srjvcu,r_pw_val_srjvcu) & pw_val_srjvcu!=r_pw_val_srjvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_srjvcu-r_pw_val_srjvcu) if source_year==`y' & !missing(pw_val_srjvcu,r_pw_val_srjvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_srjvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_srmvcu!=r_pw_val_srmvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_srmvcu) & !missing(r_pw_val_srmvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_srmvcu) & missing(r_pw_val_srmvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_srmvcu,r_pw_val_srmvcu) & pw_val_srmvcu!=r_pw_val_srmvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_srmvcu-r_pw_val_srmvcu) if source_year==`y' & !missing(pw_val_srmvcu,r_pw_val_srmvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_srmvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_stdvcu!=r_pw_val_stdvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_stdvcu) & !missing(r_pw_val_stdvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_stdvcu) & missing(r_pw_val_stdvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_stdvcu,r_pw_val_stdvcu) & pw_val_stdvcu!=r_pw_val_stdvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_stdvcu-r_pw_val_stdvcu) if source_year==`y' & !missing(pw_val_stdvcu,r_pw_val_stdvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_stdvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_stjvcu!=r_pw_val_stjvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_stjvcu) & !missing(r_pw_val_stjvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_stjvcu) & missing(r_pw_val_stjvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_stjvcu,r_pw_val_stjvcu) & pw_val_stjvcu!=r_pw_val_stjvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_stjvcu-r_pw_val_stjvcu) if source_year==`y' & !missing(pw_val_stjvcu,r_pw_val_stjvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_stjvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_stlvcu!=r_pw_val_stlvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_stlvcu) & !missing(r_pw_val_stlvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_stlvcu) & missing(r_pw_val_stlvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_stlvcu,r_pw_val_stlvcu) & pw_val_stlvcu!=r_pw_val_stlvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_stlvcu-r_pw_val_stlvcu) if source_year==`y' & !missing(pw_val_stlvcu,r_pw_val_stlvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_stlvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_vtlvcu!=r_pw_val_vtlvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_vtlvcu) & !missing(r_pw_val_vtlvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_vtlvcu) & missing(r_pw_val_vtlvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_vtlvcu,r_pw_val_vtlvcu) & pw_val_vtlvcu!=r_pw_val_vtlvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_vtlvcu-r_pw_val_vtlvcu) if source_year==`y' & !missing(pw_val_vtlvcu,r_pw_val_vtlvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_vtlvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_yelvcu!=r_pw_val_yelvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_yelvcu) & !missing(r_pw_val_yelvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_yelvcu) & missing(r_pw_val_yelvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_yelvcu,r_pw_val_yelvcu) & pw_val_yelvcu!=r_pw_val_yelvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_yelvcu-r_pw_val_yelvcu) if source_year==`y' & !missing(pw_val_yelvcu,r_pw_val_yelvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_yelvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_yisvcu!=r_pw_val_yisvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_yisvcu) & !missing(r_pw_val_yisvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_yisvcu) & missing(r_pw_val_yisvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_yisvcu,r_pw_val_yisvcu) & pw_val_yisvcu!=r_pw_val_yisvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_yisvcu-r_pw_val_yisvcu) if source_year==`y' & !missing(pw_val_yisvcu,r_pw_val_yisvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_yisvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_yisvdo!=r_pw_val_yisvdo
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_yisvdo) & !missing(r_pw_val_yisvdo)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_yisvdo) & missing(r_pw_val_yisvdo)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_yisvdo,r_pw_val_yisvdo) & pw_val_yisvdo!=r_pw_val_yisvdo
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_yisvdo-r_pw_val_yisvdo) if source_year==`y' & !missing(pw_val_yisvdo,r_pw_val_yisvdo)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_yisvdo") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_yisvfo!=r_pw_val_yisvfo
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_yisvfo) & !missing(r_pw_val_yisvfo)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_yisvfo) & missing(r_pw_val_yisvfo)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_yisvfo,r_pw_val_yisvfo) & pw_val_yisvfo!=r_pw_val_yisvfo
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_yisvfo-r_pw_val_yisvfo) if source_year==`y' & !missing(pw_val_yisvfo,r_pw_val_yisvfo)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_yisvfo") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_ykdvcu!=r_pw_val_ykdvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_ykdvcu) & !missing(r_pw_val_ykdvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_ykdvcu) & missing(r_pw_val_ykdvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_ykdvcu,r_pw_val_ykdvcu) & pw_val_ykdvcu!=r_pw_val_ykdvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_ykdvcu-r_pw_val_ykdvcu) if source_year==`y' & !missing(pw_val_ykdvcu,r_pw_val_ykdvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_ykdvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_ykfvcu!=r_pw_val_ykfvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_ykfvcu) & !missing(r_pw_val_ykfvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_ykfvcu) & missing(r_pw_val_ykfvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_ykfvcu,r_pw_val_ykfvcu) & pw_val_ykfvcu!=r_pw_val_ykfvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_ykfvcu-r_pw_val_ykfvcu) if source_year==`y' & !missing(pw_val_ykfvcu,r_pw_val_ykfvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_ykfvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_ykivcu!=r_pw_val_ykivcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_ykivcu) & !missing(r_pw_val_ykivcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_ykivcu) & missing(r_pw_val_ykivcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_ykivcu,r_pw_val_ykivcu) & pw_val_ykivcu!=r_pw_val_ykivcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_ykivcu-r_pw_val_ykivcu) if source_year==`y' & !missing(pw_val_ykivcu,r_pw_val_ykivcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_ykivcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_yprvcu!=r_pw_val_yprvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_yprvcu) & !missing(r_pw_val_yprvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_yprvcu) & missing(r_pw_val_yprvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_yprvcu,r_pw_val_yprvcu) & pw_val_yprvcu!=r_pw_val_yprvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_yprvcu-r_pw_val_yprvcu) if source_year==`y' & !missing(pw_val_yprvcu,r_pw_val_yprvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_yprvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_yrnvcu!=r_pw_val_yrnvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_yrnvcu) & !missing(r_pw_val_yrnvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_yrnvcu) & missing(r_pw_val_yrnvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_yrnvcu,r_pw_val_yrnvcu) & pw_val_yrnvcu!=r_pw_val_yrnvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_yrnvcu-r_pw_val_yrnvcu) if source_year==`y' & !missing(pw_val_yrnvcu,r_pw_val_yrnvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_yrnvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_yrsvcu!=r_pw_val_yrsvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_yrsvcu) & !missing(r_pw_val_yrsvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_yrsvcu) & missing(r_pw_val_yrsvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_yrsvcu,r_pw_val_yrsvcu) & pw_val_yrsvcu!=r_pw_val_yrsvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_yrsvcu-r_pw_val_yrsvcu) if source_year==`y' & !missing(pw_val_yrsvcu,r_pw_val_yrsvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_yrsvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_ysnvcu!=r_pw_val_ysnvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_ysnvcu) & !missing(r_pw_val_ysnvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_ysnvcu) & missing(r_pw_val_ysnvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_ysnvcu,r_pw_val_ysnvcu) & pw_val_ysnvcu!=r_pw_val_ysnvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_ysnvcu-r_pw_val_ysnvcu) if source_year==`y' & !missing(pw_val_ysnvcu,r_pw_val_ysnvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_ysnvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_ytovcu!=r_pw_val_ytovcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_ytovcu) & !missing(r_pw_val_ytovcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_ytovcu) & missing(r_pw_val_ytovcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_ytovcu,r_pw_val_ytovcu) & pw_val_ytovcu!=r_pw_val_ytovcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_ytovcu-r_pw_val_ytovcu) if source_year==`y' & !missing(pw_val_ytovcu,r_pw_val_ytovcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_ytovcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_znavcu!=r_pw_val_znavcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_znavcu) & !missing(r_pw_val_znavcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_znavcu) & missing(r_pw_val_znavcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_znavcu,r_pw_val_znavcu) & pw_val_znavcu!=r_pw_val_znavcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_znavcu-r_pw_val_znavcu) if source_year==`y' & !missing(pw_val_znavcu,r_pw_val_znavcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_znavcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_zndvcu!=r_pw_val_zndvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_zndvcu) & !missing(r_pw_val_zndvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_zndvcu) & missing(r_pw_val_zndvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_zndvcu,r_pw_val_zndvcu) & pw_val_zndvcu!=r_pw_val_zndvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_zndvcu-r_pw_val_zndvcu) if source_year==`y' & !missing(pw_val_zndvcu,r_pw_val_zndvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_zndvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_znevcu!=r_pw_val_znevcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_znevcu) & !missing(r_pw_val_znevcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_znevcu) & missing(r_pw_val_znevcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_znevcu,r_pw_val_znevcu) & pw_val_znevcu!=r_pw_val_znevcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_znevcu-r_pw_val_znevcu) if source_year==`y' & !missing(pw_val_znevcu,r_pw_val_znevcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_znevcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_znhvcu!=r_pw_val_znhvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_znhvcu) & !missing(r_pw_val_znhvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_znhvcu) & missing(r_pw_val_znhvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_znhvcu,r_pw_val_znhvcu) & pw_val_znhvcu!=r_pw_val_znhvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_znhvcu-r_pw_val_znhvcu) if source_year==`y' & !missing(pw_val_znhvcu,r_pw_val_znhvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_znhvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_znivcu!=r_pw_val_znivcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_znivcu) & !missing(r_pw_val_znivcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_znivcu) & missing(r_pw_val_znivcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_znivcu,r_pw_val_znivcu) & pw_val_znivcu!=r_pw_val_znivcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_znivcu-r_pw_val_znivcu) if source_year==`y' & !missing(pw_val_znivcu,r_pw_val_znivcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_znivcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_znovcu!=r_pw_val_znovcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_znovcu) & !missing(r_pw_val_znovcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_znovcu) & missing(r_pw_val_znovcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_znovcu,r_pw_val_znovcu) & pw_val_znovcu!=r_pw_val_znovcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_znovcu-r_pw_val_znovcu) if source_year==`y' & !missing(pw_val_znovcu,r_pw_val_znovcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_znovcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_znpvcu!=r_pw_val_znpvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_znpvcu) & !missing(r_pw_val_znpvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_znpvcu) & missing(r_pw_val_znpvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_znpvcu,r_pw_val_znpvcu) & pw_val_znpvcu!=r_pw_val_znpvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_znpvcu-r_pw_val_znpvcu) if source_year==`y' & !missing(pw_val_znpvcu,r_pw_val_znpvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_znpvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_znrvcu!=r_pw_val_znrvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_znrvcu) & !missing(r_pw_val_znrvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_znrvcu) & missing(r_pw_val_znrvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_znrvcu,r_pw_val_znrvcu) & pw_val_znrvcu!=r_pw_val_znrvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_znrvcu-r_pw_val_znrvcu) if source_year==`y' & !missing(pw_val_znrvcu,r_pw_val_znrvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_znrvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_znsvcu!=r_pw_val_znsvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_znsvcu) & !missing(r_pw_val_znsvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_znsvcu) & missing(r_pw_val_znsvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_znsvcu,r_pw_val_znsvcu) & pw_val_znsvcu!=r_pw_val_znsvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_znsvcu-r_pw_val_znsvcu) if source_year==`y' & !missing(pw_val_znsvcu,r_pw_val_znsvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_znsvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_zntvcu!=r_pw_val_zntvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_zntvcu) & !missing(r_pw_val_zntvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_zntvcu) & missing(r_pw_val_zntvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_zntvcu,r_pw_val_zntvcu) & pw_val_zntvcu!=r_pw_val_zntvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_zntvcu-r_pw_val_zntvcu) if source_year==`y' & !missing(pw_val_zntvcu,r_pw_val_zntvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_zntvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_zpavcu!=r_pw_val_zpavcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_zpavcu) & !missing(r_pw_val_zpavcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_zpavcu) & missing(r_pw_val_zpavcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_zpavcu,r_pw_val_zpavcu) & pw_val_zpavcu!=r_pw_val_zpavcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_zpavcu-r_pw_val_zpavcu) if source_year==`y' & !missing(pw_val_zpavcu,r_pw_val_zpavcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_zpavcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_zpdvcu!=r_pw_val_zpdvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_zpdvcu) & !missing(r_pw_val_zpdvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_zpdvcu) & missing(r_pw_val_zpdvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_zpdvcu,r_pw_val_zpdvcu) & pw_val_zpdvcu!=r_pw_val_zpdvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_zpdvcu-r_pw_val_zpdvcu) if source_year==`y' & !missing(pw_val_zpdvcu,r_pw_val_zpdvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_zpdvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_zpevcu!=r_pw_val_zpevcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_zpevcu) & !missing(r_pw_val_zpevcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_zpevcu) & missing(r_pw_val_zpevcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_zpevcu,r_pw_val_zpevcu) & pw_val_zpevcu!=r_pw_val_zpevcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_zpevcu-r_pw_val_zpevcu) if source_year==`y' & !missing(pw_val_zpevcu,r_pw_val_zpevcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_zpevcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_zphvcu!=r_pw_val_zphvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_zphvcu) & !missing(r_pw_val_zphvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_zphvcu) & missing(r_pw_val_zphvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_zphvcu,r_pw_val_zphvcu) & pw_val_zphvcu!=r_pw_val_zphvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_zphvcu-r_pw_val_zphvcu) if source_year==`y' & !missing(pw_val_zphvcu,r_pw_val_zphvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_zphvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_zpivcu!=r_pw_val_zpivcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_zpivcu) & !missing(r_pw_val_zpivcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_zpivcu) & missing(r_pw_val_zpivcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_zpivcu,r_pw_val_zpivcu) & pw_val_zpivcu!=r_pw_val_zpivcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_zpivcu-r_pw_val_zpivcu) if source_year==`y' & !missing(pw_val_zpivcu,r_pw_val_zpivcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_zpivcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_zpovcu!=r_pw_val_zpovcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_zpovcu) & !missing(r_pw_val_zpovcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_zpovcu) & missing(r_pw_val_zpovcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_zpovcu,r_pw_val_zpovcu) & pw_val_zpovcu!=r_pw_val_zpovcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_zpovcu-r_pw_val_zpovcu) if source_year==`y' & !missing(pw_val_zpovcu,r_pw_val_zpovcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_zpovcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_zppvcu!=r_pw_val_zppvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_zppvcu) & !missing(r_pw_val_zppvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_zppvcu) & missing(r_pw_val_zppvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_zppvcu,r_pw_val_zppvcu) & pw_val_zppvcu!=r_pw_val_zppvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_zppvcu-r_pw_val_zppvcu) if source_year==`y' & !missing(pw_val_zppvcu,r_pw_val_zppvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_zppvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_zprvcu!=r_pw_val_zprvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_zprvcu) & !missing(r_pw_val_zprvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_zprvcu) & missing(r_pw_val_zprvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_zprvcu,r_pw_val_zprvcu) & pw_val_zprvcu!=r_pw_val_zprvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_zprvcu-r_pw_val_zprvcu) if source_year==`y' & !missing(pw_val_zprvcu,r_pw_val_zprvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_zprvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_zpsvcu!=r_pw_val_zpsvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_zpsvcu) & !missing(r_pw_val_zpsvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_zpsvcu) & missing(r_pw_val_zpsvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_zpsvcu,r_pw_val_zpsvcu) & pw_val_zpsvcu!=r_pw_val_zpsvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_zpsvcu-r_pw_val_zpsvcu) if source_year==`y' & !missing(pw_val_zpsvcu,r_pw_val_zpsvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_zpsvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & pw_val_zptvcu!=r_pw_val_zptvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(pw_val_zptvcu) & !missing(r_pw_val_zptvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(pw_val_zptvcu) & missing(r_pw_val_zptvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(pw_val_zptvcu,r_pw_val_zptvcu) & pw_val_zptvcu!=r_pw_val_zptvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(pw_val_zptvcu-r_pw_val_zptvcu) if source_year==`y' & !missing(pw_val_zptvcu,r_pw_val_zptvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_pw_val_zptvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_output_nominal!=r_ln_output_nominal
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_output_nominal) & !missing(r_ln_output_nominal)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_output_nominal) & missing(r_ln_output_nominal)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_output_nominal,r_ln_output_nominal) & ln_output_nominal!=r_ln_output_nominal
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_output_nominal-r_ln_output_nominal) if source_year==`y' & !missing(ln_output_nominal,r_ln_output_nominal)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_output_nominal") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_va_nominal!=r_ln_va_nominal
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_va_nominal) & !missing(r_ln_va_nominal)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_va_nominal) & missing(r_ln_va_nominal)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_va_nominal,r_ln_va_nominal) & ln_va_nominal!=r_ln_va_nominal
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_va_nominal-r_ln_va_nominal) if source_year==`y' & !missing(ln_va_nominal,r_ln_va_nominal)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_va_nominal") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_capital_nominal!=r_ln_capital_nominal
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_capital_nominal) & !missing(r_ln_capital_nominal)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_capital_nominal) & missing(r_ln_capital_nominal)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_capital_nominal,r_ln_capital_nominal) & ln_capital_nominal!=r_ln_capital_nominal
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_capital_nominal-r_ln_capital_nominal) if source_year==`y' & !missing(ln_capital_nominal,r_ln_capital_nominal)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_capital_nominal") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_inputs_nominal!=r_ln_inputs_nominal
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_inputs_nominal) & !missing(r_ln_inputs_nominal)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_inputs_nominal) & missing(r_ln_inputs_nominal)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_inputs_nominal,r_ln_inputs_nominal) & ln_inputs_nominal!=r_ln_inputs_nominal
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_inputs_nominal-r_ln_inputs_nominal) if source_year==`y' & !missing(ln_inputs_nominal,r_ln_inputs_nominal)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_inputs_nominal") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_workers!=r_ln_workers
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_workers) & !missing(r_ln_workers)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_workers) & missing(r_ln_workers)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_workers,r_ln_workers) & ln_workers!=r_ln_workers
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_workers-r_ln_workers) if source_year==`y' & !missing(ln_workers,r_ln_workers)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_workers") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_total_gj_s1!=r_ln_total_gj_s1
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_total_gj_s1) & !missing(r_ln_total_gj_s1)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_total_gj_s1) & missing(r_ln_total_gj_s1)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_total_gj_s1,r_ln_total_gj_s1) & ln_total_gj_s1!=r_ln_total_gj_s1
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_total_gj_s1-r_ln_total_gj_s1) if source_year==`y' & !missing(ln_total_gj_s1,r_ln_total_gj_s1)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_total_gj_s1") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_co2_total_s1!=r_ln_co2_total_s1
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_co2_total_s1) & !missing(r_ln_co2_total_s1)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_co2_total_s1) & missing(r_ln_co2_total_s1)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_co2_total_s1,r_ln_co2_total_s1) & ln_co2_total_s1!=r_ln_co2_total_s1
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_co2_total_s1-r_ln_co2_total_s1) if source_year==`y' & !missing(ln_co2_total_s1,r_ln_co2_total_s1)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_co2_total_s1") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_energy_expenditure!=r_ln_energy_expenditure
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_energy_expenditure) & !missing(r_ln_energy_expenditure)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_energy_expenditure) & missing(r_ln_energy_expenditure)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_energy_expenditure,r_ln_energy_expenditure) & ln_energy_expenditure!=r_ln_energy_expenditure
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_energy_expenditure-r_ln_energy_expenditure) if source_year==`y' & !missing(ln_energy_expenditure,r_ln_energy_expenditure)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_energy_expenditure") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_import_nominal!=r_ln_import_nominal
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_import_nominal) & !missing(r_ln_import_nominal)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_import_nominal) & missing(r_ln_import_nominal)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_import_nominal,r_ln_import_nominal) & ln_import_nominal!=r_ln_import_nominal
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_import_nominal-r_ln_import_nominal) if source_year==`y' & !missing(ln_import_nominal,r_ln_import_nominal)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_import_nominal") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_rd_cost_nominal!=r_ln_rd_cost_nominal
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_rd_cost_nominal) & !missing(r_ln_rd_cost_nominal)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_rd_cost_nominal) & missing(r_ln_rd_cost_nominal)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_rd_cost_nominal,r_ln_rd_cost_nominal) & ln_rd_cost_nominal!=r_ln_rd_cost_nominal
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_rd_cost_nominal-r_ln_rd_cost_nominal) if source_year==`y' & !missing(ln_rd_cost_nominal,r_ln_rd_cost_nominal)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_rd_cost_nominal") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_capital_stock_nominal!=r_ln_capital_stock_nominal
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_capital_stock_nominal) & !missing(r_ln_capital_stock_nominal)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_capital_stock_nominal) & missing(r_ln_capital_stock_nominal)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_capital_stock_nominal,r_ln_capital_stock_nominal) & ln_capital_stock_nominal!=r_ln_capital_stock_nominal
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_capital_stock_nominal-r_ln_capital_stock_nominal) if source_year==`y' & !missing(ln_capital_stock_nominal,r_ln_capital_stock_nominal)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_capital_stock_nominal") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_capital_additions_nominal!=r_ln_capital_additions_nominal
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_capital_additions_nominal) & !missing(r_ln_capital_additions_nominal)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_capital_additions_nominal) & missing(r_ln_capital_additions_nominal)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_capital_additions_nominal,r_ln_capital_additions_nominal) & ln_capital_additions_nominal!=r_ln_capital_additions_nominal
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_capital_additions_nominal-r_ln_capital_additions_nominal) if source_year==`y' & !missing(ln_capital_additions_nominal,r_ln_capital_additions_nominal)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_capital_additions_nominal") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_cbdacu!=r_ln_val_cbdacu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_cbdacu) & !missing(r_ln_val_cbdacu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_cbdacu) & missing(r_ln_val_cbdacu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_cbdacu,r_ln_val_cbdacu) & ln_val_cbdacu!=r_ln_val_cbdacu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_cbdacu-r_ln_val_cbdacu) if source_year==`y' & !missing(ln_val_cbdacu,r_ln_val_cbdacu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_cbdacu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_cbfpcu!=r_ln_val_cbfpcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_cbfpcu) & !missing(r_ln_val_cbfpcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_cbfpcu) & missing(r_ln_val_cbfpcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_cbfpcu,r_ln_val_cbfpcu) & ln_val_cbfpcu!=r_ln_val_cbfpcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_cbfpcu-r_ln_val_cbfpcu) if source_year==`y' & !missing(ln_val_cbfpcu,r_ln_val_cbfpcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_cbfpcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_cbsacu!=r_ln_val_cbsacu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_cbsacu) & !missing(r_ln_val_cbsacu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_cbsacu) & missing(r_ln_val_cbsacu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_cbsacu,r_ln_val_cbsacu) & ln_val_cbsacu!=r_ln_val_cbsacu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_cbsacu-r_ln_val_cbsacu) if source_year==`y' & !missing(ln_val_cbsacu,r_ln_val_cbsacu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_cbsacu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_cbttcu!=r_ln_val_cbttcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_cbttcu) & !missing(r_ln_val_cbttcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_cbttcu) & missing(r_ln_val_cbttcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_cbttcu,r_ln_val_cbttcu) & ln_val_cbttcu!=r_ln_val_cbttcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_cbttcu-r_ln_val_cbttcu) if source_year==`y' & !missing(ln_val_cbttcu,r_ln_val_cbttcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_cbttcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_cldacu!=r_ln_val_cldacu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_cldacu) & !missing(r_ln_val_cldacu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_cldacu) & missing(r_ln_val_cldacu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_cldacu,r_ln_val_cldacu) & ln_val_cldacu!=r_ln_val_cldacu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_cldacu-r_ln_val_cldacu) if source_year==`y' & !missing(ln_val_cldacu,r_ln_val_cldacu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_cldacu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_clfpcu!=r_ln_val_clfpcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_clfpcu) & !missing(r_ln_val_clfpcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_clfpcu) & missing(r_ln_val_clfpcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_clfpcu,r_ln_val_clfpcu) & ln_val_clfpcu!=r_ln_val_clfpcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_clfpcu-r_ln_val_clfpcu) if source_year==`y' & !missing(ln_val_clfpcu,r_ln_val_clfpcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_clfpcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_clsacu!=r_ln_val_clsacu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_clsacu) & !missing(r_ln_val_clsacu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_clsacu) & missing(r_ln_val_clsacu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_clsacu,r_ln_val_clsacu) & ln_val_clsacu!=r_ln_val_clsacu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_clsacu-r_ln_val_clsacu) if source_year==`y' & !missing(ln_val_clsacu,r_ln_val_clsacu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_clsacu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_clttcu!=r_ln_val_clttcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_clttcu) & !missing(r_ln_val_clttcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_clttcu) & missing(r_ln_val_clttcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_clttcu,r_ln_val_clttcu) & ln_val_clttcu!=r_ln_val_clttcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_clttcu-r_ln_val_clttcu) if source_year==`y' & !missing(ln_val_clttcu,r_ln_val_clttcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_clttcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_cmdacu!=r_ln_val_cmdacu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_cmdacu) & !missing(r_ln_val_cmdacu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_cmdacu) & missing(r_ln_val_cmdacu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_cmdacu,r_ln_val_cmdacu) & ln_val_cmdacu!=r_ln_val_cmdacu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_cmdacu-r_ln_val_cmdacu) if source_year==`y' & !missing(ln_val_cmdacu,r_ln_val_cmdacu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_cmdacu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_cmfpcu!=r_ln_val_cmfpcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_cmfpcu) & !missing(r_ln_val_cmfpcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_cmfpcu) & missing(r_ln_val_cmfpcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_cmfpcu,r_ln_val_cmfpcu) & ln_val_cmfpcu!=r_ln_val_cmfpcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_cmfpcu-r_ln_val_cmfpcu) if source_year==`y' & !missing(ln_val_cmfpcu,r_ln_val_cmfpcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_cmfpcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_cmsacu!=r_ln_val_cmsacu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_cmsacu) & !missing(r_ln_val_cmsacu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_cmsacu) & missing(r_ln_val_cmsacu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_cmsacu,r_ln_val_cmsacu) & ln_val_cmsacu!=r_ln_val_cmsacu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_cmsacu-r_ln_val_cmsacu) if source_year==`y' & !missing(ln_val_cmsacu,r_ln_val_cmsacu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_cmsacu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_cmttcu!=r_ln_val_cmttcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_cmttcu) & !missing(r_ln_val_cmttcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_cmttcu) & missing(r_ln_val_cmttcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_cmttcu,r_ln_val_cmttcu) & ln_val_cmttcu!=r_ln_val_cmttcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_cmttcu-r_ln_val_cmttcu) if source_year==`y' & !missing(ln_val_cmttcu,r_ln_val_cmttcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_cmttcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_codacu!=r_ln_val_codacu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_codacu) & !missing(r_ln_val_codacu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_codacu) & missing(r_ln_val_codacu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_codacu,r_ln_val_codacu) & ln_val_codacu!=r_ln_val_codacu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_codacu-r_ln_val_codacu) if source_year==`y' & !missing(ln_val_codacu,r_ln_val_codacu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_codacu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_cofpcu!=r_ln_val_cofpcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_cofpcu) & !missing(r_ln_val_cofpcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_cofpcu) & missing(r_ln_val_cofpcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_cofpcu,r_ln_val_cofpcu) & ln_val_cofpcu!=r_ln_val_cofpcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_cofpcu-r_ln_val_cofpcu) if source_year==`y' & !missing(ln_val_cofpcu,r_ln_val_cofpcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_cofpcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_cosacu!=r_ln_val_cosacu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_cosacu) & !missing(r_ln_val_cosacu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_cosacu) & missing(r_ln_val_cosacu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_cosacu,r_ln_val_cosacu) & ln_val_cosacu!=r_ln_val_cosacu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_cosacu-r_ln_val_cosacu) if source_year==`y' & !missing(ln_val_cosacu,r_ln_val_cosacu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_cosacu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_costrd!=r_ln_val_costrd
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_costrd) & !missing(r_ln_val_costrd)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_costrd) & missing(r_ln_val_costrd)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_costrd,r_ln_val_costrd) & ln_val_costrd!=r_ln_val_costrd
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_costrd-r_ln_val_costrd) if source_year==`y' & !missing(ln_val_costrd,r_ln_val_costrd)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_costrd") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_cottcu!=r_ln_val_cottcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_cottcu) & !missing(r_ln_val_cottcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_cottcu) & missing(r_ln_val_cottcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_cottcu,r_ln_val_cottcu) & ln_val_cottcu!=r_ln_val_cottcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_cottcu-r_ln_val_cottcu) if source_year==`y' & !missing(ln_val_cottcu,r_ln_val_cottcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_cottcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_csdacu!=r_ln_val_csdacu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_csdacu) & !missing(r_ln_val_csdacu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_csdacu) & missing(r_ln_val_csdacu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_csdacu,r_ln_val_csdacu) & ln_val_csdacu!=r_ln_val_csdacu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_csdacu-r_ln_val_csdacu) if source_year==`y' & !missing(ln_val_csdacu,r_ln_val_csdacu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_csdacu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_csfpcu!=r_ln_val_csfpcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_csfpcu) & !missing(r_ln_val_csfpcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_csfpcu) & missing(r_ln_val_csfpcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_csfpcu,r_ln_val_csfpcu) & ln_val_csfpcu!=r_ln_val_csfpcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_csfpcu-r_ln_val_csfpcu) if source_year==`y' & !missing(ln_val_csfpcu,r_ln_val_csfpcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_csfpcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_cssacu!=r_ln_val_cssacu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_cssacu) & !missing(r_ln_val_cssacu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_cssacu) & missing(r_ln_val_cssacu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_cssacu,r_ln_val_cssacu) & ln_val_cssacu!=r_ln_val_cssacu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_cssacu-r_ln_val_cssacu) if source_year==`y' & !missing(ln_val_cssacu,r_ln_val_cssacu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_cssacu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_csttcu!=r_ln_val_csttcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_csttcu) & !missing(r_ln_val_csttcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_csttcu) & missing(r_ln_val_csttcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_csttcu,r_ln_val_csttcu) & ln_val_csttcu!=r_ln_val_csttcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_csttcu-r_ln_val_csttcu) if source_year==`y' & !missing(ln_val_csttcu,r_ln_val_csttcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_csttcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_ctdacu!=r_ln_val_ctdacu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_ctdacu) & !missing(r_ln_val_ctdacu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_ctdacu) & missing(r_ln_val_ctdacu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_ctdacu,r_ln_val_ctdacu) & ln_val_ctdacu!=r_ln_val_ctdacu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_ctdacu-r_ln_val_ctdacu) if source_year==`y' & !missing(ln_val_ctdacu,r_ln_val_ctdacu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_ctdacu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_ctfpcu!=r_ln_val_ctfpcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_ctfpcu) & !missing(r_ln_val_ctfpcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_ctfpcu) & missing(r_ln_val_ctfpcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_ctfpcu,r_ln_val_ctfpcu) & ln_val_ctfpcu!=r_ln_val_ctfpcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_ctfpcu-r_ln_val_ctfpcu) if source_year==`y' & !missing(ln_val_ctfpcu,r_ln_val_ctfpcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_ctfpcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_ctsacu!=r_ln_val_ctsacu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_ctsacu) & !missing(r_ln_val_ctsacu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_ctsacu) & missing(r_ln_val_ctsacu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_ctsacu,r_ln_val_ctsacu) & ln_val_ctsacu!=r_ln_val_ctsacu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_ctsacu-r_ln_val_ctsacu) if source_year==`y' & !missing(ln_val_ctsacu,r_ln_val_ctsacu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_ctsacu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_cttcu!=r_ln_val_cttcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_cttcu) & !missing(r_ln_val_cttcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_cttcu) & missing(r_ln_val_cttcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_cttcu,r_ln_val_cttcu) & ln_val_cttcu!=r_ln_val_cttcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_cttcu-r_ln_val_cttcu) if source_year==`y' & !missing(ln_val_cttcu,r_ln_val_cttcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_cttcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_ctttcu!=r_ln_val_ctttcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_ctttcu) & !missing(r_ln_val_ctttcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_ctttcu) & missing(r_ln_val_ctttcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_ctttcu,r_ln_val_ctttcu) & ln_val_ctttcu!=r_ln_val_ctttcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_ctttcu-r_ln_val_ctttcu) if source_year==`y' & !missing(ln_val_ctttcu,r_ln_val_ctttcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_ctttcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_cvdacu!=r_ln_val_cvdacu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_cvdacu) & !missing(r_ln_val_cvdacu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_cvdacu) & missing(r_ln_val_cvdacu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_cvdacu,r_ln_val_cvdacu) & ln_val_cvdacu!=r_ln_val_cvdacu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_cvdacu-r_ln_val_cvdacu) if source_year==`y' & !missing(ln_val_cvdacu,r_ln_val_cvdacu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_cvdacu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_cvfpcu!=r_ln_val_cvfpcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_cvfpcu) & !missing(r_ln_val_cvfpcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_cvfpcu) & missing(r_ln_val_cvfpcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_cvfpcu,r_ln_val_cvfpcu) & ln_val_cvfpcu!=r_ln_val_cvfpcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_cvfpcu-r_ln_val_cvfpcu) if source_year==`y' & !missing(ln_val_cvfpcu,r_ln_val_cvfpcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_cvfpcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_cvsacu!=r_ln_val_cvsacu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_cvsacu) & !missing(r_ln_val_cvsacu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_cvsacu) & missing(r_ln_val_cvsacu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_cvsacu,r_ln_val_cvsacu) & ln_val_cvsacu!=r_ln_val_cvsacu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_cvsacu-r_ln_val_cvsacu) if source_year==`y' & !missing(ln_val_cvsacu,r_ln_val_cvsacu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_cvsacu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_cvttcu!=r_ln_val_cvttcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_cvttcu) & !missing(r_ln_val_cvttcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_cvttcu) & missing(r_ln_val_cvttcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_cvttcu,r_ln_val_cvttcu) & ln_val_cvttcu!=r_ln_val_cvttcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_cvttcu-r_ln_val_cvttcu) if source_year==`y' & !missing(ln_val_cvttcu,r_ln_val_cvttcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_cvttcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_devvcu!=r_ln_val_devvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_devvcu) & !missing(r_ln_val_devvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_devvcu) & missing(r_ln_val_devvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_devvcu,r_ln_val_devvcu) & ln_val_devvcu!=r_ln_val_devvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_devvcu-r_ln_val_devvcu) if source_year==`y' & !missing(ln_val_devvcu,r_ln_val_devvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_devvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_ecavce!=r_ln_val_ecavce
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_ecavce) & !missing(r_ln_val_ecavce)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_ecavce) & missing(r_ln_val_ecavce)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_ecavce,r_ln_val_ecavce) & ln_val_ecavce!=r_ln_val_ecavce
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_ecavce-r_ln_val_ecavce) if source_year==`y' & !missing(ln_val_ecavce,r_ln_val_ecavce)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_ecavce") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_ecavcu!=r_ln_val_ecavcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_ecavcu) & !missing(r_ln_val_ecavcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_ecavcu) & missing(r_ln_val_ecavcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_ecavcu,r_ln_val_ecavcu) & ln_val_ecavcu!=r_ln_val_ecavcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_ecavcu-r_ln_val_ecavcu) if source_year==`y' & !missing(ln_val_ecavcu,r_ln_val_ecavcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_ecavcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_ecbvce!=r_ln_val_ecbvce
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_ecbvce) & !missing(r_ln_val_ecbvce)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_ecbvce) & missing(r_ln_val_ecbvce)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_ecbvce,r_ln_val_ecbvce) & ln_val_ecbvce!=r_ln_val_ecbvce
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_ecbvce-r_ln_val_ecbvce) if source_year==`y' & !missing(ln_val_ecbvce,r_ln_val_ecbvce)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_ecbvce") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_ecbvcu!=r_ln_val_ecbvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_ecbvcu) & !missing(r_ln_val_ecbvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_ecbvcu) & missing(r_ln_val_ecbvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_ecbvcu,r_ln_val_ecbvcu) & ln_val_ecbvcu!=r_ln_val_ecbvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_ecbvcu-r_ln_val_ecbvcu) if source_year==`y' & !missing(ln_val_ecbvcu,r_ln_val_ecbvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_ecbvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_eckvce!=r_ln_val_eckvce
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_eckvce) & !missing(r_ln_val_eckvce)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_eckvce) & missing(r_ln_val_eckvce)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_eckvce,r_ln_val_eckvce) & ln_val_eckvce!=r_ln_val_eckvce
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_eckvce-r_ln_val_eckvce) if source_year==`y' & !missing(ln_val_eckvce,r_ln_val_eckvce)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_eckvce") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_eckvcu!=r_ln_val_eckvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_eckvcu) & !missing(r_ln_val_eckvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_eckvcu) & missing(r_ln_val_eckvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_eckvcu,r_ln_val_eckvcu) & ln_val_eckvcu!=r_ln_val_eckvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_eckvcu-r_ln_val_eckvcu) if source_year==`y' & !missing(ln_val_eckvcu,r_ln_val_eckvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_eckvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_eclvce!=r_ln_val_eclvce
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_eclvce) & !missing(r_ln_val_eclvce)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_eclvce) & missing(r_ln_val_eclvce)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_eclvce,r_ln_val_eclvce) & ln_val_eclvce!=r_ln_val_eclvce
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_eclvce-r_ln_val_eclvce) if source_year==`y' & !missing(ln_val_eclvce,r_ln_val_eclvce)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_eclvce") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_eclvcu!=r_ln_val_eclvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_eclvcu) & !missing(r_ln_val_eclvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_eclvcu) & missing(r_ln_val_eclvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_eclvcu,r_ln_val_eclvcu) & ln_val_eclvcu!=r_ln_val_eclvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_eclvcu-r_ln_val_eclvcu) if source_year==`y' & !missing(ln_val_eclvcu,r_ln_val_eclvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_eclvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_edivce!=r_ln_val_edivce
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_edivce) & !missing(r_ln_val_edivce)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_edivce) & missing(r_ln_val_edivce)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_edivce,r_ln_val_edivce) & ln_val_edivce!=r_ln_val_edivce
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_edivce-r_ln_val_edivce) if source_year==`y' & !missing(ln_val_edivce,r_ln_val_edivce)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_edivce") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_edivcu!=r_ln_val_edivcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_edivcu) & !missing(r_ln_val_edivcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_edivcu) & missing(r_ln_val_edivcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_edivcu,r_ln_val_edivcu) & ln_val_edivcu!=r_ln_val_edivcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_edivcu-r_ln_val_edivcu) if source_year==`y' & !missing(ln_val_edivcu,r_ln_val_edivcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_edivcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_efovce!=r_ln_val_efovce
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_efovce) & !missing(r_ln_val_efovce)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_efovce) & missing(r_ln_val_efovce)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_efovce,r_ln_val_efovce) & ln_val_efovce!=r_ln_val_efovce
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_efovce-r_ln_val_efovce) if source_year==`y' & !missing(ln_val_efovce,r_ln_val_efovce)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_efovce") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_efovcu!=r_ln_val_efovcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_efovcu) & !missing(r_ln_val_efovcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_efovcu) & missing(r_ln_val_efovcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_efovcu,r_ln_val_efovcu) & ln_val_efovcu!=r_ln_val_efovcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_efovcu-r_ln_val_efovcu) if source_year==`y' & !missing(ln_val_efovcu,r_ln_val_efovcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_efovcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_efuvce!=r_ln_val_efuvce
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_efuvce) & !missing(r_ln_val_efuvce)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_efuvce) & missing(r_ln_val_efuvce)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_efuvce,r_ln_val_efuvce) & ln_val_efuvce!=r_ln_val_efuvce
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_efuvce-r_ln_val_efuvce) if source_year==`y' & !missing(ln_val_efuvce,r_ln_val_efuvce)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_efuvce") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_efuvcu!=r_ln_val_efuvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_efuvcu) & !missing(r_ln_val_efuvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_efuvcu) & missing(r_ln_val_efuvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_efuvcu,r_ln_val_efuvcu) & ln_val_efuvcu!=r_ln_val_efuvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_efuvcu-r_ln_val_efuvcu) if source_year==`y' & !missing(ln_val_efuvcu,r_ln_val_efuvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_efuvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_egavce!=r_ln_val_egavce
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_egavce) & !missing(r_ln_val_egavce)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_egavce) & missing(r_ln_val_egavce)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_egavce,r_ln_val_egavce) & ln_val_egavce!=r_ln_val_egavce
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_egavce-r_ln_val_egavce) if source_year==`y' & !missing(ln_val_egavce,r_ln_val_egavce)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_egavce") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_egavcu!=r_ln_val_egavcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_egavcu) & !missing(r_ln_val_egavcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_egavcu) & missing(r_ln_val_egavcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_egavcu,r_ln_val_egavcu) & ln_val_egavcu!=r_ln_val_egavcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_egavcu-r_ln_val_egavcu) if source_year==`y' & !missing(ln_val_egavcu,r_ln_val_egavcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_egavcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_egovce!=r_ln_val_egovce
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_egovce) & !missing(r_ln_val_egovce)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_egovce) & missing(r_ln_val_egovce)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_egovce,r_ln_val_egovce) & ln_val_egovce!=r_ln_val_egovce
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_egovce-r_ln_val_egovce) if source_year==`y' & !missing(ln_val_egovce,r_ln_val_egovce)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_egovce") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_egovcu!=r_ln_val_egovcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_egovcu) & !missing(r_ln_val_egovcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_egovcu) & missing(r_ln_val_egovcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_egovcu,r_ln_val_egovcu) & ln_val_egovcu!=r_ln_val_egovcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_egovcu-r_ln_val_egovcu) if source_year==`y' & !missing(ln_val_egovcu,r_ln_val_egovcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_egovcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_elpvce!=r_ln_val_elpvce
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_elpvce) & !missing(r_ln_val_elpvce)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_elpvce) & missing(r_ln_val_elpvce)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_elpvce,r_ln_val_elpvce) & ln_val_elpvce!=r_ln_val_elpvce
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_elpvce-r_ln_val_elpvce) if source_year==`y' & !missing(ln_val_elpvce,r_ln_val_elpvce)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_elpvce") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_elpvcu!=r_ln_val_elpvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_elpvcu) & !missing(r_ln_val_elpvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_elpvcu) & missing(r_ln_val_elpvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_elpvcu,r_ln_val_elpvcu) & ln_val_elpvcu!=r_ln_val_elpvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_elpvcu-r_ln_val_elpvcu) if source_year==`y' & !missing(ln_val_elpvcu,r_ln_val_elpvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_elpvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_eluvce!=r_ln_val_eluvce
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_eluvce) & !missing(r_ln_val_eluvce)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_eluvce) & missing(r_ln_val_eluvce)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_eluvce,r_ln_val_eluvce) & ln_val_eluvce!=r_ln_val_eluvce
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_eluvce-r_ln_val_eluvce) if source_year==`y' & !missing(ln_val_eluvce,r_ln_val_eluvce)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_eluvce") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_eluvcu!=r_ln_val_eluvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_eluvcu) & !missing(r_ln_val_eluvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_eluvcu) & missing(r_ln_val_eluvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_eluvcu,r_ln_val_eluvcu) & ln_val_eluvcu!=r_ln_val_eluvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_eluvcu-r_ln_val_eluvcu) if source_year==`y' & !missing(ln_val_eluvcu,r_ln_val_eluvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_eluvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_encvce!=r_ln_val_encvce
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_encvce) & !missing(r_ln_val_encvce)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_encvce) & missing(r_ln_val_encvce)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_encvce,r_ln_val_encvce) & ln_val_encvce!=r_ln_val_encvce
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_encvce-r_ln_val_encvce) if source_year==`y' & !missing(ln_val_encvce,r_ln_val_encvce)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_encvce") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_encvcu!=r_ln_val_encvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_encvcu) & !missing(r_ln_val_encvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_encvcu) & missing(r_ln_val_encvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_encvcu,r_ln_val_encvcu) & ln_val_encvcu!=r_ln_val_encvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_encvcu-r_ln_val_encvcu) if source_year==`y' & !missing(ln_val_encvcu,r_ln_val_encvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_encvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_engvce!=r_ln_val_engvce
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_engvce) & !missing(r_ln_val_engvce)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_engvce) & missing(r_ln_val_engvce)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_engvce,r_ln_val_engvce) & ln_val_engvce!=r_ln_val_engvce
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_engvce-r_ln_val_engvce) if source_year==`y' & !missing(ln_val_engvce,r_ln_val_engvce)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_engvce") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_engvcu!=r_ln_val_engvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_engvcu) & !missing(r_ln_val_engvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_engvcu) & missing(r_ln_val_engvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_engvcu,r_ln_val_engvcu) & ln_val_engvcu!=r_ln_val_engvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_engvcu-r_ln_val_engvcu) if source_year==`y' & !missing(ln_val_engvcu,r_ln_val_engvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_engvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_enpvcu!=r_ln_val_enpvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_enpvcu) & !missing(r_ln_val_enpvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_enpvcu) & missing(r_ln_val_enpvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_enpvcu,r_ln_val_enpvcu) & ln_val_enpvcu!=r_ln_val_enpvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_enpvcu-r_ln_val_enpvcu) if source_year==`y' & !missing(ln_val_enpvcu,r_ln_val_enpvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_enpvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_eoivce!=r_ln_val_eoivce
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_eoivce) & !missing(r_ln_val_eoivce)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_eoivce) & missing(r_ln_val_eoivce)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_eoivce,r_ln_val_eoivce) & ln_val_eoivce!=r_ln_val_eoivce
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_eoivce-r_ln_val_eoivce) if source_year==`y' & !missing(ln_val_eoivce,r_ln_val_eoivce)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_eoivce") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_eoivcu!=r_ln_val_eoivcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_eoivcu) & !missing(r_ln_val_eoivcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_eoivcu) & missing(r_ln_val_eoivcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_eoivcu,r_ln_val_eoivcu) & ln_val_eoivcu!=r_ln_val_eoivcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_eoivcu-r_ln_val_eoivcu) if source_year==`y' & !missing(ln_val_eoivcu,r_ln_val_eoivcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_eoivcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_epevce!=r_ln_val_epevce
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_epevce) & !missing(r_ln_val_epevce)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_epevce) & missing(r_ln_val_epevce)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_epevce,r_ln_val_epevce) & ln_val_epevce!=r_ln_val_epevce
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_epevce-r_ln_val_epevce) if source_year==`y' & !missing(ln_val_epevce,r_ln_val_epevce)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_epevce") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_epevcu!=r_ln_val_epevcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_epevcu) & !missing(r_ln_val_epevcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_epevcu) & missing(r_ln_val_epevcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_epevcu,r_ln_val_epevcu) & ln_val_epevcu!=r_ln_val_epevcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_epevcu-r_ln_val_epevcu) if source_year==`y' & !missing(ln_val_epevcu,r_ln_val_epevcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_epevcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_eplvcu!=r_ln_val_eplvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_eplvcu) & !missing(r_ln_val_eplvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_eplvcu) & missing(r_ln_val_eplvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_eplvcu,r_ln_val_eplvcu) & ln_val_eplvcu!=r_ln_val_eplvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_eplvcu-r_ln_val_eplvcu) if source_year==`y' & !missing(ln_val_eplvcu,r_ln_val_eplvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_eplvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_esdvce!=r_ln_val_esdvce
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_esdvce) & !missing(r_ln_val_esdvce)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_esdvce) & missing(r_ln_val_esdvce)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_esdvce,r_ln_val_esdvce) & ln_val_esdvce!=r_ln_val_esdvce
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_esdvce-r_ln_val_esdvce) if source_year==`y' & !missing(ln_val_esdvce,r_ln_val_esdvce)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_esdvce") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_esdvcu!=r_ln_val_esdvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_esdvcu) & !missing(r_ln_val_esdvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_esdvcu) & missing(r_ln_val_esdvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_esdvcu,r_ln_val_esdvcu) & ln_val_esdvcu!=r_ln_val_esdvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_esdvcu-r_ln_val_esdvcu) if source_year==`y' & !missing(ln_val_esdvcu,r_ln_val_esdvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_esdvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_esovce!=r_ln_val_esovce
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_esovce) & !missing(r_ln_val_esovce)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_esovce) & missing(r_ln_val_esovce)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_esovce,r_ln_val_esovce) & ln_val_esovce!=r_ln_val_esovce
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_esovce-r_ln_val_esovce) if source_year==`y' & !missing(ln_val_esovce,r_ln_val_esovce)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_esovce") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_esovcu!=r_ln_val_esovcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_esovcu) & !missing(r_ln_val_esovcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_esovcu) & missing(r_ln_val_esovcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_esovcu,r_ln_val_esovcu) & ln_val_esovcu!=r_ln_val_esovcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_esovcu-r_ln_val_esovcu) if source_year==`y' & !missing(ln_val_esovcu,r_ln_val_esovcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_esovcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_ibrvcu!=r_ln_val_ibrvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_ibrvcu) & !missing(r_ln_val_ibrvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_ibrvcu) & missing(r_ln_val_ibrvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_ibrvcu,r_ln_val_ibrvcu) & ln_val_ibrvcu!=r_ln_val_ibrvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_ibrvcu-r_ln_val_ibrvcu) if source_year==`y' & !missing(ln_val_ibrvcu,r_ln_val_ibrvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_ibrvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_icovcu!=r_ln_val_icovcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_icovcu) & !missing(r_ln_val_icovcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_icovcu) & missing(r_ln_val_icovcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_icovcu,r_ln_val_icovcu) & ln_val_icovcu!=r_ln_val_icovcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_icovcu-r_ln_val_icovcu) if source_year==`y' & !missing(ln_val_icovcu,r_ln_val_icovcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_icovcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_idevcu!=r_ln_val_idevcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_idevcu) & !missing(r_ln_val_idevcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_idevcu) & missing(r_ln_val_idevcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_idevcu,r_ln_val_idevcu) & ln_val_idevcu!=r_ln_val_idevcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_idevcu-r_ln_val_idevcu) if source_year==`y' & !missing(ln_val_idevcu,r_ln_val_idevcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_idevcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_iinput!=r_ln_val_iinput
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_iinput) & !missing(r_ln_val_iinput)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_iinput) & missing(r_ln_val_iinput)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_iinput,r_ln_val_iinput) & ln_val_iinput!=r_ln_val_iinput
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_iinput-r_ln_val_iinput) if source_year==`y' & !missing(ln_val_iinput,r_ln_val_iinput)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_iinput") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_iinvcu!=r_ln_val_iinvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_iinvcu) & !missing(r_ln_val_iinvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_iinvcu) & missing(r_ln_val_iinvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_iinvcu,r_ln_val_iinvcu) & ln_val_iinvcu!=r_ln_val_iinvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_iinvcu-r_ln_val_iinvcu) if source_year==`y' & !missing(ln_val_iinvcu,r_ln_val_iinvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_iinvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_iisfov!=r_ln_val_iisfov
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_iisfov) & !missing(r_ln_val_iisfov)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_iisfov) & missing(r_ln_val_iisfov)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_iisfov,r_ln_val_iisfov) & ln_val_iisfov!=r_ln_val_iisfov
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_iisfov-r_ln_val_iisfov) if source_year==`y' & !missing(ln_val_iisfov,r_ln_val_iisfov)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_iisfov") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_iislov!=r_ln_val_iislov
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_iislov) & !missing(r_ln_val_iislov)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_iislov) & missing(r_ln_val_iislov)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_iislov,r_ln_val_iislov) & ln_val_iislov!=r_ln_val_iislov
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_iislov-r_ln_val_iislov) if source_year==`y' & !missing(ln_val_iislov,r_ln_val_iislov)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_iislov") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_iisvcu!=r_ln_val_iisvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_iisvcu) & !missing(r_ln_val_iisvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_iisvcu) & missing(r_ln_val_iisvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_iisvcu,r_ln_val_iisvcu) & ln_val_iisvcu!=r_ln_val_iisvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_iisvcu-r_ln_val_iisvcu) if source_year==`y' & !missing(ln_val_iisvcu,r_ln_val_iisvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_iisvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_ikivcu!=r_ln_val_ikivcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_ikivcu) & !missing(r_ln_val_ikivcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_ikivcu) & missing(r_ln_val_ikivcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_ikivcu,r_ln_val_ikivcu) & ln_val_ikivcu!=r_ln_val_ikivcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_ikivcu-r_ln_val_ikivcu) if source_year==`y' & !missing(ln_val_ikivcu,r_ln_val_ikivcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_ikivcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_iklvcu!=r_ln_val_iklvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_iklvcu) & !missing(r_ln_val_iklvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_iklvcu) & missing(r_ln_val_iklvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_iklvcu,r_ln_val_iklvcu) & ln_val_iklvcu!=r_ln_val_iklvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_iklvcu-r_ln_val_iklvcu) if source_year==`y' & !missing(ln_val_iklvcu,r_ln_val_iklvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_iklvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_ikovcu!=r_ln_val_ikovcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_ikovcu) & !missing(r_ln_val_ikovcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_ikovcu) & missing(r_ln_val_ikovcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_ikovcu,r_ln_val_ikovcu) & ln_val_ikovcu!=r_ln_val_ikovcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_ikovcu-r_ln_val_ikovcu) if source_year==`y' & !missing(ln_val_ikovcu,r_ln_val_ikovcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_ikovcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_ilrvcu!=r_ln_val_ilrvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_ilrvcu) & !missing(r_ln_val_ilrvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_ilrvcu) & missing(r_ln_val_ilrvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_ilrvcu,r_ln_val_ilrvcu) & ln_val_ilrvcu!=r_ln_val_ilrvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_ilrvcu-r_ln_val_ilrvcu) if source_year==`y' & !missing(ln_val_ilrvcu,r_ln_val_ilrvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_ilrvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_insvcu!=r_ln_val_insvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_insvcu) & !missing(r_ln_val_insvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_insvcu) & missing(r_ln_val_insvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_insvcu,r_ln_val_insvcu) & ln_val_insvcu!=r_ln_val_insvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_insvcu-r_ln_val_insvcu) if source_year==`y' & !missing(ln_val_insvcu,r_ln_val_insvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_insvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_intvcu!=r_ln_val_intvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_intvcu) & !missing(r_ln_val_intvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_intvcu) & missing(r_ln_val_intvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_intvcu,r_ln_val_intvcu) & ln_val_intvcu!=r_ln_val_intvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_intvcu-r_ln_val_intvcu) if source_year==`y' & !missing(ln_val_intvcu,r_ln_val_intvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_intvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_iotvcu!=r_ln_val_iotvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_iotvcu) & !missing(r_ln_val_iotvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_iotvcu) & missing(r_ln_val_iotvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_iotvcu,r_ln_val_iotvcu) & ln_val_iotvcu!=r_ln_val_iotvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_iotvcu-r_ln_val_iotvcu) if source_year==`y' & !missing(ln_val_iotvcu,r_ln_val_iotvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_iotvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_ipkvcu!=r_ln_val_ipkvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_ipkvcu) & !missing(r_ln_val_ipkvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_ipkvcu) & missing(r_ln_val_ipkvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_ipkvcu,r_ln_val_ipkvcu) & ln_val_ipkvcu!=r_ln_val_ipkvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_ipkvcu-r_ln_val_ipkvcu) if source_year==`y' & !missing(ln_val_ipkvcu,r_ln_val_ipkvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_ipkvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_iprvcu!=r_ln_val_iprvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_iprvcu) & !missing(r_ln_val_iprvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_iprvcu) & missing(r_ln_val_iprvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_iprvcu,r_ln_val_iprvcu) & ln_val_iprvcu!=r_ln_val_iprvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_iprvcu-r_ln_val_iprvcu) if source_year==`y' & !missing(ln_val_iprvcu,r_ln_val_iprvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_iprvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_irdvcu!=r_ln_val_irdvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_irdvcu) & !missing(r_ln_val_irdvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_irdvcu) & missing(r_ln_val_irdvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_irdvcu,r_ln_val_irdvcu) & ln_val_irdvcu!=r_ln_val_irdvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_irdvcu-r_ln_val_irdvcu) if source_year==`y' & !missing(ln_val_irdvcu,r_ln_val_irdvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_irdvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_irevcu!=r_ln_val_irevcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_irevcu) & !missing(r_ln_val_irevcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_irevcu) & missing(r_ln_val_irevcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_irevcu,r_ln_val_irevcu) & ln_val_irevcu!=r_ln_val_irevcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_irevcu-r_ln_val_irevcu) if source_year==`y' & !missing(ln_val_irevcu,r_ln_val_irevcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_irevcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_irrvcu!=r_ln_val_irrvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_irrvcu) & !missing(r_ln_val_irrvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_irrvcu) & missing(r_ln_val_irrvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_irrvcu,r_ln_val_irrvcu) & ln_val_irrvcu!=r_ln_val_irrvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_irrvcu-r_ln_val_irrvcu) if source_year==`y' & !missing(ln_val_irrvcu,r_ln_val_irrvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_irrvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_itxvcu!=r_ln_val_itxvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_itxvcu) & !missing(r_ln_val_itxvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_itxvcu) & missing(r_ln_val_itxvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_itxvcu,r_ln_val_itxvcu) & ln_val_itxvcu!=r_ln_val_itxvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_itxvcu-r_ln_val_itxvcu) if source_year==`y' & !missing(ln_val_itxvcu,r_ln_val_itxvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_itxvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_iuwvcu!=r_ln_val_iuwvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_iuwvcu) & !missing(r_ln_val_iuwvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_iuwvcu) & missing(r_ln_val_iuwvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_iuwvcu,r_ln_val_iuwvcu) & ln_val_iuwvcu!=r_ln_val_iuwvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_iuwvcu-r_ln_val_iuwvcu) if source_year==`y' & !missing(ln_val_iuwvcu,r_ln_val_iuwvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_iuwvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_nopvcu!=r_ln_val_nopvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_nopvcu) & !missing(r_ln_val_nopvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_nopvcu) & missing(r_ln_val_nopvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_nopvcu,r_ln_val_nopvcu) & ln_val_nopvcu!=r_ln_val_nopvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_nopvcu-r_ln_val_nopvcu) if source_year==`y' & !missing(ln_val_nopvcu,r_ln_val_nopvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_nopvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_othvcu!=r_ln_val_othvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_othvcu) & !missing(r_ln_val_othvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_othvcu) & missing(r_ln_val_othvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_othvcu,r_ln_val_othvcu) & ln_val_othvcu!=r_ln_val_othvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_othvcu-r_ln_val_othvcu) if source_year==`y' & !missing(ln_val_othvcu,r_ln_val_othvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_othvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_output!=r_ln_val_output
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_output) & !missing(r_ln_val_output)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_output) & missing(r_ln_val_output)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_output,r_ln_val_output) & ln_val_output!=r_ln_val_output
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_output-r_ln_val_output) if source_year==`y' & !missing(ln_val_output,r_ln_val_output)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_output") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_rdnvcu!=r_ln_val_rdnvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_rdnvcu) & !missing(r_ln_val_rdnvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_rdnvcu) & missing(r_ln_val_rdnvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_rdnvcu,r_ln_val_rdnvcu) & ln_val_rdnvcu!=r_ln_val_rdnvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_rdnvcu-r_ln_val_rdnvcu) if source_year==`y' & !missing(ln_val_rdnvcu,r_ln_val_rdnvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_rdnvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_renvcu!=r_ln_val_renvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_renvcu) & !missing(r_ln_val_renvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_renvcu) & missing(r_ln_val_renvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_renvcu,r_ln_val_renvcu) & ln_val_renvcu!=r_ln_val_renvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_renvcu-r_ln_val_renvcu) if source_year==`y' & !missing(ln_val_renvcu,r_ln_val_renvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_renvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_rimvcu!=r_ln_val_rimvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_rimvcu) & !missing(r_ln_val_rimvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_rimvcu) & missing(r_ln_val_rimvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_rimvcu,r_ln_val_rimvcu) & ln_val_rimvcu!=r_ln_val_rimvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_rimvcu-r_ln_val_rimvcu) if source_year==`y' & !missing(ln_val_rimvcu,r_ln_val_rimvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_rimvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_rtlvcu!=r_ln_val_rtlvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_rtlvcu) & !missing(r_ln_val_rtlvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_rtlvcu) & missing(r_ln_val_rtlvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_rtlvcu,r_ln_val_rtlvcu) & ln_val_rtlvcu!=r_ln_val_rtlvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_rtlvcu-r_ln_val_rtlvcu) if source_year==`y' & !missing(ln_val_rtlvcu,r_ln_val_rtlvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_rtlvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_sfbvcu!=r_ln_val_sfbvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_sfbvcu) & !missing(r_ln_val_sfbvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_sfbvcu) & missing(r_ln_val_sfbvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_sfbvcu,r_ln_val_sfbvcu) & ln_val_sfbvcu!=r_ln_val_sfbvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_sfbvcu-r_ln_val_sfbvcu) if source_year==`y' & !missing(ln_val_sfbvcu,r_ln_val_sfbvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_sfbvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_sfcvcu!=r_ln_val_sfcvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_sfcvcu) & !missing(r_ln_val_sfcvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_sfcvcu) & missing(r_ln_val_sfcvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_sfcvcu,r_ln_val_sfcvcu) & ln_val_sfcvcu!=r_ln_val_sfcvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_sfcvcu-r_ln_val_sfcvcu) if source_year==`y' & !missing(ln_val_sfcvcu,r_ln_val_sfcvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_sfcvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_sfdvcu!=r_ln_val_sfdvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_sfdvcu) & !missing(r_ln_val_sfdvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_sfdvcu) & missing(r_ln_val_sfdvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_sfdvcu,r_ln_val_sfdvcu) & ln_val_sfdvcu!=r_ln_val_sfdvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_sfdvcu-r_ln_val_sfdvcu) if source_year==`y' & !missing(ln_val_sfdvcu,r_ln_val_sfdvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_sfdvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_sfgvcu!=r_ln_val_sfgvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_sfgvcu) & !missing(r_ln_val_sfgvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_sfgvcu) & missing(r_ln_val_sfgvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_sfgvcu,r_ln_val_sfgvcu) & ln_val_sfgvcu!=r_ln_val_sfgvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_sfgvcu-r_ln_val_sfgvcu) if source_year==`y' & !missing(ln_val_sfgvcu,r_ln_val_sfgvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_sfgvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_sfjvcu!=r_ln_val_sfjvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_sfjvcu) & !missing(r_ln_val_sfjvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_sfjvcu) & missing(r_ln_val_sfjvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_sfjvcu,r_ln_val_sfjvcu) & ln_val_sfjvcu!=r_ln_val_sfjvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_sfjvcu-r_ln_val_sfjvcu) if source_year==`y' & !missing(ln_val_sfjvcu,r_ln_val_sfjvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_sfjvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_sfkvcu!=r_ln_val_sfkvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_sfkvcu) & !missing(r_ln_val_sfkvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_sfkvcu) & missing(r_ln_val_sfkvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_sfkvcu,r_ln_val_sfkvcu) & ln_val_sfkvcu!=r_ln_val_sfkvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_sfkvcu-r_ln_val_sfkvcu) if source_year==`y' & !missing(ln_val_sfkvcu,r_ln_val_sfkvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_sfkvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_sfnvcu!=r_ln_val_sfnvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_sfnvcu) & !missing(r_ln_val_sfnvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_sfnvcu) & missing(r_ln_val_sfnvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_sfnvcu,r_ln_val_sfnvcu) & ln_val_sfnvcu!=r_ln_val_sfnvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_sfnvcu-r_ln_val_sfnvcu) if source_year==`y' & !missing(ln_val_sfnvcu,r_ln_val_sfnvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_sfnvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_sfovcu!=r_ln_val_sfovcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_sfovcu) & !missing(r_ln_val_sfovcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_sfovcu) & missing(r_ln_val_sfovcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_sfovcu,r_ln_val_sfovcu) & ln_val_sfovcu!=r_ln_val_sfovcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_sfovcu-r_ln_val_sfovcu) if source_year==`y' & !missing(ln_val_sfovcu,r_ln_val_sfovcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_sfovcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_sfrvcu!=r_ln_val_sfrvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_sfrvcu) & !missing(r_ln_val_sfrvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_sfrvcu) & missing(r_ln_val_sfrvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_sfrvcu,r_ln_val_sfrvcu) & ln_val_sfrvcu!=r_ln_val_sfrvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_sfrvcu-r_ln_val_sfrvcu) if source_year==`y' & !missing(ln_val_sfrvcu,r_ln_val_sfrvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_sfrvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_sfsvcu!=r_ln_val_sfsvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_sfsvcu) & !missing(r_ln_val_sfsvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_sfsvcu) & missing(r_ln_val_sfsvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_sfsvcu,r_ln_val_sfsvcu) & ln_val_sfsvcu!=r_ln_val_sfsvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_sfsvcu-r_ln_val_sfsvcu) if source_year==`y' & !missing(ln_val_sfsvcu,r_ln_val_sfsvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_sfsvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_sfuvcu!=r_ln_val_sfuvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_sfuvcu) & !missing(r_ln_val_sfuvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_sfuvcu) & missing(r_ln_val_sfuvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_sfuvcu,r_ln_val_sfuvcu) & ln_val_sfuvcu!=r_ln_val_sfuvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_sfuvcu-r_ln_val_sfuvcu) if source_year==`y' & !missing(ln_val_sfuvcu,r_ln_val_sfuvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_sfuvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_shdvcu!=r_ln_val_shdvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_shdvcu) & !missing(r_ln_val_shdvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_shdvcu) & missing(r_ln_val_shdvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_shdvcu,r_ln_val_shdvcu) & ln_val_shdvcu!=r_ln_val_shdvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_shdvcu-r_ln_val_shdvcu) if source_year==`y' & !missing(ln_val_shdvcu,r_ln_val_shdvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_shdvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_shfvcu!=r_ln_val_shfvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_shfvcu) & !missing(r_ln_val_shfvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_shfvcu) & missing(r_ln_val_shfvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_shfvcu,r_ln_val_shfvcu) & ln_val_shfvcu!=r_ln_val_shfvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_shfvcu-r_ln_val_shfvcu) if source_year==`y' & !missing(ln_val_shfvcu,r_ln_val_shfvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_shfvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_shjvcu!=r_ln_val_shjvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_shjvcu) & !missing(r_ln_val_shjvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_shjvcu) & missing(r_ln_val_shjvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_shjvcu,r_ln_val_shjvcu) & ln_val_shjvcu!=r_ln_val_shjvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_shjvcu-r_ln_val_shjvcu) if source_year==`y' & !missing(ln_val_shjvcu,r_ln_val_shjvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_shjvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_srdvcu!=r_ln_val_srdvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_srdvcu) & !missing(r_ln_val_srdvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_srdvcu) & missing(r_ln_val_srdvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_srdvcu,r_ln_val_srdvcu) & ln_val_srdvcu!=r_ln_val_srdvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_srdvcu-r_ln_val_srdvcu) if source_year==`y' & !missing(ln_val_srdvcu,r_ln_val_srdvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_srdvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_srjvcu!=r_ln_val_srjvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_srjvcu) & !missing(r_ln_val_srjvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_srjvcu) & missing(r_ln_val_srjvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_srjvcu,r_ln_val_srjvcu) & ln_val_srjvcu!=r_ln_val_srjvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_srjvcu-r_ln_val_srjvcu) if source_year==`y' & !missing(ln_val_srjvcu,r_ln_val_srjvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_srjvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_srmvcu!=r_ln_val_srmvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_srmvcu) & !missing(r_ln_val_srmvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_srmvcu) & missing(r_ln_val_srmvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_srmvcu,r_ln_val_srmvcu) & ln_val_srmvcu!=r_ln_val_srmvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_srmvcu-r_ln_val_srmvcu) if source_year==`y' & !missing(ln_val_srmvcu,r_ln_val_srmvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_srmvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_stdvcu!=r_ln_val_stdvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_stdvcu) & !missing(r_ln_val_stdvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_stdvcu) & missing(r_ln_val_stdvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_stdvcu,r_ln_val_stdvcu) & ln_val_stdvcu!=r_ln_val_stdvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_stdvcu-r_ln_val_stdvcu) if source_year==`y' & !missing(ln_val_stdvcu,r_ln_val_stdvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_stdvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_stjvcu!=r_ln_val_stjvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_stjvcu) & !missing(r_ln_val_stjvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_stjvcu) & missing(r_ln_val_stjvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_stjvcu,r_ln_val_stjvcu) & ln_val_stjvcu!=r_ln_val_stjvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_stjvcu-r_ln_val_stjvcu) if source_year==`y' & !missing(ln_val_stjvcu,r_ln_val_stjvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_stjvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_stlvcu!=r_ln_val_stlvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_stlvcu) & !missing(r_ln_val_stlvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_stlvcu) & missing(r_ln_val_stlvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_stlvcu,r_ln_val_stlvcu) & ln_val_stlvcu!=r_ln_val_stlvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_stlvcu-r_ln_val_stlvcu) if source_year==`y' & !missing(ln_val_stlvcu,r_ln_val_stlvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_stlvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_vtlvcu!=r_ln_val_vtlvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_vtlvcu) & !missing(r_ln_val_vtlvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_vtlvcu) & missing(r_ln_val_vtlvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_vtlvcu,r_ln_val_vtlvcu) & ln_val_vtlvcu!=r_ln_val_vtlvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_vtlvcu-r_ln_val_vtlvcu) if source_year==`y' & !missing(ln_val_vtlvcu,r_ln_val_vtlvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_vtlvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_yelvcu!=r_ln_val_yelvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_yelvcu) & !missing(r_ln_val_yelvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_yelvcu) & missing(r_ln_val_yelvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_yelvcu,r_ln_val_yelvcu) & ln_val_yelvcu!=r_ln_val_yelvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_yelvcu-r_ln_val_yelvcu) if source_year==`y' & !missing(ln_val_yelvcu,r_ln_val_yelvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_yelvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_yisvcu!=r_ln_val_yisvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_yisvcu) & !missing(r_ln_val_yisvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_yisvcu) & missing(r_ln_val_yisvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_yisvcu,r_ln_val_yisvcu) & ln_val_yisvcu!=r_ln_val_yisvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_yisvcu-r_ln_val_yisvcu) if source_year==`y' & !missing(ln_val_yisvcu,r_ln_val_yisvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_yisvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_yisvdo!=r_ln_val_yisvdo
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_yisvdo) & !missing(r_ln_val_yisvdo)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_yisvdo) & missing(r_ln_val_yisvdo)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_yisvdo,r_ln_val_yisvdo) & ln_val_yisvdo!=r_ln_val_yisvdo
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_yisvdo-r_ln_val_yisvdo) if source_year==`y' & !missing(ln_val_yisvdo,r_ln_val_yisvdo)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_yisvdo") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_yisvfo!=r_ln_val_yisvfo
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_yisvfo) & !missing(r_ln_val_yisvfo)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_yisvfo) & missing(r_ln_val_yisvfo)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_yisvfo,r_ln_val_yisvfo) & ln_val_yisvfo!=r_ln_val_yisvfo
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_yisvfo-r_ln_val_yisvfo) if source_year==`y' & !missing(ln_val_yisvfo,r_ln_val_yisvfo)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_yisvfo") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_ykdvcu!=r_ln_val_ykdvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_ykdvcu) & !missing(r_ln_val_ykdvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_ykdvcu) & missing(r_ln_val_ykdvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_ykdvcu,r_ln_val_ykdvcu) & ln_val_ykdvcu!=r_ln_val_ykdvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_ykdvcu-r_ln_val_ykdvcu) if source_year==`y' & !missing(ln_val_ykdvcu,r_ln_val_ykdvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_ykdvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_ykfvcu!=r_ln_val_ykfvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_ykfvcu) & !missing(r_ln_val_ykfvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_ykfvcu) & missing(r_ln_val_ykfvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_ykfvcu,r_ln_val_ykfvcu) & ln_val_ykfvcu!=r_ln_val_ykfvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_ykfvcu-r_ln_val_ykfvcu) if source_year==`y' & !missing(ln_val_ykfvcu,r_ln_val_ykfvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_ykfvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_ykivcu!=r_ln_val_ykivcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_ykivcu) & !missing(r_ln_val_ykivcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_ykivcu) & missing(r_ln_val_ykivcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_ykivcu,r_ln_val_ykivcu) & ln_val_ykivcu!=r_ln_val_ykivcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_ykivcu-r_ln_val_ykivcu) if source_year==`y' & !missing(ln_val_ykivcu,r_ln_val_ykivcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_ykivcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_yprvcu!=r_ln_val_yprvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_yprvcu) & !missing(r_ln_val_yprvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_yprvcu) & missing(r_ln_val_yprvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_yprvcu,r_ln_val_yprvcu) & ln_val_yprvcu!=r_ln_val_yprvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_yprvcu-r_ln_val_yprvcu) if source_year==`y' & !missing(ln_val_yprvcu,r_ln_val_yprvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_yprvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_yrnvcu!=r_ln_val_yrnvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_yrnvcu) & !missing(r_ln_val_yrnvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_yrnvcu) & missing(r_ln_val_yrnvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_yrnvcu,r_ln_val_yrnvcu) & ln_val_yrnvcu!=r_ln_val_yrnvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_yrnvcu-r_ln_val_yrnvcu) if source_year==`y' & !missing(ln_val_yrnvcu,r_ln_val_yrnvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_yrnvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_yrsvcu!=r_ln_val_yrsvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_yrsvcu) & !missing(r_ln_val_yrsvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_yrsvcu) & missing(r_ln_val_yrsvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_yrsvcu,r_ln_val_yrsvcu) & ln_val_yrsvcu!=r_ln_val_yrsvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_yrsvcu-r_ln_val_yrsvcu) if source_year==`y' & !missing(ln_val_yrsvcu,r_ln_val_yrsvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_yrsvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_ysnvcu!=r_ln_val_ysnvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_ysnvcu) & !missing(r_ln_val_ysnvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_ysnvcu) & missing(r_ln_val_ysnvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_ysnvcu,r_ln_val_ysnvcu) & ln_val_ysnvcu!=r_ln_val_ysnvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_ysnvcu-r_ln_val_ysnvcu) if source_year==`y' & !missing(ln_val_ysnvcu,r_ln_val_ysnvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_ysnvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_ytovcu!=r_ln_val_ytovcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_ytovcu) & !missing(r_ln_val_ytovcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_ytovcu) & missing(r_ln_val_ytovcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_ytovcu,r_ln_val_ytovcu) & ln_val_ytovcu!=r_ln_val_ytovcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_ytovcu-r_ln_val_ytovcu) if source_year==`y' & !missing(ln_val_ytovcu,r_ln_val_ytovcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_ytovcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_znavcu!=r_ln_val_znavcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_znavcu) & !missing(r_ln_val_znavcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_znavcu) & missing(r_ln_val_znavcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_znavcu,r_ln_val_znavcu) & ln_val_znavcu!=r_ln_val_znavcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_znavcu-r_ln_val_znavcu) if source_year==`y' & !missing(ln_val_znavcu,r_ln_val_znavcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_znavcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_zndvcu!=r_ln_val_zndvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_zndvcu) & !missing(r_ln_val_zndvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_zndvcu) & missing(r_ln_val_zndvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_zndvcu,r_ln_val_zndvcu) & ln_val_zndvcu!=r_ln_val_zndvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_zndvcu-r_ln_val_zndvcu) if source_year==`y' & !missing(ln_val_zndvcu,r_ln_val_zndvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_zndvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_znevcu!=r_ln_val_znevcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_znevcu) & !missing(r_ln_val_znevcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_znevcu) & missing(r_ln_val_znevcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_znevcu,r_ln_val_znevcu) & ln_val_znevcu!=r_ln_val_znevcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_znevcu-r_ln_val_znevcu) if source_year==`y' & !missing(ln_val_znevcu,r_ln_val_znevcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_znevcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_znhvcu!=r_ln_val_znhvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_znhvcu) & !missing(r_ln_val_znhvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_znhvcu) & missing(r_ln_val_znhvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_znhvcu,r_ln_val_znhvcu) & ln_val_znhvcu!=r_ln_val_znhvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_znhvcu-r_ln_val_znhvcu) if source_year==`y' & !missing(ln_val_znhvcu,r_ln_val_znhvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_znhvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_znivcu!=r_ln_val_znivcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_znivcu) & !missing(r_ln_val_znivcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_znivcu) & missing(r_ln_val_znivcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_znivcu,r_ln_val_znivcu) & ln_val_znivcu!=r_ln_val_znivcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_znivcu-r_ln_val_znivcu) if source_year==`y' & !missing(ln_val_znivcu,r_ln_val_znivcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_znivcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_znovcu!=r_ln_val_znovcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_znovcu) & !missing(r_ln_val_znovcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_znovcu) & missing(r_ln_val_znovcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_znovcu,r_ln_val_znovcu) & ln_val_znovcu!=r_ln_val_znovcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_znovcu-r_ln_val_znovcu) if source_year==`y' & !missing(ln_val_znovcu,r_ln_val_znovcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_znovcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_znpvcu!=r_ln_val_znpvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_znpvcu) & !missing(r_ln_val_znpvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_znpvcu) & missing(r_ln_val_znpvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_znpvcu,r_ln_val_znpvcu) & ln_val_znpvcu!=r_ln_val_znpvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_znpvcu-r_ln_val_znpvcu) if source_year==`y' & !missing(ln_val_znpvcu,r_ln_val_znpvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_znpvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_znrvcu!=r_ln_val_znrvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_znrvcu) & !missing(r_ln_val_znrvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_znrvcu) & missing(r_ln_val_znrvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_znrvcu,r_ln_val_znrvcu) & ln_val_znrvcu!=r_ln_val_znrvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_znrvcu-r_ln_val_znrvcu) if source_year==`y' & !missing(ln_val_znrvcu,r_ln_val_znrvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_znrvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_znsvcu!=r_ln_val_znsvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_znsvcu) & !missing(r_ln_val_znsvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_znsvcu) & missing(r_ln_val_znsvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_znsvcu,r_ln_val_znsvcu) & ln_val_znsvcu!=r_ln_val_znsvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_znsvcu-r_ln_val_znsvcu) if source_year==`y' & !missing(ln_val_znsvcu,r_ln_val_znsvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_znsvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_zntvcu!=r_ln_val_zntvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_zntvcu) & !missing(r_ln_val_zntvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_zntvcu) & missing(r_ln_val_zntvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_zntvcu,r_ln_val_zntvcu) & ln_val_zntvcu!=r_ln_val_zntvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_zntvcu-r_ln_val_zntvcu) if source_year==`y' & !missing(ln_val_zntvcu,r_ln_val_zntvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_zntvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_zpavcu!=r_ln_val_zpavcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_zpavcu) & !missing(r_ln_val_zpavcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_zpavcu) & missing(r_ln_val_zpavcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_zpavcu,r_ln_val_zpavcu) & ln_val_zpavcu!=r_ln_val_zpavcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_zpavcu-r_ln_val_zpavcu) if source_year==`y' & !missing(ln_val_zpavcu,r_ln_val_zpavcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_zpavcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_zpdvcu!=r_ln_val_zpdvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_zpdvcu) & !missing(r_ln_val_zpdvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_zpdvcu) & missing(r_ln_val_zpdvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_zpdvcu,r_ln_val_zpdvcu) & ln_val_zpdvcu!=r_ln_val_zpdvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_zpdvcu-r_ln_val_zpdvcu) if source_year==`y' & !missing(ln_val_zpdvcu,r_ln_val_zpdvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_zpdvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_zpevcu!=r_ln_val_zpevcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_zpevcu) & !missing(r_ln_val_zpevcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_zpevcu) & missing(r_ln_val_zpevcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_zpevcu,r_ln_val_zpevcu) & ln_val_zpevcu!=r_ln_val_zpevcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_zpevcu-r_ln_val_zpevcu) if source_year==`y' & !missing(ln_val_zpevcu,r_ln_val_zpevcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_zpevcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_zphvcu!=r_ln_val_zphvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_zphvcu) & !missing(r_ln_val_zphvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_zphvcu) & missing(r_ln_val_zphvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_zphvcu,r_ln_val_zphvcu) & ln_val_zphvcu!=r_ln_val_zphvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_zphvcu-r_ln_val_zphvcu) if source_year==`y' & !missing(ln_val_zphvcu,r_ln_val_zphvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_zphvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_zpivcu!=r_ln_val_zpivcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_zpivcu) & !missing(r_ln_val_zpivcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_zpivcu) & missing(r_ln_val_zpivcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_zpivcu,r_ln_val_zpivcu) & ln_val_zpivcu!=r_ln_val_zpivcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_zpivcu-r_ln_val_zpivcu) if source_year==`y' & !missing(ln_val_zpivcu,r_ln_val_zpivcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_zpivcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_zpovcu!=r_ln_val_zpovcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_zpovcu) & !missing(r_ln_val_zpovcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_zpovcu) & missing(r_ln_val_zpovcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_zpovcu,r_ln_val_zpovcu) & ln_val_zpovcu!=r_ln_val_zpovcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_zpovcu-r_ln_val_zpovcu) if source_year==`y' & !missing(ln_val_zpovcu,r_ln_val_zpovcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_zpovcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_zppvcu!=r_ln_val_zppvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_zppvcu) & !missing(r_ln_val_zppvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_zppvcu) & missing(r_ln_val_zppvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_zppvcu,r_ln_val_zppvcu) & ln_val_zppvcu!=r_ln_val_zppvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_zppvcu-r_ln_val_zppvcu) if source_year==`y' & !missing(ln_val_zppvcu,r_ln_val_zppvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_zppvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_zprvcu!=r_ln_val_zprvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_zprvcu) & !missing(r_ln_val_zprvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_zprvcu) & missing(r_ln_val_zprvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_zprvcu,r_ln_val_zprvcu) & ln_val_zprvcu!=r_ln_val_zprvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_zprvcu-r_ln_val_zprvcu) if source_year==`y' & !missing(ln_val_zprvcu,r_ln_val_zprvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_zprvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_zpsvcu!=r_ln_val_zpsvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_zpsvcu) & !missing(r_ln_val_zpsvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_zpsvcu) & missing(r_ln_val_zpsvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_zpsvcu,r_ln_val_zpsvcu) & ln_val_zpsvcu!=r_ln_val_zpsvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_zpsvcu-r_ln_val_zpsvcu) if source_year==`y' & !missing(ln_val_zpsvcu,r_ln_val_zpsvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_zpsvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & ln_val_zptvcu!=r_ln_val_zptvcu
    local changed=r(N)
    quietly count if source_year==`y' & missing(ln_val_zptvcu) & !missing(r_ln_val_zptvcu)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(ln_val_zptvcu) & missing(r_ln_val_zptvcu)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(ln_val_zptvcu,r_ln_val_zptvcu) & ln_val_zptvcu!=r_ln_val_zptvcu
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(ln_val_zptvcu-r_ln_val_zptvcu) if source_year==`y' & !missing(ln_val_zptvcu,r_ln_val_zptvcu)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("r_ln_val_zptvcu") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & value_added_share_of_output!=va_share_output_repaired
    local changed=r(N)
    quietly count if source_year==`y' & missing(value_added_share_of_output) & !missing(va_share_output_repaired)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(value_added_share_of_output) & missing(va_share_output_repaired)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(value_added_share_of_output,va_share_output_repaired) & value_added_share_of_output!=va_share_output_repaired
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(value_added_share_of_output-va_share_output_repaired) if source_year==`y' & !missing(value_added_share_of_output,va_share_output_repaired)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("va_share_output_repaired") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & energy_intensity_monetary!=ei_money_output_repaired
    local changed=r(N)
    quietly count if source_year==`y' & missing(energy_intensity_monetary) & !missing(ei_money_output_repaired)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(energy_intensity_monetary) & missing(ei_money_output_repaired)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(energy_intensity_monetary,ei_money_output_repaired) & energy_intensity_monetary!=ei_money_output_repaired
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(energy_intensity_monetary-ei_money_output_repaired) if source_year==`y' & !missing(energy_intensity_monetary,ei_money_output_repaired)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("ei_money_output_repaired") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & energy_intensity_gj_nominal!=ei_gj_output_repaired
    local changed=r(N)
    quietly count if source_year==`y' & missing(energy_intensity_gj_nominal) & !missing(ei_gj_output_repaired)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(energy_intensity_gj_nominal) & missing(ei_gj_output_repaired)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(energy_intensity_gj_nominal,ei_gj_output_repaired) & energy_intensity_gj_nominal!=ei_gj_output_repaired
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(energy_intensity_gj_nominal-ei_gj_output_repaired) if source_year==`y' & !missing(energy_intensity_gj_nominal,ei_gj_output_repaired)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("ei_gj_output_repaired") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & co2_intensity_nominal!=ci_co2_output_repaired
    local changed=r(N)
    quietly count if source_year==`y' & missing(co2_intensity_nominal) & !missing(ci_co2_output_repaired)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(co2_intensity_nominal) & missing(ci_co2_output_repaired)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(co2_intensity_nominal,ci_co2_output_repaired) & co2_intensity_nominal!=ci_co2_output_repaired
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(co2_intensity_nominal-ci_co2_output_repaired) if source_year==`y' & !missing(co2_intensity_nominal,ci_co2_output_repaired)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("ci_co2_output_repaired") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & own_generation_reported!=own_gen_positive_reported
    local changed=r(N)
    quietly count if source_year==`y' & missing(own_generation_reported) & !missing(own_gen_positive_reported)
    local gained=r(N)
    quietly count if source_year==`y' & !missing(own_generation_reported) & missing(own_gen_positive_reported)
    local lost=r(N)
    quietly count if source_year==`y' & !missing(own_generation_reported,own_gen_positive_reported) & own_generation_reported!=own_gen_positive_reported
    local finite=r(N)
    assert `gained'+`lost'+`finite'==`changed'
    generate double __delta=abs(own_generation_reported-own_gen_positive_reported) if source_year==`y' & !missing(own_generation_reported,own_gen_positive_reported)
    quietly summarize __delta, meanonly
    local maxdelta=r(max)
    post `p' (`y') ("own_gen_positive_reported") (`changed') (`gained') (`lost') (`finite') (`maxdelta')
    drop __delta
}
postclose `p'
use "corrections/reports/change_audit.dta", clear
isid source_year variable
keep source_year variable changed_n old_missing_new_valid_n old_valid_new_missing_n finite_changed_n max_absolute_difference
order source_year variable
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "C150_change_audit" "C150"
