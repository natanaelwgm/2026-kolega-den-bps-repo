# Current GPT Pro data instructions

Use [the G0.5 prompt](../../../data/g0-5-development/GPT-PRO-PROMPT.md) and `harness.data_source.load_data()` from the repository root. All development uses the perturbed G0.5 package by default. This folder's original actual-data manifest is historical parent evidence, not the current development input. Do not retrieve actual Git-history parts as a fallback. Finalisation explicitly selects the accepted local actual parent and reruns the same analysis code. Do not infer `psid` from `obs_id` or row order.
