* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
use "$G0INPUT/sample_mfg2010_raw.dta", clear
append using "$G0INPUT/sample_mfg2011_raw.dta"
append using "$G0INPUT/sample_mfg2012_raw.dta"
append using "$G0INPUT/sample_mfg2013_raw.dta"
append using "$G0INPUT/sample_mfg2014_raw.dta"
append using "$G0INPUT/sample_mfg2015_raw.dta"
append using "$G0INPUT/sample_mfg2017_raw.dta"
append using "$G0INPUT/sample_mfg2018_raw.dta"
append using "$G0INPUT/sample_mfg2019_raw.dta"
append using "$G0INPUT/sample_mfg2020_raw.dta"
append using "$G0INPUT/sample_mfg2021_raw.dta"
append using "$G0INPUT/sample_mfg2022_raw.dta"
sort source_year source_row
isid source_year source_row
assert _N==1200
assert source_year!=2016
compress
save "$G0D/G0_raw_fields_preserved.dta", replace
