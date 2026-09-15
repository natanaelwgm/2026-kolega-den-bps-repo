"""Refresh an existing, explicitly screened release after completed execution."""
from pathlib import Path
import hashlib, json, shutil

HERE = Path(__file__).resolve().parent
F = HERE.parent / 'G0-wave-foundation-v2'
R = HERE.parent / 'github-release/releases/2026-09-13-data-foundation'
O = HERE.parent.parent / 'outputs/1014-research/data-foundation'

def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()

def copy(p, q):
    assert p.is_file() and not p.is_symlink()
    q.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(p, q)
    assert sha(p) == sha(q)

def main():
    assert R.is_dir()
    old = json.loads((R/'publication-manifest.json').read_text())
    # Reuse the previously screened source allowlist; never walk raw/runtime data.
    source_paths = {x['path'].removeprefix('stata-preparation/') for x in old['files']
                    if x['path'].startswith('stata-preparation/')}
    core = json.loads((F/'implementation-manifest.json').read_text())
    source_paths.update(x['path'] for x in core['code_files'])
    for rel in sorted(source_paths):
        p = F/rel
        assert not Path(rel).is_absolute() and '..' not in Path(rel).parts
        copy(p, R/'stata-preparation'/rel)
    for item in core['code_files']:
        assert sha(R/'stata-preparation'/item['path']) == item['sha256']
    for name in ['implementation-manifest.json', 'implementation-review/static-review.json',
                 'rd2017/implementation-manifest.json', 'rd2017/implementation-review/static-review.json']:
        copy(F/name, R/'stata-preparation'/name)
    for name in ['replay_preparation.py','run_reviewed_preparation.py','refresh_release.py']:
        copy(HERE/name, R/'replay-support'/name)
    for name in ['PLAN.md','README.md','R4-LAUNCHER-PLAN.md','author-manifest.json',
                 'test_replay_preparation.py','test_outer_launcher.py',
                 'fixture-results.txt','root-review.json']:
        p=HERE/'replay-review'/name
        if p.exists(): copy(p, R/'replay-support/review'/name)
    # These deliverables contain aggregate tables and execution metadata only.
    for folder in ['results','execution-evidence']:
        for p in (O/folder).rglob('*'):
            if p.is_file(): copy(p, R/p.relative_to(O))
    copy(O/'verification.json', R/'verification.json')
    assert not any(p.suffix.lower() in {'.dta','.xlsx','.log','.zip'} for p in R.rglob('*') if p.is_file())
    parts = json.loads((R/'cloud-data/manifest.json').read_text())
    for x in parts['parts'] + parts['metadata_files']:
        assert sha(R/'cloud-data'/x['path']) == x['sha256']
    records=[]
    for p in sorted(R.rglob('*')):
        if p.is_file() and p.name != 'publication-manifest.json':
            assert p.stat().st_size < 100*1024**2
            records.append({'path':p.relative_to(R).as_posix(),'sha256':sha(p),'bytes':p.stat().st_size})
    (R/'publication-manifest.json').write_text(json.dumps({
        'status':'FILES_VERIFIED','files':records,
        'master_ready_receipt_sha256':sha(HERE/'master-acceptance.json'),
        'core_execution_receipt_sha256':sha(F/'runtime/latest.json'),
        'rd2017_execution_receipt_sha256':sha(F/'rd2017/runtime/latest.json'),
        'current_core_implementation_sha256':sha(F/'implementation-manifest.json'),
        'data_scope':'Same screened derivative; aggregate CSVs; no original company data, DTA or runtime logs',
        'all_44_modules_executed':False},indent=2)+'\n')
    print(json.dumps({'status':'FILES_VERIFIED','files':len(records),'bytes':sum(x['bytes'] for x in records)}))

if __name__ == '__main__':
    main()
