# G0.5 analytical DAG

The [full external workflow](../../../harness/g05/EXTERNAL-WORKFLOW.md) can prepare
identity from Excel before G0 exists. The accepted G0 and measurement stages remain
unchanged. The private identity spine is attached later by proved source lineage.

```mermaid
flowchart TD
  X[G05_X00 Original Excel] --> D[G05_S04 Nine common features]
  D --> E[G05_S05 Year-sector ranks and weights]
  E --> F[G05_S06 Province-sector annual clusters]
  F --> G[G05_S07 Optional fictional company matching]
  A[G05_S00 Accepted G0] -. available ID candidates .-> Q[G05_S09 Inspect existing identity]
  X --> Q
  Q -->|usable existing identity| S[G05_S10 Private identity spine]
  G -->|no usable existing identity| S
  A --> B[G05_S01 Disturbed measurements]
  B --> C[G05_S02 Frozen observation IDs]
  S --> P[G05_S11 Verify lineage and port IDs]
  A --> P
  C --> P
  C --> H[G05_S08 Package and annual Excel views]
  P --> H
  H --> I[G05_S03 Shared adapter and publication]
```

Each row is retained. New metadata describes fictional development continuity;
actual finalisation clears it. Missing 2016 stays missing. Existing identity is an
explicit input when reused; it is not represented as newly generated matching.
Node triage/decision files and registries record keys, grain, evidence and reopen
conditions. Publication acceptance is recorded separately from local validation.
