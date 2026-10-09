/*==========================================================================
  Line 5: "FDI or not"
  Data  : SI 2010-2022 (data/b11_si.dta), clean == 1
  Output sheets:
    t05_fdi_rate       share FDI (>=10%) and any foreign share (>0%) by FDI (foreign ownership >=10%) vs domestic (mean x 100 = %)
    t05_foreign_share  foreign ownership (%) by FDI (foreign ownership >=10%) vs domestic

  NOTE: 2020 FDI is set missing (47% FDI in that year is not credible), so
  2020 is not in these tables.
==========================================================================*/
if "$B11" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B11_DATA/b11_si.dta", clear
keep if clean == 1
do "$B11/_sumstats.do" "fdi fdi_any" "fdi" "t05_fdi_rate"
do "$B11/_sumstats.do" "foreign_share" "fdi" "t05_foreign_share"
