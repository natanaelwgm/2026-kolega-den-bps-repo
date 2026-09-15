# Owner request — 13 September 2026

Verbatim request in the current Codex task:

> ok gw pengen bikin supaya data di github dibiki supaa ada ever so slightly ada disturbances nya dibki jadi bukan data actual .... bisa gak ? tolong bikin ada itu jadi tambahan kayak jadi G0.5 dimana dia kayak tugasnya buat bikin datnaya gak adata asli... nanti gpt pro dan semua downstream akan menggunakan data tsb buat ngap2in... tp nanti finalisasi nya akan pakai data asli tp kodenya dkk nya kan sama tinggal di translate aja jadi data yg asli gt? makes sense gak

Follow-up:

> btw juga soal pembuatan ID buat tiap data gmn? psid dkk ? treatmentnay gmn

## Interpretation and implementation choices

- Add G0.5 as an operational work item between actual G0 preparation and downstream development. Preserve all 44 original Word requests and their original PIC/numbering.
- Default GPT Pro and downstream development to a labelled perturbed derivative. Finalisation reruns the same analysis code on explicitly selected local actual inputs; numerical results are not translated back or relabelled.
- Agent-selected starting amplitude is 0.1–0.5% on mapped monetary/physical levels, with a coherent per-record factor. This amplitude was not separately specified by the owner.
- Categories, counts, dates/years, treatment indicators, nulls and dimensionless ratios are deliberately preserved. This is not fully synthetic data and does not establish anonymity. Keep the repository private.
- Original v1 interpretation: `obs_id` identifies one frozen G0 observation and `psid` was left missing. This interpretation failed the owner's intended fictional development requirement and is superseded by the correction below.
- Publication assumption stated in chat: G0.5 replaces the active actual package in the current `main` tree; an exact actual copy stays local. Previously committed actual data remain in Git history. No history rewrite is requested or performed.

The owner's question about IDs steers this same task; it does not cancel the requested G0.5 implementation and GitHub publication.

## Explicit correction and implementation authority, later on 13 September

The owner first requested an inspection of the original Excel geography/industry
fields and similarity matching across years. After that audit, he instructed:

> ok pakaikan provinsi x sector as coercive nya.. sisanya ambil variable continuous yg ada terus tiap tahun buat cluster id nya gak harus pekerja output dan input doang misal ada vairasi 5-10 variable yg consistent or breakdown dari mereka jg ok just do ur best

Implement compulsory province × sector boundaries, select nine consistently
available continuous fields, form annual similarity clusters, and assign stable
fictional firm IDs through optional one-to-one matching. New/unmatched records
remain in the unbalanced simulated panel. Matching inputs are the already
perturbed G0 mappings of the Excel fields, making the generator reproducible from
the GitHub package. The original Excel files are audited and preserved. Publish
annual development Excel views and full updated G0.5 wave parts. Actual identity
remains a separate empirical input; this correction authorizes fictional
development continuity, not a claim to recover actual firms or resume paused G1.

## Later correction: external workflow, G0 unchanged

The owner specified that G0.5 run outside G0, check whether G0 already accounts for a usable firm/PSID key, port existing identity when available, and generate identity otherwise. The identity preparation should be able to run first from Excel; G0 continues normally.

The final implementation is v3: `prepare_external_identity.py` → private spine → `port_external_identity.py` → `build_panel_package.py`. `external_workflow.py` coordinates these steps and reuses verified existing outputs. It never executes G0. Source-year/row, dimensions and nine original feature values bind the external spine back to the accepted G0. Frozen normalized ranks and HMAC observation tokens support GitHub-only replay; source row maps, keys and original levels remain local.

The intermediate v2 (matching after G0.5 perturbation) was validated locally but was not published. v3 supersedes it before publication, following this latest instruction.
