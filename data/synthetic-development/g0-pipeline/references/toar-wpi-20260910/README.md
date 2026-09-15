# WPI Output Deflator — Indonesian Manufacturing, 2000–2022

Wholesale Price Index deflators at the 4-digit ISIC level, **base 2000 = 100**, for
deflating nominal output in the Indonesian Industrial Survey (Statistik Industri / IBS).

Built by extending `wpio.dta` (which ends in 2012) forward using BPS *Indeks Harga
Perdagangan Besar* (IHPB) publications.

---

## 1. Which file should I use?

| If you need… | Use | Why |
|---|---|---|
| **Deflators through 2019** | `data/wpio_extended_2000_2019.dta` | **Recommended default.** Every year natively chain-linked on one consistent base. No splice. |
| Deflators through 2022 | `data/wpio_extended_2000_2022.dta` | Same file plus 2020–22, which are **spliced** across a BPS base change. Levels ±a few percent. |
| To read outside Stata | the matching `.csv` | Identical content. `_long.csv` is one row per `isic × year` — easier to merge. |

The two `.dta` files are **identical on all shared years** (1983–2019, verified: maximum
absolute difference 0.0). The 2022 file only adds columns.

> **The current SI analysis panel runs 2000–2014.** Either file covers that with room to
> spare. The 2022 file matters only if firm-level data for 2015+ is added later.

---

## 2. What's in the data

| Variable | Description |
|---|---|
| `isic` | 4-digit ISIC Rev. 3 / KBLI 2000 manufacturing code (131 codes, 1511–3720) |
| `wpi1983` … `wpi2022` | WPI deflator for that year, base 2000 = 100 |

131 rows. `wpi2000 = 100` for every code by construction — the do-file asserts this and
halts if it doesn't hold. (Stored as `double`; 111 of 131 codes are bit-exactly 100 and the
rest differ in the last bit, max deviation 1.4×10⁻¹⁴. This is inherited from `wpio.dta`'s
own storage, not introduced here. Use a tolerance, not `==`, if you test it.)

**`wpi2016` is missing for all 131 codes.** No BPS IHPB 2016 publication was available.
The gap is held uniform across every code rather than being filled for some and not others.

### Deflator path (median across the 131 codes)

| 2000 | 2010 | 2015 | 2019 | 2020 | 2021 | 2022 |
|---|---|---|---|---|---|---|
| 100.0 | 224.1 | 279.3 | 306.1 | 313.9 | 321.3 | 327.1 |

*(2020 onward from the 2022 file; those years are spliced — see §5.)*

---

## 3. How to use it downstream

The deflator is stored at **ISIC4** level but is applied at **ISIC3**, following
Narjoko & Hill (2007) and Aswicahyono, Hill & Narjoko (2010). This is the pattern already
used in `16_energy_intensity.do`:

```stata
* 1. collapse ISIC4 -> ISIC3 and reshape to a year lookup
use "wpio_extended_2000_2019.dta", clear
gen isic3 = floor(isic / 10)
reshape long wpi, i(isic) j(year)
collapse (mean) wpi, by(isic3 year)
keep if inrange(year, 2000, 2019)
tempfile wpi_lookup
save `wpi_lookup'

* 2. merge onto firm data and deflate
use "si_energy_emissions.dta", clear
merge m:1 isic3 year using `wpi_lookup', keep(master match) nogen

gen double output_real   = output / (wpi / 100)      // 2000 Rp000
gen double ei_gj_real    = total_gj_s1 / output_real
gen double ln_ei_gj_real = ln(ei_gj_real)
```

This yields **67 ISIC3 groups × 23 years = 1,541 cells**, with only 2016 missing.
ISIC3 range is 151–372 (manufacturing). Non-manufacturing firm-years get `wpi = .` and
therefore `output_real = .`; they drop out of log-scale intensity outcomes.

**Only deflate the denominator.** Monetary intensity (expenditure ÷ output) has nominal Rp
on both sides, so any deflator cancels exactly. Physical intensity (GJ or tCO₂e ÷ output)
has a unit-free numerator and *does* need the deflated denominator.

---

## 4. Sources and method

### Stage 1 — 1983–2012 (unchanged)

Taken directly from `wpio.dta`: WPI indices at 4-digit ISIC, base 2000 = 100, for 131
manufacturing codes. Originally derived from BPS IHPB publications following
**Imbruno & Ketterer (2018)**, *Journal of Development Economics*.

### Stage 2 — 2013–2019 (native chain-link)

Chain-linked off the 2010 anchor using BPS IHPB annual averages on the **(2010 = 100)** base:

```
wpi_t = wpi2010 × (IHPB_t / 100)
```

