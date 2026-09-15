# G1 v3 economic prerequisites and development specification

Independent source review by `/root/prerequisite_audit`, Codex, completed 13 September 2026, 20:05 WIB / 13:05 UTC. Review checkpoint: main `73ef9279fc3be5275939dca93afcfbbe4deaf096`. This is a source assessment and pre-execution specification, not an estimation pass receipt. No Stata job was launched by this reviewer. Only metadata, source documentation, small reference tables and public macro sources were read; no original-history company dataset was used. The parent owns execution and root agent-history.

## Decision before fitting

The v3 fictional panel is usable for explicitly labelled DEVELOPMENT work. The current owner instruction and issue 9 override the historical missing-identity gate for development. Lack of REAL company linkage is not a development blocker. The primary accepted-real-input specification remains separate from the nominal compatibility demonstration below.

**Recommended immediate execution:** register a nominal value-added production-function DEVELOPMENT sensitivity using the existing positive candidate monetary fields, beginning-of-year capital formed with actual-calendar lags, separate two-digit technology pools, and explicitly simulated disappearance intervals for the OP selection demonstration. Do not set primary real-input admission to one or call its residual physical/real TFP. The method API should distinguish `measurementmode(nominal_development)`, `syntheticpanel(1)` and `selectionmode(synthetic_disappearance)`; this does not authorize passing synthetic events as authenticated actual closures.

**Concrete science verdict: yes, a separately labelled approximate-real DEVELOPMENT sensitivity can run.** The complete 2010–2012 BPS broad manufacturing-output, producers' materials and capital-goods prices are now downloaded, hashed and visually checked. Coherent nonland stock and gross additions can be formed from existing raw G0.5 component fields under the parsing/domain rules below. This is a defensible sensitivity for development execution using actual macro prices and declared measurement approximations. It does not turn the synthetic trajectories into real company histories, certify supplier units or complete the primary accepted-real-input specification. Empty inherited G0 deflators are not a reason to stop this branch.

## Frozen input and scope

- Input: `data/g0-5-development/manifest.json`, SHA-256 `060b0ee0a2158a9c94b0e7e68fcfba719eda37561422855471a99da6810ba260`, version `g05-external-excel-panel-v3`, schema 4.
- 33,049 observations, 4,396 columns, 10,395 fictional firms and 22,654 constructed links. Official Stata package evidence records 20,579 annual links and 2,075 two-calendar-year links across 2015–2017. Those latter links are not annual lags.
- Source years: 2010–2015 and 2017–2022; no 2016 observations. Full-wave counts are 2,334; 2,337; 2,359; 2,369; 2,452; 2,632; 3,357; 3,011; 3,007; 2,936; 3,078; 3,177 respectively.
- Read `AGENTS.md`, `docs/DATA-MODES.md`, `docs/DATA-IDENTIFIERS.md`, `harness/g05/EXTERNAL-WORKFLOW.md`, and `harness/g05/PANEL-GENERATOR.md`. G0.5 preserves the previous economic payload, with per-record coherent multiplicative level jitter of absolute magnitude 0.1–0.5%; v3 adds the Excel-first identity derivative. The ID generator uses nine contemporaneous measurements, province × two-digit sector boundaries, annual clustering and optional matching. Its constructed dynamics and disappearance reflect this procedure; no structural economic data-generating model is certified.
- Use `harness.data_source.load_data(..., require_panel=True)` in development mode and require `psid_status=synthetic_development`, nonmissing unique `(psid, source_year)`. Preserve original `obs_id` for production-row attachment. Annual cluster IDs are not firm IDs.

## Exact immediate nominal specification

| Role | Existing G0.5 operand | Registered interpretation |
|---|---|---|
| Output | `value_added_nominal` | Reported signed nominal VA candidate; log only finite strictly positive values; do not recompute an accounting identity |
| Labor | `workers` | Reported worker count; log only finite strictly positive values |
| End-year capital | `capital_stock_nominal` | Estimated current-price fixed assets at 31 December, including land; source `raw_v1115` |
| Production capital | `K_begin(t)=capital_stock_nominal(t-1)` | Lag within the same synthetic firm at actual calendar delta 1; source stock year must independently have documentary support |
| LP/ACF/Wooldridge proxy | `val_rtlvcu` | Reported raw and supporting materials used; source RTLVCU; log only finite strictly positive values |
| OP proxy | `capital_additions_nominal` | Gross purchase/addition/construction/major-repair flow during the year; source CTTTCU; positive-only log; not net investment after disposals |
| Technology | valid five-digit `industry_code`, first two digits 10–33 | Separate two-digit pools; no invented zero-padding or pooling solely to obtain sample size |
| Calendar | `source_year` | Integer actual years and one-year lag operator |

