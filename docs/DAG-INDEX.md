# Analytical DAGs

The current [preparation master](../20260917-run/block-0-data-preparation/00_run.do)
calls **clean data → obscure values → construct panel → estimate productivity**.
The [integrated execution overview](../downstream/dag/DAG.md#data-preparation-entry-points)
connects those steps to their output datasets. The
[source concordance](../20260917-run/block-0-data-preparation/documentation/SOURCE_CONCORDANCE.md)
maps them to the original local stages, including numeric obscuring before estimation.

The detailed module graphs and contracts below retain the original stage names.
They cover preparation and estimation; they do not imply completion of all 44
research work items. The integrated overview is a static graph; the detailed
source registries remain available separately.

| Module | Coverage | Open in GitHub |
|---|---|---|
| G0 | Complete frozen registry: 6,409 nodes and 3,369 edges; 17 execution stages | [Full DAG JSON](../releases/2026-09-13-data-foundation/stata-preparation/registry/dag.json), [stage order](../releases/2026-09-13-data-foundation/stata-preparation/registry/stages.json) |
| G0.5 | Source selection, scaling, clustering, fictional panel assignment and package validation, with per-node decisions and contracts | [Node records](../work-items/G0.5/dag/nodes/), [edge registry](../work-items/G0.5/dag/registries/edges.csv), [grain contracts](../work-items/G0.5/dag/registries/grain-contracts.json) |
| G1 | 37 nodes and 32 producing edges, including nominal N01–N07 and diagnostic N08–N13 stages; full direct dependencies retained | [Full diagram](../work-items/G1/dag/G1-full.svg), [readable diagram](../work-items/G1/dag/G1.svg), [contracts and explanation](../work-items/G1/dag/README.md) |

G0's complete JSON is a registry, not a ready-to-read visual chart; GitHub may offer Raw/Download for a large file. G0.5 currently has node/edge contracts rather than one rendered overview. G1 has both rendered diagrams and Mermaid/Graphviz sources. These graph files are on `main`, so downloading the large data release is not required to inspect them.

![G1 readable analytical DAG](../work-items/G1/dag/G1.svg)