where `IHPB_t` is the annual average of the ISIC4 code's corresponding IHPB manufacturing
sub-sector. Where two sub-sectors jointly represent one ISIC4 group, their arithmetic mean
is used — consistent with the original `wpio.dta` construction, which already assigned a
single WPI series to those codes.

**ISIC 3710 / 3720 (Recycling)** have no IHPB sub-sector. They are extrapolated from the
2010–2012 CAGR, as in the original pipeline. Under 0.5% of firm-years.

### Stage 3 — 2020–2022 (spliced; 2022 file only)

See §5.

### Source publications

| Year | Base | File | Extraction |
|---|---|---|---|
| 2013 | 2010=100 | `indeks-harga-perdagangan-besar-indonesia-2013-…xlsx` | Direct cell read |
| 2014 | 2010=100 | `indeks-harga-perdagangan-besar-indonesia-2014-…xlsx` | Direct cell read |
| 2015 | 2010=100 | `ihpb2015.pdf` | LLM vision — no text layer (pure scan) |
| 2016 | — | **not available** | — |
| 2017 | 2010=100 | `ihpb2017.pdf` | PDF text layer; p6 by vision (rotated page) |
| 2018 | 2010=100 | `ihpb2018.pdf` | PDF text layer; subs 8/16/17 by vision (see §6) |
| 2019 | 2010=100 | `ihpb2019.pdf` | PDF text layer |
| 2020 | **2018=100** | `ihpb2020.pdf` | PDF text layer |
| 2021 | **2018=100** | `ihpb2021.pdf` | PDF text layer |
| 2022 | **2018=100** | `ihpb2022.pdf` | PDF text layer |

The BPS watermark injects oversized `Helvetica-Bold` glyphs *inside* digits
(e.g. `221.11` → `2.21.11`). Extraction filters characters to ≤12 pt to remove it.
Anyone re-extracting these PDFs will hit this.

---

## 5. The 2020–2022 splice — read before using the 2022 file

BPS changed **two things at once** starting with the 2020 edition:

1. **Rebased** the index from (2010 = 100) to (2018 = 100).
2. **Renumbered and redefined** the sub-sectors — from 50 groups to **57**. Only
   sub-sectors 1–13 keep their meaning; 37 of 50 numbers refer to a different industry.
   Eight groups are new: 14, 21, 35, 42, 44, 49, 55, 57.

So 2020–2022 cannot be chain-linked with the same formula. They are brought onto the
(2010 = 100) scale by a link factor anchored on **December 2019**, which is observable on
both bases:

- on (2010 = 100) — published directly in the 2019 edition;
- on (2018 = 100) — back-solved from the 2020 edition's `Perubahan / Change (%)` column,
  which that edition's own footnote defines as *"Persentase perubahan IHPB Januari 2020
  terhadap IHPB Desember 2019"* (Jan-2020 vs Dec-2019).

```
f_sub = IHPB_Dec2019(2010=100) / IHPB_Dec2019(2018=100)
IHPB_t(2010-equivalent) = IHPB_t(2018=100) × f_sub        t = 2020, 2021, 2022
```

Results are expressed back in **2010-base sub-sector numbers**, which means
`ihpb_isic4_concordance.csv` is reused **completely unchanged** — no ISIC4 remapping and no
second semantic match layered on the original one.

Every link factor is tabulated in `source/ihpb_annual_averages_2013_2022_clean.xlsx`,
sheet **`splice_2020_2022`**.

### How accurate is the splice?

The two index definitions do not agree exactly — different baskets and weights. This was
measured on the 13 sub-sectors whose number means the same industry on both bases, so no
crosswalk error is involved:

| Divergence of `f` from its theoretical value | |
|---|---|
| Median | **0.91%** |
| Mean | 1.62% |
| Maximum | 5.48% |

**This is the floor for any splice between these two series.** Better sub-sector matching
would not reduce it.

Practical implications:

- Treat 2020–2022 **levels** as ±a few percent. Prefer 2000–2019 for anything level-sensitive.
- In a **DiD with year fixed effects the splice error is fully absorbed** and does not bias
  the treatment coefficient — year FE take out anything constant within a calendar year.
- There is **no visible seam**: the 2019→2020 deflator ratio (median 1.015) is *smaller*
  than a normal within-regime year (2021→2022, median 1.038), consistent with COVID-year
  low inflation rather than a splice artifact.

### One code affected by an unmapped sub-sector

2010-base sub 36, *"Industri Media Magnetik dan Media Optik"*, has **no** 2018-base
counterpart. It is used only as the *secondary* of the avg-of-two pair for **ISIC 3210**.
For 2020–2022 that code therefore falls back to its primary (sub 33) alone. All other
codes are unaffected. The do-file does this automatically and logs it.

---

## 6. Validation

### Extraction

Every IHPB row was checked by recomputing the annual average from its own 12 monthly
indices and comparing to the printed *Rata2 / Rata-rata* value (tolerance 0.05).

