* WFDOC: Satu record per obs_id; source_year integer 2010–2022 dan 2016 tetap hilang. Kunci duplikat, tahun kosong, atau di luar rentang menggagalkan edge.
* WFDOC: S01_input.dta mempertahankan panel; observed_waves.csv menghitung record per tahun dengan label G0.5 DEVELOPMENT.
isid obs_id
assert !missing(source_year)
assert source_year == floor(source_year)
assert source_year != 2016
assert inrange(source_year,2010,2022)
save "$G1_RUN/S01_input.dta", replace
local N_source = _N
preserve
* WFDOC: N_source adalah record per wave, bukan jumlah perusahaan; restore/assert memastikan panel sumber tidak berubah.
contract source_year, freq(N_source)
gen str100 data_label = "G0.5 DEVELOPMENT - perturbed data; not final empirical findings"
export delimited using "$G1_RUN/outputs/observed_waves.csv", replace
restore
assert _N == `N_source'