`capital_nominal` is a mixed historical alias (additions in 2010–2014, stock in 2015) and is not a permissible stock operand. `intermediate_inputs_nominal` is aggregate IINPUT expenditure and is not silently interchangeable with materials RTLVCU. No nominal field is renamed `*_real`.

**Conservative annual domain:** documentary support for the exact stock date and perimeter exists in 2010, 2011, 2012 and 2015. The recommended bounded first run uses source years 2010–2012, production years 2011–2012, and dynamic moment year 2012. Production 2011 requires stock 2010; dynamic 2012 requires both production 2011 and 2012, hence stock 2010 and 2011. The source universe retains 2010 rows to construct lags even when production eligibility is zero. The wrapper receives pre-lag production eligibility, not an eligibility flag that already requires an eligible prior production year. Positive OP current and lagged investment is a method-specific requirement. No 2017 lag is manufactured from 2015.

The extra 2015 stock documentary evidence cannot alone extend this bounded annual sample: production 2015 requires stock 2014, and there is no 2016 production wave. Source stock 2013/2014 cannot be accepted by extrapolating the 2010–2012 form. Later source research is recorded below and must be resolved before any extension.

**Conditional development unit assumption, to persist with results:** use the current G0.5 numeric values as supplied, with no invented factor or deflator. For each monetary field, assume its candidate unit is one common positive unit across the declared annual sample, consistent with the annual legacy layout's `000 rupiah` label. This is a maintained DEVELOPMENT convention; product-specific supplier scale remains unverified. Do not claim the values have been certified as Rp, Rp000 or Rp million, and do not change historical source acceptance flags. Unknown common positive multiplicative units shift logarithms and the intercept; complete polynomial control spaces accommodate constant translations. That algebra does not eliminate unknown year-specific or firm-specific scales, relative prices, matching-induced dependence or measurement noise. Finite numerical conditioning, weighting and optimization may also change. Results are nominal VA elasticities and a nominal structural residual with price and measurement components, conditional on timing and proxy assumptions; they are not evidence of real technology or recovered firm productivity.

Use the same frozen monetary convention in all four methods. Do not silently add year dummies to only one stage: the pinned method contract explicitly has no extra calendar controls. Any year-control alternative must specify first-stage, transition, selection and instrument treatment as its own registered sensitivity. Restricting the sample to 2011–2012 does not make inflation disappear.

## Exact simulated OP selection convention

The separate demonstration may represent generator-induced disappearance, not economic closure. Construct a derivative risk table with one interval `(t-1,t]` for every synthetic firm observed in the prior supplied wave when the next supplied wave is exactly one calendar year later and both belong to the declared selection horizon. Use the official v3 `psid`/predecessor mapping; do not infer links from similarity again.

1. A matched firm observed in year `t` has `simulated_disappearance=0`. An unmatched prior-wave firm has `simulated_disappearance=1`. New synthetic firms have no prior exposure interval. The last included wave is right-censored for future disappearance. The 2015→2017 gap is excluded from an annual interval definition.
2. For the bounded specification, the estimable risk interval ending in 2012 uses complete lagged 2011 investment and 2011 beginning-capital (stock 2010). Retain all otherwise defined prior-wave risk intervals even if current output/labor/proxy is missing, nonpositive or production-ineligible; source exclusions for missing lagged selection covariates must be counted separately. Do not define exits from a production complete-case filter.
3. For unmatched firms, any added terminal row represents only an interval endpoint. It has no original production `obs_id`, no invented production measurements and an explicit interval-record type. Do not attach productivity to it or count it as an observed company-year. Retain the real predecessor row with its covariates so the lag operator can form the design.
4. Production records used in the dynamic fit must correspond to synthetic continuers. Report the full interval denominator, excluded-covariate intervals, fitted selection denominator, simulated exits and continuers separately from production denominators.
5. Bootstrap the complete frozen synthetic firm histories plus their derivative risk intervals, assign new draw IDs and reconstruct lags; never sample only the selected production rows. Require outcome variation, convergence, full rank and no silently dropped perfect-prediction rows. If the logit fails because matching made outcomes nearly deterministic, preserve that failure; do not create stochastic exits or simplify the selection correction without a new registered sensitivity.

