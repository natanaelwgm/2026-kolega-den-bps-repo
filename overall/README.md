# Overall raw-to-G1 pipeline

**Currently under full-run verification. Do not interpret code availability as a completed run.**

Open the repository-root `00_MASTER_OVERALL.do` in Stata 17+, with Stata's working directory set to the repository root. This is separate from the unchanged fast `demo/00_MASTER.do`.

The new master imports the 12 original annual Excel files through native Stata, executes all 17 G0 stages, creates G0 descriptive tables/workbook/charts, constructs a fresh perturbed G0.5 fictional panel from that run's G0 master, and invokes G1 E01–E19, nominal N01–N07, and diagnostic N08–N13. Sensitivity and 99-repetition bootstrap are enabled by default. Every actual child call is printed in Results; a failing stage stops the cascade.

`g0-source/` contains the complete original G0 code, with a source-migration ledger. The runtime copy rebinds paths into a NEW run directory and adds child-call banners. The annual working DTA files are generated from Excel; historical G0 outputs are retained only as comparison witnesses. Stata `cf` and the original schema/label validators compare the fresh results. Fresh G0.5 values and fictional links are rebuilt; the cached G0.5 master is not used as an analytical input.

Use `overall.local.do` (ignored by Git) to set OVERALL_OUTPUT, OVERALL_RAW_ZIP, OVERALL_WITNESS and OVERALL_PYTHON. OVERALL_WITNESS is the downloaded `g0-original` folder; it contains G0-rebuild and its frozen reference inputs. The raw ZIP contains the 17 accepted Excel/DBF source files. The existing mapping and comparison contract targets the accepted 12 survey waves; changing raw layouts, years or expected observations requires updating those contracts, not silently bypassing them.

Reserve at least 30 GiB for a fresh run. The current local verification uses the attached Extreme SSD. New output directories retain raw input hashes, rebuilt annual DTA, full G0 outputs, the new G0.5 DTA, G1 outputs, logs and completion receipts. The perturbation key stays in `.private/` outside Git. `OVERALL_COMPLETE.json` is written only after the chain and final checks succeed.
