* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
version 17
clear all
set more off
args root
cd "`root'"
local out "dag/reports/word_data/G0/20260910-code-verification"
capture log close _all
log using "`out'/chart_readability.log", text replace
import delimited using "`out'/corrected_variable_coverage.csv", clear varnames(1)
twoway (connected observed_pct source_year if variable=="export_flag", lcolor(navy) mcolor(navy)) (connected observed_pct source_year if variable=="rd_activity_flag", lcolor(maroon) mcolor(maroon)) (connected observed_pct source_year if variable=="innovation_flag", lcolor(forest_green) mcolor(forest_green)), xlabel(2010(1)2022, labsize(small) angle(45)) ylabel(0(20)100) ytitle("Terisi (% sampel tahunan)") xtitle("") legend(order(1 "Ekspor umum" 2 "R&D" 3 "Inovasi") rows(1) size(small)) title("SYNTHETIC: cakupan indikator terverifikasi", size(medium)) note("2016 tidak dipasok. Nilai kerja provisional tersedia pada tabel Working coverage.", size(small)) graphregion(color(white))
graph export "`out'/indicator_coverage.png", width(1800) replace
twoway (connected observed_pct source_year if variable=="env_amdal_flag" & source_year>=2020, lcolor(navy) mcolor(navy)) (connected observed_pct source_year if variable=="env_ukl_upl_flag" & source_year>=2020, lcolor(maroon) mcolor(maroon)) (connected observed_pct source_year if variable=="env_sppl_flag" & source_year>=2020, lcolor(forest_green) mcolor(forest_green)) (connected observed_pct source_year if variable=="env_waste_treatment_flag" & source_year>=2020, lcolor(orange) mcolor(orange)), xlabel(2020(1)2022) ylabel(0(20)100) ytitle("Terisi (% sampel tahunan)") xtitle("") legend(order(1 "AMDAL" 2 "UKL-UPL" 3 "SPPL" 4 "Pengolahan limbah") rows(2) size(small)) title("SYNTHETIC: cakupan indikator lingkungan", size(medium)) note("Kode sumber 1/2, 3/4, 5/6, 7/8 telah dipetakan ke 1/0.", size(small)) graphregion(color(white))
graph export "`out'/environment_coverage.png", width(1800) replace
keep if variable=="rd_cost_nominal" & source_year>=2017
generate double positive_pct=100*yes/rows
graph bar observed_pct positive_pct, over(source_year) ytitle("Percent of fictional records") title("SYNTHETIC: R&D expense coverage") legend(order(1 "Observed" 2 "Positive")) note("Calculated from synthetic IRDVCU; COSTRD is a funding code.") graphregion(color(white))
graph export "`out'/rd_expense_coverage.png", width(1800) replace
display "G0_READABLE_CHARTS_SUCCESS"
log close