This construction is a valid explicit **selection-model mechanics demonstration** under the authorized fictional panel. It does not establish OP's economic exit mechanism or monotone investment policy. Since matching intentionally uses production-related features, the reported selection behavior is partly a property of the generator.

## Source measurement receipts and annual limits

`releases/2026-09-13-g0/source/source-metadata/inputs/annual_metadata.csv`, SHA-256 `2fb77056bc7e98c0fb1e3eaacca3164c24fd97db4a2b72779387f1bd48045158`, is the current exact annual documentary receipt. For each binding retain `binding_id`, `source_year`, `raw_field`, `documentary_status`, `documentary_concept`, `documentary_unit`, `supplier_numeric_scale_status`, `supplied_file_binding_confidence`, `evidence_json`, `annual_rule_json`, `s2_doc`, `s2_code`, `s2_scale`, `s2_scope`, `s2_release` and `measurement_admitted`. The scale/release/measurement zeros describe unresolved supplied-product acceptance, not a prohibition on a separately declared nominal development assumption.

| Exact binding | Documentary source | Result |
|---|---|---|
| `S2-2010-capital_stock`, `S2-2010-capital_additions` | Locally supplied annotated IBS2010 form, PDF p6, Q18 cols5/2; SHA `ee4573a96b7105dc9e6c523d48bc9cd4a67e5da8e300bcfd6c4a79a8e9833e17` | Stock Dec31, includes land; additions gross flow |
| `S2-2011-capital_stock`, `S2-2011-capital_additions` | IBS2011 form, PDF p7, Q20 cols5/2; SHA `ab5bbfac30bd2f5043c1ddd0b12d5cf8bee66c2f58561fd78705971f83e3b8b3` | Same concepts supported for this year |
| `S2-2012-capital_stock`, `S2-2012-capital_additions` | IBS2012 form, PDF p6, Q18 cols5/2; SHA `e6d802ce61e8a99760af938aaf1670afb1775aad2e7c796d32de5ff64ccd96b0` | Same concepts supported for this year |
| `S2-2013-capital_stock`, `S2-2014-capital_stock` | Annual legacy layout sheets2013/2014 rows145/160 | Current-value total label supported; exact date/perimeter still `LOCAL_LAYOUT_ONLY` in frozen receipt |
| `S2-2015-capital_stock`, `S2-2015-capital_additions` | Official Kaltim2015 publication appendix PDF p50/printed30 Q18 cols5/2; SHA `00ea2ef2a1d69b3379bd5280653effeb4e8d9bc66661a35714b7962a6b82356b` | Both documentary concepts independently supported; current source additions absent |

The annual dictionary workbook is a documentation source, not a company-data fallback: `layout IBS Lama (1975-2015).xlsx`, SHA `c90aee9c44e856ce346b5f8a4ca57638c1276775ff7ad1e5ab79b00fdd04329e`, path recorded inside the receipt. Exact 2010–2012 materials rows are 86,86,81; domestic/imported rows are 84/85,84/85,79/80. Stock component rows map `v1101` land, `v1103` buildings, `v1106` machines/equipment, `v1109` vehicles, `v1112` other assets. The matching raw columns exist in G0.5. Their storage is string, so coverage's `nonzero_numeric=0` does not imply no positive stocks. Those raw components are **preserved**, whereas `capital_stock_nominal` is **jittered**: do not subtract raw land from jittered total. An asset-specific sensitivity must first register a coherent component construction and parsing policy; do not reverse-engineer private jitter factors.

