# Working together

Create a branch from `main` and open a pull request describing the analytical change, inputs used and validation performed. Keep actual and development data clearly distinguished. Do not relabel fictional panel links as real firm identities or nominal residuals as real TFP.

Use the master demo and per-year input mapping as the common entry point. Preserve accepted inputs and outputs; create a new run folder for each experiment. Put large datasets/results into a versioned private release with SHA-256 hashes and update the inventory rather than adding large binary files to Git. Do not commit local credentials, machine configuration or unrelated data.

For G0 mapping changes, report affected source years and columns. For G0.5 changes, report the fictional-ID algorithm and panel diagnostics. For G1 changes, report the sample, model, support exclusions, convergence and sensitivity/bootstrap settings. Include a short timestamped decision note in `agent-history/` when the change affects later work.
