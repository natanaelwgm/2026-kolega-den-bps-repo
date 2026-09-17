# DAG: sumber yang sudah ada → dataset siap digunakan secara struktural

Controller: `downstream/00_MASTER.do`. Ini cabang baru dari hasil G0/G1 yang sudah
tersedia. Master tidak mengestimasi ulang G1 atau menjalankan ulang overall raw.

```mermaid
flowchart TD
  A["G0 analysis-ready actual\n33,049 source-record-years"] --> P["Pin hashes + source manifest"]
  B["G0.5 + G1 master\n33,049 development firm-years"] --> P
  C["G1 N06 original result sidecar"] --> V
  M["Field contract + variable/year evidence\n44 research plans"] --> P
  P --> X["01 project source → 02 identity → 03 features\nactual branch"]
  P --> Y["01 project source → 02 identity → 03 features\ndevelopment branch"]
  X --> AOUT["analysis_actual.dta\nUnlinked source-record-year; firm_id missing"]
  Y --> DOUT["panel_development.dta\nFictional firm_id × calendar year"]
  AOUT --> Q["04: exact source comparison + annual coverage"]
  DOUT --> Q
  B --> V["05: exact G1 N06 reconciliation"]
  Q --> Z["Python independent schema/key/count/hash checks"]
  V --> Z
  Z --> FINAL["COMPLETE.json + dictionaries + readiness.csv"]
```

Node = retained artifact, not a claim that each intermediate is a separate file.
Projection, identity and feature alignment are explicit native child do-files;
their intermediate state stays in the owned Stata session until export. Source
and final datasets, aggregate coverage states, native logs and receipts persist.
There is no join from actual records to development records.

The registry names each producing process, input/output state and grain.
`triage.md` and `decision.md` in each node record what is produced, verified and
still conditional. The complete inherited G0 DAG and G1 DAG remain in their
existing folders, linked through the source input contracts.


## Accepted masked-input branch — 17 September 2026

Owner-selected order: G0 → G0.25 → G0.5 → G1. The accepted G0 master is reused;
all following numerical/model stages ran locally. G0.5 adds only fictional panel
links, with no second numeric perturbation. G1 is freshly estimated from the
masked values. No post-estimation masking is applied.

```mermaid
flowchart LR
    G0_SOURCE --> ACTUAL
    ACTUAL --> G025_STAGE
    G025_STAGE --> G05_MASKED_PANEL
    G05_MASKED_PANEL --> G1_MASKED_ESTIMATION
    G1_MASKED_ESTIMATION -->|E063 final values| G1_FINAL_VALUES
    G1_FINAL_VALUES -->|E064 compile definitions| G1_LABEL_CONTRACT
    G1_FINAL_VALUES -->|E065 native Stata metadata| G1_LABELLED
    G1_LABEL_CONTRACT --> G1_LABELLED
    G1_LABELLED -->|E066 exact-data and metadata QA| MASKED_FINAL
    MASKED_FINAL -->|E067 metadata and optional analysis guide| DATA_GUIDE
    G1_LABEL_CONTRACT --> DATA_GUIDE
    G05_MASKED_PANEL -. if included .-> DATA_GUIDE
```

The detailed numeric masking subgraph remains MASK_BASE → MASK_DERIVED → MASK_IDS,
with MASK_QA and MASK_RECOVERY. G1 invokes E01–E19 and N01–N07 internally; their
native intermediate datasets remain in the run.

Acceptance: downstream/g025_to_g1/latest.json and RESULT.md. The earlier
G1.5-after-G1 proposal is superseded by this explicit owner direction.

## Terminal metadata finishing

The accepted masked-input runner `downstream/g025_to_g1/build.py` invokes E064-E066 automatically after numerical G1 publication and before the public final DTA is admitted. The standalone `downstream/metadata/finish.py` runs the same edges on an existing pinned final numerical parent. This stage changes metadata only; no refit is needed. The native edge is `downstream/dag/edges/E065_apply_variable_metadata.do`. See `downstream/metadata/README.md` for commands and validation.

E067 (`downstream/metadata/data_guide.py`) generates the final dataset README and `METADATA.json` from the validated delivered files. Dataset recommendations are advisory and never impose a sample/model or change data. The masked runner invokes it after packaging the optional G0.5 intermediate.
