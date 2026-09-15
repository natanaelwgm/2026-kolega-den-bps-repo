#!/usr/bin/env python3
"""Satu peluncur luar: cadangkan hasil lama, jalankan tiap tahap, rapikan log selesai."""
from pathlib import Path
import argparse, datetime, hashlib, importlib.util, json, subprocess, time

HELPER = Path(__file__).with_name('replay_preparation.py')
h = None

def load_helper(expected_sha):
    if hashlib.sha256(HELPER.read_bytes()).hexdigest() != expected_sha:
        raise RuntimeError('Helper berbeda dari versi yang direview; tidak diimpor.')
    spec = importlib.util.spec_from_file_location('replay_preparation', HELPER)
    module = importlib.util.module_from_spec(spec); spec.loader.exec_module(module)
    return module


def utc():
    return datetime.datetime.now(datetime.timezone.utc)


def fresh_stage(root, stage, prior_sha, not_before, implementation_sha, expected_stage_path):
    p = root / 'runtime' / (stage + '-latest.json')
    receipt, rh = h.snapshot(p)
    h.require(rh != prior_sha, 'Receipt lama tidak boleh menggantikan hasil panggilan baru.')
    h.completed(receipt, passed=True)
    h.require(receipt['stage'] == stage and receipt['implementation_manifest_sha256'] == implementation_sha, 'Tahap atau seal receipt berbeda.')
    h.require(receipt.get('actual_stage_path') == expected_stage_path and 'bounded_tail_resume' not in receipt, 'Bukan eksekusi penuh tahap yang baru.')
    started = datetime.datetime.fromisoformat(receipt['started_utc'].replace('Z', '+00:00'))
    h.require(started >= not_before, 'Receipt mulai sebelum panggilan baru.')
    attempt = h.safe(root, receipt['attempt'])
    h.require(attempt.parent.parent == root / 'runtime' and attempt.name == stage, 'Path attempt baru tidak sah.')
    rp = attempt / 'receipt.json'
    h.require(h.sha(rp) == rh, 'Receipt latest tidak identik dengan attempt baru.')
    h.require(receipt.get('input_code_hashes_unchanged') is True, 'Pemeriksaan kode/input tahap tidak lulus.')
    return rp, rh, receipt


