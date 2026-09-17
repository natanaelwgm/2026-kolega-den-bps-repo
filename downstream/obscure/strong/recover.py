#!/usr/bin/env python3
"""Recover exact actual DTA with the retained private seed and encrypted archive."""
import argparse,json,hashlib
from pathlib import Path
from seeded import decrypt_recovery

def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--seed-file',required=True,type=Path)
    p.add_argument('--archive',required=True,type=Path)
    p.add_argument('--output',required=True,type=Path)
    p.add_argument('--audit-directory',type=Path)
    a=p.parse_args()
    if a.output.exists():raise SystemExit('Refusing to overwrite output')
    files=decrypt_recovery(a.seed_file.read_bytes(),a.archive)
    receipt=json.loads(files['manifest.json'])
    data=files['actual.dta']
    assert hashlib.sha256(data).hexdigest()==receipt['actual_sha256']
    a.output.parent.mkdir(parents=True,exist_ok=True)
    with a.output.open('xb') as f:f.write(data)
    if a.audit_directory:
        a.audit_directory.mkdir(parents=True,exist_ok=False)
        for n in ['manifest.json','identity_mapping.parquet','numeric_deltas.parquet']:
            (a.audit_directory/n).write_bytes(files[n])
    print(json.dumps({'restored':str(a.output),'sha256':receipt['actual_sha256'],'byte_exact':True}))
if __name__=='__main__':main()
