#!/usr/bin/env python3
"""Refresh source concordance and local package hashes; never alter dataset bytes."""
import csv,datetime,hashlib,json,re,subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
BLOCK=ROOT/'20260917-run/block-0-data-preparation'

def sha(p):
    with p.open('rb') as f:return hashlib.file_digest(f,'sha256').hexdigest()

def write(p,x):p.write_text(json.dumps(x,ensure_ascii=False,indent=2)+'\n')

def main():
    mapping=BLOCK/'documentation/source_concordance.csv'
    with mapping.open(newline='') as f:
        reader=csv.DictReader(f);fields=reader.fieldnames;rows=list(reader)
    for field in ['local_source_sha256','local_source_comparison']:
        if field not in fields:fields.append(field)
    for row in rows:
        source=ROOT/row['source_file']
        assert source.is_file(),str(source)
        row['source_sha256']=sha(source)
        # Historical G0 paths come from the original manifest. G0.5/G1 copies
        # are linked to the verified local research checkout when present.
        historical=Path('/Users/natanaelmassie/Downloads/1014-github-completeness-20260913/repo')/row['source_file']
        if row['source_file'].startswith(('harness/g05/','work-items/G1/')) and historical.is_file():
            row['original_local_file']=str(historical)
        local=Path(row['original_local_file'])
        if local==source:
            row['local_source_sha256']=row['source_sha256']
            row['local_source_comparison']='developed_or_retained_in_coauthor_repository'
        elif local.is_file():
            row['local_source_sha256']=sha(local)
            row['local_source_comparison']='identical' if row['local_source_sha256']==row['source_sha256'] else 'different_versions_retained'
        else:
            row['local_source_sha256']=''
            row['local_source_comparison']='historical_path_not_currently_available'
    with mapping.open('w',newline='') as f:
        w=csv.DictWriter(f,fieldnames=fields,lineterminator="\n");w.writeheader();w.writerows(rows)
    # Verify only current reader-facing documents. Preserved upstream snapshots
    # deliberately describe their historical package, including local-only data.
    docs=[BLOCK/'README.md',*(BLOCK/'documentation').glob('*.md')]
    checked=0
    for doc in docs:
        for link in re.findall(r'\]\(([^)]+)\)',doc.read_text()):
            if re.match(r'^(https?://|#)',link):continue
            dest=link.split('#')[0]
            assert (doc.parent/dest).exists(),f'{doc.relative_to(BLOCK)}: {link}'
            checked+=1
    guide=BLOCK/'metadata/DATA_GUIDE_VALIDATION.json';g=json.loads(guide.read_text())
    g['files']={name:sha(BLOCK/name) for name in ['README.md','METADATA.json','documentation/DATA_GUIDE.md']}
    g['interface_documentation_updated_at']=datetime.datetime.now().astimezone().isoformat()
    write(guide,g)
    package=BLOCK/'PACKAGE.json';p=json.loads(package.read_text())
    assert sha(BLOCK/'analysis_ready_data.dta')==p['final_sha256']
    p['documentation_updated_at']=g['interface_documentation_updated_at']
    p['interface']={'master':'00_run.do','settings':'settings.do','concordance':'documentation/source_concordance.csv','concordance_rows':len(rows),'old_data_bytes_preserved':True}
    eligible=subprocess.check_output(['git','ls-files','-z','--cached','--others','--exclude-standard','--',str(BLOCK)],cwd=ROOT).decode().split('\0')
    files=[ROOT/f for f in eligible if f and (ROOT/f).is_file() and ROOT/f!=package]
    assert [x for x in files if x.suffix=='.dta']==[BLOCK/'analysis_ready_data.dta']
    assert not any(x.suffix in ['.key','.aesgcm'] for x in files)
    p['files']=[dict(file=str(f.relative_to(BLOCK)),bytes=f.stat().st_size,sha256=sha(f)) for f in sorted(files)]
    write(package,p)
    print(json.dumps(dict(status='PASS',concordance_rows=len(rows),links_checked=checked,package_files=len(files),final_dta_unchanged=True)))

if __name__=='__main__':main()
