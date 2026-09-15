# Data preparation baris 0 — hasil sintetis aktual

DTA utama: `results/G0_analysis_ready_SYNTHETIC_CALCULATED.dta`. 1.200 baris, 3.837 kolom (3.793 dipertahankan +44 tambahan), 100 ID sintetis, 12 tahun.

| Komponen Word | Status | Yang dihitung/diperiksa | Batas tersisa |
|---|---|---|---|
| Create main dataset | selesai (sintetis) | 1200 rows, 3837 columns; 3793 original names plus 44 documented fields; primary executed | No inference about original company observations |
| Include all source variables | selesai (sintetis) | All staged raw columns preserved; 288000 raw Excel cells independently compared | Synthetic inputs only; additional real modules not supplied |
| Clean outliers | selesai (aturan dan sensitivitas) | Within-year negative/>10*p99 flags; original rows/values retained; clean_* companions exclude flagged values. Shared production program passed 1002-row adversarial cases | Tail flag is diagnostic, not proof of data error; no automatic winsorization. Main fixture may contain no extreme tail |
| Value logs | selesai (domain valid) | All val_* logs and 12 named logs refreshed after annual mapping; zero/negative/missing excluded from log only | Unverified value-code meanings remain explicit; positive number does not establish semantic validity |
| Stable analytical names | selesai | 3793 original names and meanings retained; legacy mixed capital aliases labelled; additions enumerated in schema-additions.csv | Some annual definitions remain provisional |
| Panel | selesai (panel sintetis) | 100 supplied IDs 800001–800100 across 12 waves, flags dummy=1 and real_verified=0 | Genuine real-company link not established; 2016 not invented |
| Merge WPI | parsial (output berjalan) | 1200/1200 output deflated at base 2000 using four explicit fixture-sector bridges; 48 year/sector cells matched; VA single-output-deflator proxy | Appropriate input/capital/wage price series not established. 2020–22 splice and source extraction gaps disclosed. No double deflation |
| Energy Scope1/Scope2/total | parsial | Observed nine-fuel GJ and purchased-electricity GJ; own generation excluded from additions; strict nine-component and sensitivity companions | Additional fuels/heat and some units/factors incomplete; 2018–19 known unit gap; no claim comprehensive total |
| Emissions Scope1/Scope2/total | parsial | Nine-fuel combustion CO2 and purchased-electricity CO2; identities checked; no-grid-carry companion | Not full GHG CO2e; post-2014 grid carry and extra fuels/heat not certified |
| VA/output/capital per worker | selesai sesuai cakupan sumber | VA and output nominal/positive worker; output real and VA real proxy/worker; stock and additions separately divided by worker | Main capital is capital_stock_per_worker; legacy capital_per_worker_nominal remains mixed alias. Later stock definitions/2015 exact additions remain open |

## Ketersediaan inti per tahun

Jumlah berikut adalah nilai nonmissing, dari denominator 100 rekaman sintetis per tahun. Angka ini bukan validasi definisi sumber dan bukan estimasi nasional.

| Tahun | Output nominal | Output riil | VA riil proxy | Capital stock | Capital additions | Stock/worker | Scope1 9-fuel GJ | Scope2 GJ |
|---|---|---|---|---|---|---|---|
| 2010 | 100 | 100 | 100 | 100 | 96 | 100 | 100 | 100 |
| 2011 | 100 | 100 | 100 | 100 | 96 | 100 | 100 | 100 |
| 2012 | 100 | 100 | 100 | 100 | 96 | 100 | 100 | 100 |
| 2013 | 100 | 100 | 100 | 100 | 96 | 100 | 100 | 100 |
| 2014 | 100 | 100 | 100 | 100 | 96 | 100 | 100 | 100 |
| 2015 | 100 | 100 | 100 | 100 | 0 | 100 | 100 | 100 |
| 2017 | 100 | 100 | 100 | 100 | 96 | 100 | 100 | 100 |
| 2018 | 100 | 100 | 100 | 100 | 96 | 100 | 100 | 100 |
| 2019 | 100 | 100 | 100 | 100 | 96 | 100 | 100 | 100 |
| 2020 | 100 | 100 | 100 | 100 | 96 | 100 | 100 | 100 |
| 2021 | 100 | 100 | 100 | 100 | 96 | 100 | 100 | 100 |
| 2022 | 100 | 100 | 100 | 100 | 96 | 100 | 100 | 100 |

Semua 3.837 variabel beserta missing/zero/negative per tahun ada di `coverage_by_variable_year.csv`; definisi setiap kolom ada di `actual_schema.csv`, definisi tambahan di `contracts/schema-additions.csv`. Readme/Excel bukan pengganti DTA.
