#!/usr/bin/env python3
"""E068: make a self-contained local block-0 data package, preserving DTA bytes."""
import argparse
import datetime
import json
import re
import shutil
from pathlib import Path
from data_guide import FINAL, PRIOR, write_data_guide
from compile_metadata import sha, write_json

ENTRY='analysis_ready_data.dta'

def package(source,target):
    source=Path(source).resolve();target=Path(target).resolve()
    if target.exists() and any(target.iterdir()):
        raise RuntimeError('Destination is not empty; choose a new snapshot folder')
    validation=json.loads((source/'metadata/VALIDATION.json').read_text())
    assert validation['status']=='PASS' and sha(source/FINAL)==validation['final_sha256']
    upstream_guide=json.loads((source/'metadata/DATA_GUIDE_VALIDATION.json').read_text())
    assert upstream_guide['status']=='PASS'
    # Explicit allow-list: no owner-only folder, originals, seed or recovery archive.
    files=[(source/FINAL,Path(ENTRY)),(source/'LINEAGE.json',Path('LINEAGE.json'))]
    for folder in ['metadata','masking-reports']:
        files += [(p,Path(folder)/p.name) for p in (source/folder).iterdir()
                  if p.is_file() and not p.name.startswith('._')]
    if (source/PRIOR).exists():files.append((source/PRIOR,Path(PRIOR)))
    files += [(source/name,Path('provenance/upstream')/name) for name in ['README.md','METADATA.json']]
    parent=target.parent
    while not parent.exists():parent=parent.parent
    required=sum(p.stat().st_size for p,_ in files)+20*1024**2
    free=shutil.disk_usage(parent).free
    if free<required:raise RuntimeError(f'Need {required} free bytes for this bounded copy; available {free}')
    target.mkdir(parents=True,exist_ok=True)
    source_hashes={str(rel):sha(p) for p,rel in files}
    for p,rel in files:
        dest=target/rel;dest.parent.mkdir(parents=True,exist_ok=True)
        shutil.copyfile(p,dest)
        assert sha(dest)==source_hashes[str(rel)]
    # Keep the old guide receipt as provenance, then generate a coherent guide
    # whose entry filename is the name explicitly requested for this block.
    shutil.copyfile(target/'metadata/DATA_GUIDE_VALIDATION.json',target/'provenance/upstream/DATA_GUIDE_VALIDATION.json')
    guide=write_data_guide(target,final_name=ENTRY)
    readme=target/'README.md'
    contents=readme.read_text().replace('# Data final G0–G1: titik awal analisis','# Block 0 — Data preparation: OBSCURED analysis-ready data',1)
    contents=contents.replace('## File mana untuk apa?', '''## Isi block ini

- `analysis_ready_data.dta`: dataset final **OBSCURED**, lengkap dengan hasil G1 dan 516 label/notes.
- `README.md` dan `METADATA.json`: panduan analisis opsional dan metadata dataset.
- `metadata/`: dictionary, codebook, do-file label/notes dan hasil validasi.
- `intermediate/`: input panel obscured sebelum G1 untuk percobaan estimasi baru.
- `masking-reports/`: aturan perubahan angka, identitas fiktif dan pemeriksaan terkait.
- `provenance/upstream/`: dokumentasi sumber sebelum file final diberi nama paket ini.
- `LINEAGE.json` dan `PACKAGE.json`: rantai versi, hash dan bukti penyalinan.
- `00_OPEN_DATA.do`: pembuka data; jalankan setelah working directory Stata diarahkan ke folder block ini.

**Nama file dibuat ringkas sesuai permintaan; seluruh angka di file ini tetap versi
OBSCURED.** Penggantian nama tidak menjadikannya data aktual. Bytes DTA identik
dengan final G1 obscured yang telah diverifikasi.

Paket ini sudah tersedia lengkap di checkout lokal. DTA mengikuti kebijakan repo
sebagai artefak data di luar Git source; snapshot tanggal ini belum diunggah sebagai
rilis GitHub. Manifest tetap mencatat nama, ukuran dan hash untuk publikasi berikutnya.

## File mana untuk apa?''',1)
    readme.write_text(contents)
    # README gains package-specific orientation, so bind its final hash explicitly.
    guide['files']['README.md']=sha(readme)
    guide['packaged_entry_filename']=ENTRY
    write_json(target/'metadata/DATA_GUIDE_VALIDATION.json',guide)
    (target/'00_OPEN_DATA.do').write_text('''version 17
set more off
set varabbrev off
* Run from this block folder, or provide the block folder as an argument.
args block_dir
if `"`block_dir'"'!="" cd `"`block_dir'"'
capture confirm file "analysis_ready_data.dta"
if _rc {
    display as error "Set cd to 20260917-run/block-0-data-preparation first."
    exit 601
}
use "analysis_ready_data.dta", clear
isid obs_id
isid firm_id year
xtset firm_id year
display as result "OBSCURED DEVELOPMENT DATA: fictional company IDs; nominal G1 residuals"
describe workers value_added_nominal dev_nominal_tfp_lp
notes dev_nominal_tfp_lp
browse
''')
    meta_path=target/'METADATA.json';meta=json.loads(meta_path.read_text())
    meta['package']=dict(name=target.name,entry_file=ENTRY,data_classification='OBSCURED',
        original_filename=FINAL,filename_change_only=True,publication_status='local_snapshot_not_uploaded',
        data_storage='DTA present locally; Git source ignores DTA; release upload deferred')
    write_json(meta_path,meta)
    guide['files']['METADATA.json']=sha(meta_path)
    write_json(target/'metadata/DATA_GUIDE_VALIDATION.json',guide)
    for link in re.findall(r'\]\(([^)]+)\)',contents):assert (target/link).exists(),link
    assert meta['recommended_entry_file']==ENTRY
    assert meta['recommendations_are_binding'] is False
    assert sha(target/ENTRY)==validation['final_sha256']
    assert all(sha(source/path)==rec['sha256'] for path,rec in
               [(r['file'],r) for r in json.loads((source/'METADATA.json').read_text())['dataset_catalogue']])
    inventory=[dict(file=str(p.relative_to(target)),bytes=p.stat().st_size,sha256=sha(p))
               for p in sorted(target.rglob('*')) if p.is_file() and not p.name.startswith('._')]
    receipt=dict(status='PASS',edge='E068',created_at=datetime.datetime.now().astimezone().isoformat(),
        block='20260917-run/block-0-data-preparation',entry_file=ENTRY,data_classification='OBSCURED',
        original_entry_filename=FINAL,final_sha256=sha(target/ENTRY),
        filename_change_only=True,all_dta_bytes_unchanged=True,all_readme_links_resolve=True,
        recommendations_are_binding=False,publication_status='local_snapshot_not_uploaded',
        original_data_or_seed_included=False,upstream_data_guide=upstream_guide,
        guide_producer_sha256=guide['producer_sha256'],packager_sha256=sha(Path(__file__)),files=inventory)
    write_json(target/'PACKAGE.json',receipt)
    print(json.dumps({'status':'PASS','target':str(target),'entry_file':ENTRY,
        'files':len(inventory)+1,'dta_bytes_unchanged':True,'package_bytes':sum(p['bytes'] for p in inventory)},indent=2))
    return receipt

if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('source',type=Path);p.add_argument('target',type=Path)
    a=p.parse_args();package(a.source,a.target)
