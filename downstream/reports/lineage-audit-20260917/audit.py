"""Read-only audit of the existing G0, G0.5, G1 and strong masking artifacts.

This does not rebuild the pipeline or promote a masked G0 projection to G1.5.
Only hashes, aggregate evidence and this report are written. No seed is emitted.
"""
import hashlib
import json
import stat
import subprocess
from datetime import datetime
from pathlib import Path
from zoneinfo import ZoneInfo

ROOT = Path(__file__).resolve().parents[3]
OUT = Path(__file__).resolve().parent
G1 = Path('/Users/natanaelmassie/Downloads/deasy-g1-issue9-20260913-g1-runs/v3-assumed-stock-all-years-02')
G05 = Path('/Users/natanaelmassie/Downloads/deasy-g1-issue9-20260913/data/g0-5-development')
CACHE = {}


def read(path):
    return json.loads(path.read_text())


def digest(path):
    path = path.resolve()
    if path not in CACHE:
        h = hashlib.sha256()
        with path.open('rb') as f:
            for chunk in iter(lambda: f.read(4 * 1024 * 1024), b''):
                h.update(chunk)
        CACHE[path] = h.hexdigest()
    return CACHE[path]


def check(path, expected):
    exists = path.is_file()
    actual = digest(path) if exists else None
    return dict(path=str(path), exists=exists, expected_sha256=expected,
                actual_sha256=actual, matches=actual == expected if exists else False)


def group(rows):
    return dict(total=len(rows), matching=sum(x['matches'] for x in rows),
                missing=sum(not x['exists'] for x in rows), files=rows)


def main():
    projection = read(ROOT / 'downstream/reports/latest-build.json')
    mask = read(ROOT / 'downstream/obscure/strong/latest.json')
    g1 = read(G1 / 'run-manifest.json')
    handoff = read(G1 / 'downstream-handoff.json')
    g05 = read(ROOT / 'data/g0-5-development/manifest.json')
    report = dict(
        audited_at=datetime.now(ZoneInfo('Asia/Jakarta')).isoformat(),
        scope='Fresh file hashes and native Stata aggregate checks of existing artifacts; no end-to-end rerun.',
        checkout_head=subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip(),
        requested_lineage='G0 -> G0.5 -> G1 -> G1.5',
        requested_lineage_satisfied=False,
        observed_mask_lineage='G0 -> actual projection -> strong masking and newly generated fictional panel',
        missing_edge='Existing G1 output is not consumed by the strong masking builder.',
    )
    report['source_and_delivery_hashes'] = {
        name: check(Path(v['path']), v['sha256'])
        for name, v in projection['source_inputs'].items()
    }
    report['projection_hashes'] = {
        name: check(Path(v['file']), v['sha256'])
        for name, v in projection['outputs'].items()
    }
    report['masked_hash'] = check(Path(mask['run']) / 'OBSCURED-ONLY/obscured_dummy.dta', mask['masked_sha256'])
    report['same_g0_version'] = (
        g05['source_g0_master_sha256'] == projection['source_inputs']['actual']['sha256']
        and report['source_and_delivery_hashes']['actual']['matches'])
    report['mask_parent_is_actual_projection'] = mask['actual_sha256'] == projection['outputs']['actual']['sha256']
    report['g05_manifest_hash'] = check(ROOT / 'data/g0-5-development/manifest.json', g1['input']['input_sha256'])
    report['hydrated_g05_manifest_hash'] = check(G05 / 'manifest.json', g1['input']['input_sha256'])
    report['g05_parts'] = group([check(G05 / x['path'], x['sha256']) for x in g05['parts']])
    report['g05_metadata'] = group([check(G05 / x['path'], x['sha256']) for x in g05['metadata_files']])
    report['g05_repo_parts_present'] = sum((ROOT / 'data/g0-5-development' / x['path']).is_file() for x in g05['parts'])
    report['g1_handoff_files'] = {k: check(Path(v['path']), v['sha256']) for k, v in handoff['files'].items()}
    report['g1_recorded_outputs'] = group([check(G1 / x['path'], x['sha256']) for x in g1['output_files']])
    report['current_g1_code_vs_executed'] = group([check(ROOT / x['path'], x['sha256']) for x in g1['code']])
    historical_root = Path(handoff['project_root'])
    report['historical_g1_checkout_vs_executed'] = group([check(historical_root / x['path'], x['sha256']) for x in g1['code']])
    report['projection_code'] = group([check(ROOT / p, h) for p, h in projection['code'].items()])
    completed = mask['completion_followup']['completed_source_code_sha256']
    report['mask_code'] = group([check(ROOT / 'downstream/obscure/strong' / p, h)
                                 for p, h in completed.items() if not p.startswith('._')])
    report['g1_recorded_run'] = {
        k: g1[k] for k in ['run_id', 'started_utc', 'finished_utc', 'stata_exit_code',
                           'development_status', 'actual_finalisation_status', 'git_base']}
    report['g1_recorded_run']['input_version'] = g1['input']['g05_version']
    report['g1_recorded_run']['input_sha256_meaning'] = 'G0.5 package manifest hash, not DTA hash'
    report['g1_qa_receipts'] = {n: read(G1 / 'qa' / n)['status'] for n in [
        'full-master-validation.json', 'nominal-validation.json', 'panel_adapter_gate.json']}
    report['mask_prior_build_checks'] = {k: mask[k] for k in [
        'rows', 'columns', 'dummy_firms', 'protected_fields_exact', 'changed_numeric_fields',
        'numeric_stata_replay_exact', 'panel_replay_exact', 'byte_exact_recovery',
        'wrong_seed_rejected', 'tampering_rejected', 'g1_reestimated']}
    seed_root = Path('/Users/natanaelmassie/Downloads/.kolega-private/strong-v2')
    # Hashes are compared privately; only booleans/permissions are reported.
    report['retained_seed'] = {
        name: dict(exists=(seed_root / name).is_file(),
                   mode=oct(stat.S_IMODE((seed_root / name).stat().st_mode)),
                   matches_build_seed_id=digest(seed_root / name) == mask['seed_id'])
        for name in ['seed.key', 'seed.backup.key']}
    (OUT / 'evidence.json').write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps({
        'requested_lineage_satisfied': report['requested_lineage_satisfied'],
        'same_g0_version': report['same_g0_version'],
        'masked_hash_matches': report['masked_hash']['matches'],
        **{k: {x: report[k][x] for x in ['total', 'matching', 'missing']} for k in [
            'g05_parts', 'g05_metadata', 'g1_recorded_outputs', 'current_g1_code_vs_executed',
            'historical_g1_checkout_vs_executed', 'projection_code', 'mask_code']},
        'g1_handoff_files_matching': sum(v['matches'] for v in report['g1_handoff_files'].values()),
        'report': str(OUT / 'evidence.json'),
    }, indent=2))


if __name__ == '__main__':
    main()
