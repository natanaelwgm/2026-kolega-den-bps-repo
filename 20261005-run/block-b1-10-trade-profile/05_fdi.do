/*==========================================================================
  Line 5: "FDI or not"
  Data  : SI 2010-2022 (data/b10_si.dta), clean == 1
  Output sheets:
    t05_fdi_rate       share FDI (>=10%) and any foreign share (>0%) by non-trading / export only / import only / export and import (mean x 100 = %)
    t05_foreign_share  foreign ownership (%) by non-trading / export only / import only / export and import

  NOTE: 2020 FDI is set missing (47% FDI in that year is not credible), so
  2020 is not in these tables.
==========================================================================*/
if "$B10" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B10_DATA/b10_si.dta", clear
keep if clean == 1
do "$B10/_sumstats.do" "fdi fdi_any" "trade_profile" "t05_fdi_rate"
do "$B10/_sumstats.do" "foreign_share" "trade_profile" "t05_foreign_share"