- **2010=100 block:** 300/300 rows verified (50 sub-sectors × 6 years).
- **2018=100 block:** 171/171 rows verified (57 sub-sectors × 3 years).

This check caught **three real errors in 2018** (sub-sectors 8, 16, 17) where the PDF text
layer silently dropped the Average token and the parser picked up December instead — errors
of 3–6 index points. Those rows were re-read visually and corrected.

### Deflator construction

Independently recomputed outside Stata:

- 2019 file: **774/774** chain-linked values reproduced exactly.
- 2022 file: **1,161/1,161** values reproduced exactly.
- CAGR path for ISIC 3710/3720 verified.
- `wpi2000 == 100` for all 131 codes.
- No seam at the 2012→2013 join (median ratio 1.025 — ordinary ~2.5% inflation).
- Downstream ISIC3 collapse yields exactly the expected 67 × n-years cells.

Full run logs in `logs/`.

---

## 7. Known limitations

1. **2016 is missing.** Sourcing the BPS IHPB 2016 edition closes it — add `2016` to the
   `YEARS` local in the do-file and re-run. One-line change.
2. **2020–2022 are spliced, not native.** ±a few percent on levels. See §5.
3. **Do not extend past 2022 with this method.** Verify whether IHPB (2018=100) continued
   beyond 2022 and whether BPS rebased again or moved to the Producer Price Index (IHPr).
4. **The concordance is ISIC Rev. 3 / KBLI 2000.** If SI/IBS microdata for 2015+ is added,
   it will be KBLI 2015/2020 coded (ISIC Rev. 4 lineage). Rev.3 → Rev.4 is **not** a clean
   1:1 remap in manufacturing, and the original concordance was built by semantic matching
   with no official BPS crosswalk. Budget real time for this — it is the expensive
   dependency, not the deflator.
5. **The concordance rests on semantic matching.** BPS publishes no official crosswalk
   between IHPB sub-sector labels and ISIC codes. Each ISIC4 code was assigned to the
   sub-sector whose description most closely corresponds in meaning. Inspect
   `source/ihpb_isic4_concordance.csv` (columns `isic4_description` and `notes`) to judge
   individual matches.

---

## 8. File inventory

```
WPI_deflator_package/
├── README.md                                  this document
├── data/
│   ├── wpio_extended_2000_2019.dta            RECOMMENDED — native chain-link only
│   ├── wpio_extended_2000_2019.csv              same, wide
│   ├── wpio_extended_2000_2019_long.csv         same, one row per isic x year
│   ├── wpio_extended_2000_2022.dta            adds spliced 2020-2022
│   ├── wpio_extended_2000_2022.csv
│   └── wpio_extended_2000_2022_long.csv
├── source/
│   ├── ihpb_isic4_concordance.csv             131 ISIC4 -> IHPB sub-sector
│   ├── ihpb_annual_averages_2013_2019.csv     lookup, 2010=100, native years
│   ├── ihpb_annual_averages_2013_2022.csv     lookup incl. spliced 2020-2022
│   └── ihpb_annual_averages_2013_2022_clean.xlsx
│                                              full IHPB extract + audit trail:
│                                                annual_long, wide_2010base,
│                                                wide_2018base (57 groups),
│                                                monthly_long (all 12 months),
│                                                subsector_map, splice_2020_2022
├── dofiles/
│   ├── 15b_extend_wpio_2019.do                builds the 2019 file
│   └── 15c_extend_wpio_2022.do                builds the 2022 file
└── logs/
    ├── 15b_extend_wpio_2019.log               full Stata run logs
    ├── 15c_extend_wpio_2022.log
    ├── wpi_extension_qa.csv                   per-year mean/min/max
    └── wpi_extension_qa_2022.csv
```

### Reproducing from scratch

Requires `wpio.dta` (not redistributed here — 131 × 31, base 2000=100, 1983–2012).

```stata
* place wpio.dta in            <root>/data/raw/
* place the two source CSVs in <root>/data/concordance/
global handoff "<root>"
do "<root>/dofiles/15c_extend_wpio_2022.do"
```

Both do-files derive every path from `$handoff` and create `output/` and `logs/`
themselves. They assert on base year, concordance coverage, and per-year completeness, so
a wrong input file fails loudly rather than silently.

---

## 9. References

- **Imbruno & Ketterer (2018)**, *Journal of Development Economics* — WPI deflator
  construction; monetary energy-intensity measure.
- **Narjoko & Hill (2007)**; **Aswicahyono, Hill & Narjoko (2010)** — precedent for
  applying WPI deflators at the 3-digit ISIC level in the SI/IBS literature.
- **BPS**, *Indeks Harga Perdagangan Besar Indonesia*, annual editions 2013–2022.
