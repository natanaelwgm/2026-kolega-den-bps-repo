# G1_S18 — decision

G0.5 DEVELOPMENT — perturbed data; not final empirical findings

**Keputusan saat ini.** Long prediction key: obs_id × method × sample_id × specification_id × normalization_id; validate uniqueness before alias-controlled reshape. Merge the unique wide derivative 1:1 on obs_id, preserve all 33,049 input observations and all originals, keep unsupported values missing. psid is a model prerequisite, never an attachment key substitute. Publish aggregate receipts; keep record-level derivatives private/local.

**Grain dan key.** frozen observation; `obs_id`.

**Penyebut.** All 33,049 frozen G0.5 observations; year cells use their complete observed source-year count. No survey weights or population expansion.

**Unit.** {"TFP_residual_and_centering_constant": "natural-log points; not computed while input gates fail", "correlations": "dimensionless; undefined without supported predictions", "coverage": "observation count and percent of explicitly named denominator", "original_input_columns": "unchanged source units; see variable registry"}

**Waktu.** 2010–2015, 2017–2022; 2016 absent.

**Missing dan keluaran.** Keep source absence, unknown definition/unit, parse failure, observed zero/negative and valid positive states distinct. Unsupported statistical values stay missing, never zero. A validated numerical state and a typed unsupported receipt are distinct output types. A receipt cannot be consumed as the numerical state required by another estimator edge.

**Bukti.** Rencana `releases/2026-09-13-data-foundation/stata-preparation/row-plans/G1.json` SHA256 `dd88cfa94af5f212a7b0a4b70f99fea1c0201f950cd19333357739b96b5da1ca`; manifest G0.5 SHA256 `060b0ee0a2158a9c94b0e7e68fcfba719eda37561422855471a99da6810ba260`. Rincian asli dan kontrak efektif: [contract.json](contract.json).

**Aturan pembukaan kembali.** Perubahan hash input/kode/keputusan, bukti sumber baru, pemeriksaan gagal, atau instruksi pemilik.

**Teks keputusan rencana asli, dipertahankan.** Assert predictions on source_year/source_row/method/sample_id/specification_id and normalization_id, then reshape under a saved column-alias registry. The four primary raw-log aliases tfp_OP/tfp_LP/tfp_ACF/tfp_W refer to each method-specific eligible sample, degree-3 primary specification and its accepted default optimizer. Save mean-centered companions separately and keep common-sample, degree-2 and numerical alternatives in explicitly suffixed columns and the original long prediction table. Merge only the resulting unique wide table 1:1 on source_year/source_row into accepted G0; keep all original rows and unsupported predictions missing. Real firm ID is a verified model prerequisite, not a substitute for source lineage.