The official [SI2015 public dictionary](https://silastik.bps.go.id/v3/index.php/mikrodata/detail/ZUNuQUd2eXJwd0tZd092R1ltNzErUT09) independently labels V1115 as Dec31 current-price fixed assets, RTLVCU15 as raw/supporting materials, OUTPUT15 as income, IINPUT15 as expenditure, and VTLVCU15 as VA. It describes a separate BPS dissemination product, not a receipt that the supplied anonymized Excel has identical numeric units. The [Kaltim2015 publication](https://kaltim.bps.go.id/id/publication/2017/09/26/3249f0ffa0744b6edae517ea/statistik-industri-besar-dan-sedang-provinsi-kalimantan-timur-2015.html) provides the exact annual questionnaire cited above.

## Price evidence and supported research alternatives

The retained Toar macro package at `data/synthetic-development/g0-pipeline/references/toar-wpi-20260910/` is permissible macro reference data. `data/wpio_extended_2000_2022.dta`, SHA `97c00c1d5c3cd2176a7e5e434f41ca095d2798e7aa15543876ae179033d39439`, has 131 ISIC Rev3/3.1 manufacturing rows, 1983–2022 columns, base2000=100 and missing2016. Its later-year extrapolation/splicing is documented in `WPI-INTEGRATION.md`. The legacy four-code synthetic fixture bridge is not a verified bridge for all present G0.5 industries. A retained national or sector output index can be used only with an explicit new development mapping; do not silently truncate modern KBLI digits into old ISIC Rev3 codes.

BPS's [2012 WPI publication](https://www.bps.go.id/id/publication/2013/03/22/af3b79711e2402e2a41d15fb/indeks-harga-perdagangan-besar-indonesia-2012.html), publication06220.1301, has end-use indices on printed p81 (PDF page99). It distinguishes producers' materials from durable productive capital goods; domestic supply includes local and imported goods. The official downloaded PDF and six locally rendered price pages were inspected. The table below records the actual values; it does not certify each plant's asset mix or land prices.

The [2011 BPS WPI publication](https://www.bps.go.id/id/publication/2012/03/16/1d79de06a7fe0d8b4bf810fe/indeks-harga-perdagangan-besar-indonesia--2005-100--tahun-2011.html), publication06220.1201, has the corresponding end-use table on printed p81 (PDF page86). The [2010 BPS WPI publication](https://www.bps.go.id/id/publication/2011/04/11/e57f6bb767e8cb66dad37153/indeks-harga-perdagangan-besar-indonesia-2005-100-2010.html) has both2009 and2010 end-use tables: the correct2010 table is printed p83/PDF page87. Do not accidentally take its2009 table on printed p81.

All values below were checked against text and visible table cells in the **official downloaded PDFs**, rather than relying only on search snippets. The annual values are the published annual averages. All three publications use2005=100; no splice, interpolation, extrapolation or invented2016 observation is needed.

| Year | `P_Y_annual`: sector3, manufacturing | `P_M_annual`: domestic supply1, producers' materials | `P_K_annual`: domestic supply3, capital goods | `P_K_December`: same capital-goods row, December |
|---|---:|---:|---:|---:|
| 2010 | 172.01 | 178.70 | 153.33 | 155.97 |
| 2011 | 180.32 | 190.65 | 156.70 | 158.02 |
| 2012 | 187.48 | 199.48 | 159.22 | 160.40 |

Output indices are on printed p5 in every publication (PDF pages16/17/23 respectively). End-use indices are on PDF pages87/86/99 respectively. Materials and investment use annual prices; year-end stock uses the same year's December price before lagging. Rebasing the indices to another common year is unnecessary.

| Official downloaded source | Bytes | SHA-256 |
|---|---:|---|
| `/tmp/g1-v3-public-annual-source-audit/WPI2010.pdf` | 1,174,243 | `3d462f7a88f7610f3314da5d555825a8d0e971a4726ee4510d41d8579ffc9ba8` |
| `/tmp/g1-v3-public-annual-source-audit/WPI2011.pdf` | 4,705,429 | `8647854d49c9244a0043b43284e000c918ffe9a46fecbb2393e3059900d4fd7e` |
| `/tmp/g1-v3-public-annual-source-audit/WPI2012.pdf` | 949,095 | `4d0df6b6e50ac57efb5fe0fb1d7e0187a357307fe00921faee901700f3986e94` |

The three source-publication links above identify the annual release. Downloads were from their observed `web-api.bps.go.id/download.php` endpoints; the final2012 hash belongs to the official download, not the initially inspected Neliti mirror. Poppler `pdftotext -layout` extracted the tables; `pdftoppm` rendered exactly the six cited pages at110dpi, and this reviewer visually inspected all six. Their table year,2005base, row titles, annual output/materials/capital and December-capital cells agree with the table. Browser screenshots and some HTML fetches had failed earlier; those failures were resolved by official PDF download and local inspection. No price extraction or visual-verification gap remains for these12cells. Temporary receipts are handed to the parent for any permanent reference registration; no reference file outside this report was written to the worktree by this reviewer.

Candidate explicitly approximate construction, after those receipts: materials `val_rtlvcu/(P_materials_annual/100)`; gross investment flow `capital_additions_nominal/(P_capital_annual/100)` only if its asset perimeter is accepted for that price approximation; end stock `K_end/(P_K_December/100)` then lag to beginning capital. Single-deflated reported VA `value_added_nominal/(P_output/100)` must say **single-output-deflator VA approximation**; it is not double-deflated VA. A true double-deflation construction needs distinct output and all intermediate-input components and price mappings; RTLVCU alone omits energy/services and cannot replace total IINPUT in `Y_real-X_real`.

The [2024 BPS WPI publication description](https://www.bps.go.id/id/publication/2025/04/22/7e474af3513df453abc4a765/the-wholesale-price-indices-of-indonesia--2018-100--2024.html) states that WPI since2020 excludes imported/exported goods. Thus a continuation of a pre2020 domestic-supply index across this break requires explicit treatment of changed coverage and base; it cannot silently price imported materials using a domestic-only basket. A national expenditure/GFCF deflator or capital-goods WPI is a possible broad approximation, not an observed plant asset deflator; a regional GFCF index found for one district is not a national substitute.

**Unresolved primary evidence:** product-specific monetary units, annual industry classification edition and bridge, accepted VA deflation rule, price/asset perimeter for capital (including land or a coherently derived exclusion), appropriate investment price/perimeter, all-component intermediate-input price mapping if that proxy is selected, and substantive timing/proxy restrictions. No wage deflator is required merely to log a headcount labor input. Keep original source unknowns separate from nominal development conventions.

## G2 version compatibility

Live GitHub issue/PR inspection on13September2026 found issue10 open with no new comments and PR3 (`g2/word-row-pr-20260910`, head `55166acf50a1bdb7a3ed9585944ffcb43edaf32f`) still the old 1,200-observation/100-fictional-ID fixture audit, input hash `ebded0518f4ccbcbbe8da980a716ca797953d0d1f4fe83e5285dfd9a7ff8489e`. No current v3 G2 eligibility receipt was located. Do not merge its company-level eligibility onto v3 or report same-version G1/G2 integration. [Issue10](https://github.com/natanaelwgm/deasy-imed-si-research-2026/issues/10), [PR3](https://github.com/natanaelwgm/deasy-imed-si-research-2026/pull/3).

G1 may execute its explicitly declared local positive/source-quality domain while describing G2 integration as pending; that does not retroactively certify G2 acceptance. Current [issue9](https://github.com/natanaelwgm/deasy-imed-si-research-2026/issues/9) names v3 and authorizes fictional IDs; its other economic prerequisites remain distinct from REAL linkage.

## Review status

The bounded source audit is complete. Nominal and approximate-real development specifications are supported as declared sensitivities; no claim of positive final support, rank, convergence, bootstrap completion, primary real-input admission or G1 completion is made here. The parent must compute full-wave and each technology-pool support on current v3 and preserve all failed/unsupported methods. No extension beyond2010–2012 is recommended by this audit. Targeted2013/2014 source searches found an official2013 Kaltim summary publication with no capital questionnaire/date and an official2014 landing page whose PDF was not retrieved; neither upgrades the exact annual stock receipt. Research was bounded at the parent's request after the early-year specification became concrete.

## Registered approximate-real DEVELOPMENT specification proposal

Suggested specification ID: `G1_DEV_APPROX_REAL_NONLAND_2010_2012_V1`. This must be registered separately from both the nominal branch and accepted-real primary. Use a method API mode such as `approximate_real_development`; a real-source acceptance bit is not a substitute for that explicit mode. Input hash, source hashes, price-table hash, sector, source domain, estimated dynamic sample, normalization and measurement mode must accompany every result.

**Asset construction uses only current G0.5 fields.** For stock year`s` in2010–2012:

`K_nonland_end_nominal(s) = parse(raw_v1103) + parse(raw_v1106) + parse(raw_v1109) + parse(raw_v1112)`.

These are buildings, machinery/equipment, vehicles and other fixed assets; land `raw_v1101` is excluded. All four raw fields have `action=preserve` in G0.5 column-policy, so they share the raw monetary convention. Do not combine these with the jittered derived total, estimate a jitter factor, fill missing components with zero or subtract land from an incoherent total. Use the existing documented annual numeric parser or an equivalently explicit strict parser; count blank, source-absent and parse-failed fields separately. Require all components finite and nonnegative, and their sum strictly positive for logs. A raw-total identity diagnostic can be recorded separately without forcing reconciliation. Source-year binding is mandatory despite the yearless raw V-codes.

For the OP gross investment proxy, use the same nonland perimeter, with the suffix belonging to the exact source year:

| Year | Nonland gross additions operands |
|---|---|
| 2010 | `raw_cbttcu10 + raw_cmttcu10 + raw_cvttcu10 + raw_cottcu10` |
| 2011 | `raw_cbttcu11 + raw_cmttcu11 + raw_cvttcu11 + raw_cottcu11` |
| 2012 | `raw_cbttcu12 + raw_cmttcu12 + raw_cvttcu12 + raw_cottcu12` |

Parse each operand separately, require complete finite nonnegative components and a positive total, and do not subtract sales or treat missing expenditure aszero. These are gross additions/construction/major repairs. The same annual questionnaire/legacy-layout evidence that distinguishes CTTTCU from stock identifies these component rows. Current coverage confirms the fields exist; nonempty strings in2010/2011/2012 number2,304/2,257/2,193 per component. Those counts are not counts of positive or successfully parsed investment. No support pass is inferred from them.

The explicit transformations are:

`VA_single_deflated(t) = value_added_nominal(t) / (P_Y_annual(t)/100)`;

`M_broad_deflated(t) = val_rtlvcu(t) / (P_M_annual(t)/100)`;

`K_nonland_end_deflated(s) = K_nonland_end_nominal(s) / (P_K_December(s)/100)`;

`K_nonland_begin_deflated(t) = K_nonland_end_deflated(t-1)` using the same synthetic firm and actual one-year lag;

`I_nonland_broad_deflated(t) = I_nonland_gross_nominal(t) / (P_K_annual(t)/100)`.

Use logs of the positive quantities and unchanged positive `workers`. Keep 2010 source rows, permit production2011–2012, form dynamic year2012, and retain the simulated-selection interval conventions above with the transformed lagged K/I covariates. Report VA as a **single-deflated nominal-VA approximation**, M as **broad-price-deflated raw/supporting materials**, K as a **broad-price-deflated nonland asset-value proxy**, and I as **broad-price-deflated nonland gross additions**. Suggested common outcome label: `development_structural_log_single_deflated_VA_residual`; it contains transitory, price and measurement components and is not final empirical TFP.

**Why this is scientifically usable for the stated task:** it removes an explicit observed common price movement from three distinct economic classes, keeps the stock/flow and beginning/end timing distinctions, excludes land coherently, uses the authorized source package and does not fabricate quantities. It makes execution and sensitivity to a declared price convention reviewable. Separate technology pools and positive/complete domains remain essential; changing prices does not create additional source observations or justify pooling industries for sample size.

**What it assumes:** reported candidate currency units are common and positive across the declared years within each monetary family; the broad manufacturing WPI approximates prices implicit in reported VA; the producers' materials basket approximates the plant's raw/supporting material purchases; the capital-goods WPI approximates changes in the value of the heterogeneous nonland stock and additions. The last assumption is particularly coarse for buildings and major repairs; the index is not a building replacement-cost or asset-specific price receipt. No capital-service series, depreciation, capacity-utilization adjustment, double-deflated VA or plant-specific relative prices are inferred. A narrower machinery-only alternative would change the production capital perimeter and require a separately named model rather than being slipped into this specification. Real quantities and economically valid panel dynamics are not established by the numerical deflation.

**Release judgment:** proceed with this explicitly approximate development sensitivity if the parent registers these assumptions and actual field-parsing/domain receipts first. Preserve unknown supplier/annual mapping gates for the primary. If individual methods fail support, rank or convergence, report their real failures; the science verdict authorizes a defensible attempted specification, not a promised coefficient or completed primary result.