def run(foundation, archive, manifest_sha, helper_sha, execute=False):
    global h
    h = load_helper(helper_sha)
    root = Path(foundation).absolute(); archive = Path(archive).absolute()
    h.require(h.sha(HELPER) == helper_sha, 'Helper berbeda dari versi yang direview.')
    preview = h.prepare(root, archive, manifest_sha, dry_run=True)
    if not execute:
        return {'status': 'DRY_RUN_ONLY', 'active_status': preview['active_status'],
                'generated_path_count': len(preview['generated']), 'archive': str(archive),
                'instruction': 'Tambahkan --run hanya untuk memulai cadangan dan rerun penuh yang direview.',
                'no_stata_started': True}
    stages, stage_sha = h.snapshot(h.safe(root, 'registry/stages.json'))
    h.require(len(stages) == 17 and stages[0]['id'] == 'T000' and stages[-1]['id'] == 'H090', 'Urutan wajib adalah 17 tahap T000 sampai H090.')
    h.require(len({s['id'] for s in stages}) == len(stages), 'ID tahap duplikat.')
    command = h.safe(root, 'run_preparation.command')
    command_sha = h.sha(command)
    # Lock luar mencegah dua peluncur persiapan ini berjalan bersamaan.
    outer_lock = root.parent / ('.' + root.name + '-reviewed-replay.lock')
    with h.lock(outer_lock):
        start = time.monotonic()
        print('STARTING | Cadangkan hasil sebelumnya | 0/17 | 0.0%', flush=True)
        preparation = h.prepare(root, archive, manifest_sha)
        h.require(preparation['status'] == 'READY_FOR_FULL_RERUN', 'Cadangan tersimpan, tetapi ruang belum cukup; lihat ledger.json. Stata belum dimulai.')
        status = {'status': 'RUNNING_FRESH_FULL_REPLAY', 'started_utc': utc().isoformat(),
                  'foundation': str(root), 'implementation_manifest_sha256': manifest_sha,
                  'helper_sha256': helper_sha, 'launcher_sha256': h.sha(Path(__file__)),
                  'stage_registry_sha256': stage_sha, 'run_preparation_command_sha256': command_sha,
                  'previous_outputs_archive': str(archive), 'stages': []}
        state_path = archive / 'launcher-receipt.json'; h.write_json(state_path, status)
        try:
            for i, stage in enumerate(stages, 1):
                sid = stage['id']; stage_start = time.monotonic()
                h.require(h.sha(HELPER) == helper_sha and h.sha(root/'implementation-manifest.json') == manifest_sha, 'Seal berubah selama rerun.')
                h.require(h.sha(root/'registry/stages.json') == stage_sha and h.sha(command) == command_sha, 'Registry atau entrypoint berubah.')
                # Runner memberi nama folder berdasarkan detik UTC: jangan tabrak nama lama.
                while (root / 'runtime' / ('run-' + utc().strftime('%Y%m%dT%H%M%SZ'))).exists():
                    time.sleep(0.15)
                latest = root / 'runtime' / (sid + '-latest.json')
                prior_sha = h.sha(latest) if latest.exists() else None
                began = utc()
                print(f'STARTING | {sid} | {i}/17 | {100*(i-1)/17:.1f}% | elapsed {time.monotonic()-start:.1f}s', flush=True)
                # Script asli memilih Python/Stata yang sudah direview; stdout tetap terlihat.
                subprocess.run(['/bin/zsh', str(command), '--from-stage', sid, '--through', sid], check=True)
                rp, rh, receipt = fresh_stage(root, sid, prior_sha, began, manifest_sha, stage['path'])
                cold = archive.with_name(archive.name + '-stage-' + sid)
                logs = h.compact_stage(root, str(rp.relative_to(root)), cold, manifest_sha)
                status['stages'].append({'stage': sid, 'receipt_path': str(rp.relative_to(root)), 'receipt_sha256': rh,
                                         'pid': receipt.get('pid'), 'status': 'passed', 'completed_log_archive': str(cold),
                                         'log_archive_status': logs['status'], 'elapsed_seconds': time.monotonic()-stage_start})
                h.write_json(state_path, status)
                print(f'FINISHED | {sid} | {i}/17 | {100*i/17:.1f}% | elapsed {time.monotonic()-stage_start:.1f}s', flush=True)
            final, final_sha = h.snapshot(root/'runtime/latest.json'); h.completed(final, passed=True)
            h.require(final['implementation_manifest_sha256'] == manifest_sha, 'Seal final berbeda.')
            h.require(final['attempt'] == str(Path(status['stages'][-1]['receipt_path']).parent.parent), 'Receipt final bukan milik panggilan H090 baru.')
            h.require(h.sha(h.safe(root, final['attempt'])/'receipt.json') == final_sha, 'Receipt final tidak cocok dengan attempt.')
            for x in final['output_hashes']:
                h.file_matches(h.safe(root, x['path']), x['sha256'], x['bytes'])
            status.update(status='PASSED_FRESH_17_STAGE_REPLAY', final_receipt_sha256=final_sha,
                          finished_utc=utc().isoformat(), elapsed_seconds=time.monotonic()-start,
                          G0_complete=False, source_admission=False)
            h.write_json(state_path, status)
            print(f'FINISHED | Semua 17 tahap lulus | 17/17 | 100.0% | elapsed {time.monotonic()-start:.1f}s', flush=True)
            return status
        except BaseException as error:
            status.update(status='FAILED_NEW_REPLAY_OLD_ARCHIVE_PRESERVED', error=repr(error),
                          finished_utc=utc().isoformat(), elapsed_seconds=time.monotonic()-start)
            h.write_json(state_path, status)
            print(f'FAILED | Tahap baru belum lengkap. Cadangan lama tetap di {archive}', flush=True)
            raise


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--foundation', required=True); ap.add_argument('--archive', required=True)
    ap.add_argument('--manifest-sha256', required=True); ap.add_argument('--helper-sha256', required=True)
    ap.add_argument('--run', action='store_true', help='Tanpa flag ini hanya inventory metadata.')
    args = ap.parse_args()
    result = run(args.foundation, args.archive, args.manifest_sha256, args.helper_sha256, args.run)
    print(json.dumps(result, indent=2))


if __name__ == '__main__':
    main()
