/*==========================================================================
  Line 6: "FDI or not"
  Data  : SI 2010-2022 (data/b15_si.dta), clean == 1
  Output sheets:
    t06_fdi_rate_java       share FDI (>=10%) and any foreign share (>0%) by Java vs outside Java (mean x 100 = %)
    t06_foreign_share_java  foreign ownership (%) by Java vs outside Java
    t06_fdi_rate_prov       share FDI (>=10%) and any foreign share (>0%) by province (mean x 100 = %)
    t06_foreign_share_prov  foreign ownership (%) by province

  NOTE: 2020 FDI is set missing (47% FDI in that year is not credible), so
  2020 is not in these tables.
==========================================================================*/
if "$B15" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B15_DATA/b15_si.dta", clear
keep if clean == 1
do "$B15/_sumstats.do" "fdi fdi_any" "java" "t06_fdi_rate_java"
do "$B15/_sumstats.do" "foreign_share" "java" "t06_foreign_share_java"
do "$B15/_sumstats.do" "fdi fdi_any" "prov" "t06_fdi_rate_prov"
do "$B15/_sumstats.do" "foreign_share" "prov" "t06_foreign_share_prov"
