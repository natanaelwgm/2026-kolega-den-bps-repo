#!/usr/bin/env python3
"""Expose publication-standard nominal figures through the analytical release aliases."""
# WFDOC: Wrapper menyerahkan gambar nominal ke builder publikasi lalu membuat alias analitis untuk enam pasang SVG/PNG.
from pathlib import Path
import json
import os
import shutil
import subprocess
import sys

HERE=Path(__file__).resolve().parent


def main(run):
    env=dict(os.environ,OPENBLAS_NUM_THREADS='1',OMP_NUM_THREADS='1')
    # WFDOC: Builder membaca CSV hasil Stata dan menulis figur serta provenance; wrapper tidak mengestimasi ulang atau mengubah angka.
    subprocess.run([sys.executable,str(HERE/'publication/plot_figures.py'),'--results',str(run)],check=True,env=env)
    # WFDOC: Alias dipakai pipeline rilis; manifest dan trace anotasi lengkap ikut disalin ke QA run.
    aliases={'sample_support':'nominal_sample_support','coefficients':'nominal_coefficients','distribution':'nominal_residual_distribution','rank_comparison':'nominal_rank_comparison','rank_scatter':'nominal_rank_scatter','sensitivity':'nominal_sensitivity'}
    for source,target in aliases.items():
        for ext in ['svg','png']:
            shutil.copy2(HERE/f'publication/figures/{source}.{ext}',run/f'figures/{target}.{ext}')
    manifest=json.loads((HERE/'publication/provenance/figure-manifest.json').read_text())
    manifest['analytical_release_aliases']=aliases
    (run/'qa/nominal-plot-data-manifest.json').write_text(json.dumps(manifest,indent=2)+'\n')
    shutil.copy2(HERE/'publication/provenance/figure-annotations.json',run/'qa/nominal-figure-annotations.json')
    print(f'Published {len(aliases)} paper-standard chart pairs and complete numeric annotation trace')


if __name__=='__main__': main(Path(sys.argv[1]).resolve())
