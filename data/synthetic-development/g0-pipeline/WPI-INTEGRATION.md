# WPI integration — actual macro reference with synthetic company values

The source is the **Working Folder** link in the verified four-member **Kolega DEN BPS** WhatsApp group (Deasy, Schalke, Toar, Natanael): [OneDrive project working folder](https://1drv.ms/f/c/ef62d3c46560b30c/IgAndbgBzjHvQLM50WYiwiu0Acppk96xnje4R1yTQpcGgAg?e=nFyfh0), then `2026 - IBS BPS Research Project/WPI_deflator_package`. The separate Analysis Draft link was not used as a folder substitute. Native WhatsApp and Safari UI were used; no message, cloud edit or credential change occurred. Safari could open the shared folder without a new sign-in. Its download auto-extracted the package at 14:02:23 WIB on 10 September 2026. OneDrive displayed modifications on 3 September 2026, 22:10:13–17 WIB.

All 18 downloaded files are retained unmodified in [source package](references/toar-wpi-20260910/README.md), with names, byte counts, SHA256 and retrieval metadata in [source manifest](contracts/wpi-source-manifest.json). These are macro indices, metadata, concordances and code, with no company observations. Original source publication PDFs and the separate original `wpio.dta` anchor file were not included; the delivered extended DTA contains the historical anchor columns.

## What the reference actually contains

`wpio_extended_2000_2022.dta` has **131 ISIC Rev3/3.1 four-digit manufacturing rows and index columns 1983–2022**, base **2000=100**. The filename understates historical coverage. 2016 is missing for all codes. The source dataset label mistakenly still says 2019; actual columns and numeric checks govern this adapter.

The source XLSX has seven sheets: README; annual_long (450 data rows); wide_2010base (50); monthly_long (450); subsector_map (50); wide_2018base (57); splice_2020_2022 (50). The main output WPI keeps historical values through 2012. 2013–2019, excluding 2016, use the 2010 anchor times a mapped annual IHPB ratio. Two recycling codes use source CAGR extrapolation; neither is selected by the synthetic fixtures.

2020–2022 use a **supplied December-2019 splice** from 2018-base IHPB onto the old 2010-base scale, then the original 2010 WPI anchor expresses results on base 2000. Subsector definitions changed along with the base. The 49 mapped old subsectors and their link factors are explicit; old subsector 36 has no counterpart. Source ISIC 3210 falls back to its primary constituent. This is the source package's documented approximation, not a newly observed continuous series. Sector-dependent splice errors are **not generally absorbed by year fixed effects**; the source README's blanket claim is not accepted. No regression is run here.

The Stata reference edge independently reconstructs **1,179 extension cells** from the supplied concordance, anchor and annual IHPB table. Differences from delivered DTA are bounded at relative 1e-6 to accommodate published CSV/import precision; exact maxima are in [reconstruction controls](results/wpi_reconstruction_checks.csv). Delivered double-precision DTA index values remain the merge source. No index values are silently replaced to obtain equality.

## Exact source-validation coverage and gaps

[Workbook audit](results/wpi_workbook_audit.json), [monthly cell checks](results/wpi_monthly_checks.csv), [splice checks](results/wpi_splice_checks.csv).

- **438** annual averages were independently recomputed from twelve supplied months within 0.05 index points.
- **12** rows lack some monthly cells; their exact year/subsector and counts are listed in monthly checks. Their annual figures remain supplied-source values, not independently month-verified values.
- The workbook's claim of 171 newer monthly rows is not supported by the supplied monthly sheet: it has 150 rows for 2020–2022. **21 rows for subsectors 51–57** are absent from the monthly/annual-long detail, although their annual values exist in wide_2018base. No rows were fabricated.
- **147** splice cells were checked against supplied raw annual series, link factors and the CSV at displayed precision (workbook 2 decimal places, CSV 4). Raw dual-base December2019 anchor observations are not supplied, so the link factors' underlying source extraction is not independently verified here.

These limitations do not prevent transparent synthetic output deflation. They prevent claiming complete source-publication verification.

## Classification decision

The synthetic generator deliberately assigns the same four modern-looking activity codes to every wave, including fields named for older KBLI revisions. These fictional codes are not evidence of real annual classification continuity. The adapter uses a **four-row synthetic-only activity bridge**, never arbitrary string-prefix matching or a many-to-many merge:

| Synthetic code | Activity | Rev4 correspondence | Selected WPI code |
|---|---|---|---|
|10110|Meat processing/preservation|1010|1511|
|13111|Textile fibre preparation|1311|1711|
|20111|Basic inorganic chlor/alkali chemicals|2011|2411|
|25111|Structural metal products for buildings|2511|2811|

The retained [UN Rev3.1/Rev4 correspondence](../../../references/july-end-to-end/data/concordance/isic_correspondence_rev31_rev4.csv) supports every chosen Rev4/Rev3.1 pair. Partial correspondences remain acknowledged. The detailed chemical activity selects 2411; the other partial Rev4-2011 parents for alcohol, nuclear processing and other chemicals are not averaged indiscriminately. BPS sources support the detailed [chemical classification](https://klasifikasi.web.bps.go.id/app/view/kbli2015/20111) and [textile subgroup](https://klasifikasi.web.bps.go.id/app/view/kbli2015/1311); [OSS's retained KBLI2020 meat activity](https://oss.go.id/id/kbli/detail/17de2180-f397-4cd0-a3da-0361bdc655d3) identifies the meat fixture. The broader original UN classification PDF remains in the repository. The source WPI's ISIC3 mean-collapse convention is not used: the selected four-digit activity index is retained to avoid unnecessarily mixing sectors. This is a documented implementation choice for these fixtures, **not a validated universal real-company KBLI crosswalk**.

The bridge is unique on `industry_code`; WPI is unique on `isic4 source_year`. Stata uses m:1, checks uniqueness before merging and retains matched/unmatched counts in [48-cell merge audit](results/wpi_merge_audit.csv). No 2016 company records are created.

## Deflation and stable meanings

- `wpi_output_index` is the actual index, base2000=100. `deflator_output = wpi_output_index/100` is the conversion factor.
- `gross_output_real = gross_output_nominal/deflator_output`, in **2000 Rp000**. Nominal values are retained.
- `value_added_real = value_added_nominal/deflator_output` is explicitly labelled a **single-output-deflator approximation**. Flags identify this choice; it is not double-deflated output minus real inputs. Positive-domain logs and per-worker measures are separate.
- There is no appropriate input, capital or wage price series in this package. `deflator_inputs`, `deflator_capital`, `deflator_wages`, `capital_real`, and `intermediate_inputs_real` remain missing. This is not replaced with deflator1 or the output index. Capital stock and additions remain distinct nominal measures.
- Real physical intensities retain their numerator's partial component/factor status. A real denominator does not certify energy coverage.

Existing 3,793 names remain in original order; [44 added columns](contracts/schema-additions.csv) follow them. Old mixed capital aliases remain for compatibility, with explicit labels; downstream's primary stock measures are `capital_stock_nominal` and `capital_stock_per_worker`.

## Outlier and energy behavior

Sources and all 1,200 firm-year rows stay intact. Negative energy quantities are excluded from nonnegative `cl_*` companions. Annual `>10*p99` flags are refreshed after source unit corrections; flags alone are not proof of an error. New `clean_*` economic variables are an explicit sensitivity branch excluding negatives and extreme tails. Zero is retained, missing stays missing, and worker denominators must be positive. The same Stata cleaning program is exercised by **1,002 controlled fixture records**, including a tail large enough to trigger the annual rule, negatives, missing/zero workers and cross-year isolation. Such a tail generally cannot trigger in a100-record year with this percentile rule; that is why the dedicated fixture is larger, rather than weakening the threshold to manufacture a main-sample flag.

The nine-fuel energy/combustion-CO2 method and factor scenarios remain the inherited specification. All-component nine-fuel subtotals are labelled as such, not comprehensive Scope 1. Purchased electricity is counted once; self-generation electricity is not added on top of its fuel consumption. Extra fuels, mixed biomass, natural-gas heating-basis/factors, purchased heat and some2018/19 units remain source gaps. Reference heat quantities for firewood/charcoal and potential lubricant heat reuse LUDI's factors and remain outside the legacy fossil subtotal. `energy_all_sources_complete=0` explicitly prevents a broad completeness claim. Emissions labels say combustion CO2, not full CO2e.

Final component status, exact annual availability and missing sources are in [ROW0-STATUS](results/ROW0-STATUS.md). A completed synthetic pipeline with WPI does not establish completion on original company data.

## Legacy WPIN check

A separately retained legacy `wpin.dta` does exist (129 sectors,1983–2016), and was inspected as a macro reference only. All WPI variable labels and dataset label are blank. It shares128 sector keys with the delivered output WPI but some historical values differ (maximum217.281 index points); the filename alone does not establish an input-price concept or appropriate input basket. The May15 predecessor decision explicitly left correct input-specific deflation unresolved. Therefore the open dependency is **a verified appropriate input deflator**, not a claim that no older WPI file exists. Exact metadata/hash and historical overlap check: [legacy audit](results/legacy-wpin-reference-audit.json). The legacy file is not a pipeline input and no original company observations were read.

BPS historical KBLI publication reference: [KBLI2015/2017 publication](https://ppid.bps.go.id/upload/doc/Perka_BPS_Nomor_19_Tahun_2017_Tentang_Perubahan_atas_Perka_BPS_No_95_Tahun_2015_Tentang_Klasifikasi_Baku_Lapangan_Usaha_Indonesia_1724397695.pdf). Its documented national split maps ISIC Rev4 1010 into KBLI1011/1012/1013, supporting the explicit meat bridge rather than blindly using the first four digits. The [West Java provincial KBLI table](https://dpmptsp-satudata.jabarprov.go.id/kbli) also identifies25111 as structural non-aluminium metal goods for buildings. Source access was read-only.
