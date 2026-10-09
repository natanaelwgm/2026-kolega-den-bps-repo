# B2-04 — Who drove aggregate manufacturing decarbonisation?

## How to run

Same as every other block:

```stata
global B12_REPO "/absolute/path/to/2026-kolega-den-bps-repo"   // once per Stata session
do "$B12_REPO/20260917-run/block-b2-04-who-drove-decarbonisation/00_run.do"            // all files
do "$B12_REPO/20260917-run/block-b2-04-who-drove-decarbonisation/00_run.do" "" 06      // only file 06
do "$B12_REPO/20260917-run/block-b2-04-who-drove-decarbonisation/00_run.do" "" paths   // only set paths, then run any file by hand
```

No roster is needed. A full run takes about 5 seconds. Files 02-07 need 01a to have run once.

Results:
- `output/b2_04_tables.xlsx`: every table, 1 sheet = 1 table. Sheet names start with the to-do line number.
- `output/fig*.png`: charts. The exact points of each chart are in the sheet `figNN_data`.
- `data/b204_si.dta` (firm-year panel), `b204_decomp_total.dta` (lines 2-5), `b204_decomp_groups.dta` (line 6).
- `output/b2_04_log.log`: log. Every decomposition prints its continuers / entrants / exiters and the
  difference between the total change and the sum of the components.

Close the Excel file before running.

## One file per to-do line

| # | To-do line | File | Sheets | Status |
|---|---|---|---|---|
| 1 | Who drove aggregate manufacturing decarbonisation? Pakai FHK decomposition (2001) dan Melitz–Polanec (2015) | `01a_prep_si.do` | data prep → `data/b204_si.dta` | ⚠️ both methods run (in `_decompose.do`), but the firm links are fictional in the dev data |
| 2 | Accounting decomposition perubahan carbon intensity dan energy intensity menjadi: | `02-05_decomposition.do` + helper `_decompose.do` | t02_05_fhk, t02_05_mp, t02_05_summary, t02_05_firm_int | ✅ CO2/VA and GJ/VA, 2010-15, 2017-22, 2010-22 |
| 3 | Within firm improvement | (same file) | FHK `fhk_within`; MP `mp_mean` | ⚠️ needs real firm links |
| 4 | Reallocation toward cleaner firms | (same file) | FHK `fhk_between + fhk_cross`; MP `mp_cov` | ⚠️ needs real firm links |
| 5 | Entry/exit | (same file) | FHK `fhk_entry`, `fhk_exit`; MP `mp_entry`, `mp_exit` | ⚠️ needs real firm links |
| 6 | Dilakukan untuk total firms, sektor 2 digit, exporters/non exporters, domesitic/fdi, importers/non importers. | `06_by_group.do` | t06_fhk_by_group, t06_mp_by_group, t06_summary | ⚠️ all groups done; exporter groups end in 2021; 3 small sectors have no continuers, so no MP survivor terms |
| — | (no figures line; added) | `07_figures.do` (runs last) | fig02a, fig02b, fig06a, fig06b (PNG) + fig02a_data ... fig06b_data | ✅ |

## The method (details in the header of `_decompose.do`)

Aggregate intensity in year t: `I_t = Σ s_it · φ_it = total CO2 / total VA`, with φ = firm CO2/VA (or GJ/VA)
and s = the firm's share of VA. Firms are matched by `firm_id` × `year`: continuers (both years), entrants
(end year only), exiters (start year only).

- **FHK (2001)**: within = Σ_C s0·Δφ; between = Σ_C (φ0 − I0)·Δs; cross = Σ_C Δs·Δφ;
  entry = Σ_N s1·(φ1 − I0); exit = −Σ_X s0·(φ0 − I0).
- **Melitz-Polanec (2015)**: Δ(unweighted mean φ of survivors) + Δ(survivors' covariance
  Σ (s/S_C − 1/n)(φ − mean φ)) + S_N1·(I_N1 − I_C1) + S_X0·(I_C0 − I_X0).
- The to-do's three parts: within = FHK within / MP survivors' mean; reallocation = FHK between + cross /
  MP survivors' covariance; entry/exit = entry + exit.
- **Check**: the components of both methods must add up to `I_t1 − I_t0`. The difference is printed in the
  log and saved as `fhk_diff` / `mp_diff`. In the current run it is at most 2e-16 in absolute terms (intensities are ~1e-5 to 1e-4).

## Decisions

- Indicators: carbon intensity = CO2/VA and energy intensity = GJ/VA (same as B2-02), firms weighted by
  their VA share, so the aggregate equals total CO2 / total VA.
- Periods: 2010-2015 and 2017-2022 (each side of the questionnaire change) and 2010-2022.
  Line 6 uses 2010-2022 only (2010-2021 for exporter groups).
- Group membership is taken in each year: a firm that becomes an exporter exits the non-exporter group and
  enters the exporter group.
- A firm with no usable record (VA ≤ 0, missing emissions, or `clean = 0`) in one of the two years counts as
  an entrant/exiter for that comparison.
- FHK uses the start-year aggregate `I_t0` as the reference for entry and exit (the FHK convention).

## Gaps and notes

- **Firm links are fictional in the development data** (`panel_id_synthetic = 1`). Who is a continuer,
  entrant or exiter, and so every component, only means something on the real BPS data. The total change
  does not depend on the links. Example: only 604 firms are "continuers" from 2010 to 2022.
- Small groups have few continuers (FDI: 5, exporters: 11, several sectors 0-5). Check `n_continuers`.
  KBLI 11, 19 and 33 have no continuers 2010-2022, so their MP survivor terms are missing.
- VA is **nominal** and masked in the dev data: the intensities mix price and real change. Read signs and
  shares, not levels.
- Corrections copied from b1-18's `01a`: coal 2017 / 1000, FDI 2020 and exporter 2022 missing, 30 outliers
  (`clean = 0`) left out.

## Verified (9 Oct 2026)

- Full run, single-file run (`"" 07`) and `"" paths` + one file by hand: no errors.
- Aggregate intensities (all firms, 2010 → 2022):
  CO2/VA 2.6043e-5 → 2.7533e-5, GJ/VA 2.4519e-4 → 2.2293e-4.
