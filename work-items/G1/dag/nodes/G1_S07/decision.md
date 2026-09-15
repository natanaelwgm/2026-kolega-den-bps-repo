# G1_S07 — decision

G0.5 DEVELOPMENT — perturbed data; not final empirical findings

**Keputusan saat ini.** ACF must be its own estimator, not renamed L Presidual.

**Grain dan key.** frozen observation × method × sample; `obs_id, method, sample_id`.

**Penyebut.** Unfiltered source candidates per method and verified technology/year. Report marginal exclusions against the fixed source denominator, sequential losses against the previous gate, and the four-method intersection once per obs_id.

**Unit.** {"source_monetary_candidates": "reported source units; measurement/unit admission remains unresolved, with no unverified conversion", "required_real_monetary_inputs": "constant-price Rp000 only after accepted source unit, deflator base and concept mapping", "labor": "canonical worker-count candidate; source definition/unit admission required", "time": "actual calendar year", "counts": "frozen source observations; no population weights", "eligibility": "Boolean plus distinct unknown states"}

**Waktu.** 2010–2015, 2017–2022; 2016 absent.

**Missing dan keluaran.** Keep source absence, unknown definition/unit, parse failure, observed zero/negative and valid positive states distinct. Unsupported statistical values stay missing, never zero. A validated numerical state and a typed unsupported receipt are distinct output types. A receipt cannot be consumed as the numerical state required by another estimator edge.

**Bukti.** Rencana `releases/2026-09-13-data-foundation/stata-preparation/row-plans/G1.json` SHA256 `dd88cfa94af5f212a7b0a4b70f99fea1c0201f950cd19333357739b96b5da1ca`; manifest G0.5 SHA256 `060b0ee0a2158a9c94b0e7e68fcfba719eda37561422855471a99da6810ba260`. Rincian asli dan kontrak efektif: [contract.json](contract.json).

**Aturan pembukaan kembali.** Perubahan hash input/kode/keputusan, bukti sumber baru, pemeriksaan gagal, atau instruksi pemilik.

**Teks keputusan rencana asli, dipertahankan.** ACF must be its own estimator, not renamed L Presidual.
