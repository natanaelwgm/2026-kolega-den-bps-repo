/*==========================================================================
  Line 5: "FDI or not"
  Data  : SI 2010-2022 (data/b08_si.dta), clean == 1
  Output sheets:
    t05_fdi_rate       share FDI (>=10%) and any foreign share (>0%) by exporter vs non-exporter (mean x 100 = %)
    t05_foreign_share  foreign ownership (%) by exporter vs non-exporter

  NOTE: 2020 FDI is set missing (47% FDI in that year is not credible), so
  2020 is not in these tables.
==========================================================================*/
if "$B08" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B08_DATA/b08_si.dta", clear
keep if clean == 1
do "$B08/_sumstats.do" "fdi fdi_any" "exporter" "t05_fdi_rate"
do "$B08/_sumstats.do" "foreign_share" "exporter" "t05_foreign_share"
