/*==========================================================================
  Line 7: "Waste management."
  Data  : SI 2020-2022 (data/b208_si.dta), clean == 1
  Output sheet:
    t07_waste_by_year  % firms, among firms that answered:
                         waste_treat   has a waste installation / treatment (2020-2022)
                         waste_solid   reports solid waste (2022)
                         waste_liquid  reports liquid waste (2022)
                         waste_haz     reports hazardous (B3) waste (2022)
                         waste_any     reports at least one of the three (2022)
                       pool + by year

  NOTE: the waste-type questions are in the 2022 form only, and only ~26% of
  2022 firms answer them. They record whether a firm REPORTS that kind of
  waste, which says more about what it produces than how it manages it. The
  closest measure of waste MANAGEMENT is waste_treat (2020-2022).
==========================================================================*/
if "$B208" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B208_DATA/b208_si.dta", clear
keep if clean == 1
do "$B208/_incidence.do" "waste_treat waste_solid waste_liquid waste_haz waste_any" "t07_waste_by_year"
