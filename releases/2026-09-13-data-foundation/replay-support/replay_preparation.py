#!/usr/bin/env python3
"""Persiapkan rerun penuh tanpa mengubah satu baris kode atau angka penelitian."""
from pathlib import Path
import argparse, contextlib, datetime, fcntl, gzip, hashlib, json, os, re, shutil, subprocess, tempfile

GIB = 1024 ** 3
RESERVED = ('code', 'scripts', 'registry', 'provenance', 'row-plans', 'plans',
            'correction-planning', 'implementation-review', 'audit',
            'runtime/implementation-history', 'rd2017/inputs', 'rd2017/provenance')


def require(ok, message):
    if not ok:
        raise RuntimeError(message)


def sha(path):
    h = hashlib.sha256()
    with Path(path).open('rb') as f:
        for block in iter(lambda: f.read(1024 * 1024), b''):
            h.update(block)
    return h.hexdigest()


def snapshot(path):
    # Hash dan objek JSON berasal dari pembacaan byte yang sama.
    data = Path(path).read_bytes()
    return json.loads(data), hashlib.sha256(data).hexdigest()


def durable_dir(path):
    fd = os.open(path, os.O_RDONLY)
    try:
        os.fsync(fd)
    finally:
        os.close(fd)


def write_json(path, value):
    path = Path(path)
    with tempfile.NamedTemporaryFile(dir=path.parent, prefix='.ledger-', delete=False) as f:
        temp = Path(f.name)
        f.write((json.dumps(value, indent=2) + '\n').encode())
        f.flush()
        os.fsync(f.fileno())
    os.replace(temp, path)
    durable_dir(path.parent)


def safe(root, relative):
    root = Path(root)
    p = Path(relative)
    require(not p.is_absolute() and '..' not in p.parts and p.parts, f'Path tidak sah: {relative}')
    out = root / p
    require(out.resolve().is_relative_to(root.resolve()), f'Path keluar foundation: {relative}')
    q = out
    while q != root:
        require(not q.is_symlink(), f'Symlink ditolak: {q}')
        q = q.parent
    return out


def stat_key(path):
    s = path.stat()
    return (s.st_dev, s.st_ino, s.st_size, s.st_mtime_ns, s.st_ctime_ns)


def no_stata():
    lines = subprocess.check_output(['ps', '-axo', 'comm='], text=True).splitlines()
    require(not any(Path(x.strip()).name.lower() in {'stata-se', 'stata-mp', 'stata', 'statase', 'statamp'} for x in lines), 'Masih ada Stata aktif; persiapan dibatalkan.')


def completed(receipt, passed=False):
    require(receipt.get('owned_process_exited') is True, 'Receipt belum membuktikan proses selesai.')
    require(receipt.get('status') in (['passed'] if passed else ['passed', 'failed', 'partial_stages_passed']), 'Receipt masih berjalan/tidak final.')
    # PID lama dapat dipakai proses lain; shared lock + no_stata membuktikan batas aktif.
    if passed:
        require(receipt.get('exit_code') == 0 and receipt.get('success_marker_present') is True, 'Receipt sukses tidak lengkap.')


@contextlib.contextmanager
def lock(path):
    # Lock yang sama dengan runner; file lock tidak dihapus saat selesai.
    path = Path(path)
    require(path.parent.is_dir(), 'Folder shared lock belum ada.')
    require(not path.is_symlink(), 'Symlink lock ditolak.')
    with path.open('a+') as f:
        fcntl.flock(f, fcntl.LOCK_EX | fcntl.LOCK_NB)
        yield


def inventory(root, expected_manifest=None):
    root = Path(root).absolute()
    require(root.is_dir() and root.resolve() == root, 'Foundation harus folder nyata, tanpa symlink.')
    manifest, mh = snapshot(safe(root, 'implementation-manifest.json'))
    if expected_manifest:
        require(mh == expected_manifest, 'Seal berubah; pakai manifest yang diperiksa.')
    dag, dh = snapshot(safe(root, 'registry/dag.json'))
    review, rh = snapshot(safe(root, 'implementation-review/static-review.json'))
    require(review.get('status') in ['passed', 'PASS'] and review.get('implementation_manifest_sha256') == mh, 'Review tidak cocok dengan seal.')
    freeze, fh = snapshot(safe(root, 'plan-freeze.json'))
    require(fh == manifest['plan_freeze_sha256'], 'Freeze tidak cocok dengan seal.')
    controls = {'implementation-manifest.json': mh, 'registry/dag.json': dh,
                'implementation-review/static-review.json': rh, 'plan-freeze.json': fh}
    protected = {safe(root, p).resolve() for p in controls}
    expected_pins = []
    for row in manifest['code_files']:
        p = safe(root, row['path']); protected.add(p.resolve()); expected_pins.append((p, row['sha256']))
    for row in manifest['input_files'] + freeze.get('files', []):
        p = Path(row['path'])
        if not p.is_absolute():
            p = safe(root, row['path'])
        protected.add(p.resolve()); expected_pins.append((p, row['sha256']))
    # Node tanpa producer adalah sumber/reference; tidak pernah menjadi target gerak.
    for n in dag['nodes']:
        if not n.get('producer'):
            p = Path(n['path'])
            protected.add((p if p.is_absolute() else safe(root, p)).resolve())
    protected_inodes = {(p.stat().st_dev, p.stat().st_ino) for p in protected if p.is_file()}
    chosen, excluded = {}, []
    for n in dag['nodes']:
        if not n.get('producer'):
            continue
        p = safe(root, n['path']); rel = p.relative_to(root).as_posix()
        forbidden = (p.resolve() in protected or any(rel == x or rel.startswith(x + '/') for x in RESERVED))
        if p.is_file():
            forbidden = forbidden or (p.stat().st_dev, p.stat().st_ino) in protected_inodes
        if forbidden:
            excluded.append(rel)
            continue
        require(not p.exists() or p.is_file(), f'Output bukan file: {rel}')
        chosen.setdefault(rel, {'path': rel, 'role': n['role'], 'exists': p.is_file(), 'bytes': p.stat().st_size if p.is_file() else 0})
    return {'foundation': str(root), 'implementation_manifest_sha256': mh, 'controls': controls,
            'protected_paths': sorted(str(p) for p in protected), 'protected_inodes': sorted(protected_inodes),
            'pins': [(str(p), h) for p, h in expected_pins],
            'generated': sorted(chosen.values(), key=lambda x: x['path']),
            'excluded_protected_generated': sorted(set(excluded)),
            'foundation_bytes': sum(p.stat().st_size for p in root.rglob('*') if p.is_file() and not p.is_symlink()),
            'free_bytes': shutil.disk_usage(root).free}


def controls_unchanged(root, plan):
    for rel, h in plan['controls'].items():
        require(sha(safe(root, rel)) == h, f'Metadata kontrol berubah: {rel}')


def file_matches(path, h, count):
    require(path.is_file() and not path.is_symlink(), f'File hilang/symlink: {path}')
    require(path.stat().st_size == count and sha(path) == h, f'Byte berubah: {path}')


def verify_object(path, h, count):
    out = hashlib.sha256(); n = 0
    with gzip.open(path, 'rb') as f:
        for block in iter(lambda: f.read(1024 * 1024), b''):
            out.update(block); n += len(block)
    require(out.hexdigest() == h and n == count, f'Arsip gagal dekompresi/hash: {path}')


def save_object(source, archive):
    # Byte asli tetap hot sampai pembacaan ulang gzip lulus.
    before = stat_key(source); h = sha(source); count = before[2]
    obj = archive / 'objects' / (h + '.gz')
    if not obj.exists():
        with tempfile.NamedTemporaryFile(dir=obj.parent, prefix='.gzip-', delete=False) as raw:
            temp = Path(raw.name)
            with gzip.GzipFile(fileobj=raw, mode='wb', filename='', mtime=0, compresslevel=1) as z:
                with source.open('rb') as f:
                    shutil.copyfileobj(f, z, 1024 * 1024)
            raw.flush(); os.fsync(raw.fileno())
        verify_object(temp, h, count)
        os.replace(temp, obj)
    verify_object(obj, h, count)
    with obj.open('rb') as f:
        os.fsync(f.fileno())
    durable_dir(obj.parent); durable_dir(archive)
    require(stat_key(source) == before, f'File berubah saat diarsipkan: {source}')
    file_matches(source, h, count)
    return {'sha256': h, 'plain_bytes': count, 'archive_bytes': obj.stat().st_size,
            'object': obj.relative_to(archive).as_posix(), 'hot_stat': list(before)}


def release_hot(root, rel, item, archive, plan):
    p = safe(root, rel)
    controls_unchanged(root, plan)
    require(stat_key(p) == tuple(item['hot_stat']), f'Hot berubah sebelum pelepasan: {rel}')
    file_matches(p, item['sha256'], item['plain_bytes'])
    verify_object(safe(archive, item['object']), item['sha256'], item['plain_bytes'])
    p.unlink(); durable_dir(p.parent)


def exact_private_tmp(entry, receipt):
    """Hanya nama literal yang benar-benar dicatat relay; tidak pernah glob /tmp."""
    relay = receipt.get('batch_relay', {})
    expected = Path('/private/tmp') / entry.with_suffix('.log').name
    if relay.get('source_path') != str(expected) or relay.get('status') != 'passed':
        return None
    require(re.fullmatch(r'run_WF_\d{8}T\d{6}Z_[A-Za-z0-9]+\.log', expected.name), 'Nama log tmp tidak sah.')
    require(not expected.is_symlink() and expected.resolve() == expected, 'Symlink /private/tmp ditolak.')
    if not expected.exists():
        return None
    file_matches(expected, relay['sha256'], relay['bytes_streamed'])
    return expected


def private_tmp_release(root, item, archive, plan):
    p = Path(item['external_original_path'])
    rp = safe(root, item['receipt_path']); receipt, rh = snapshot(rp)
    require(rh == item['receipt_sha256'], 'Receipt tmp berubah.')
    completed(receipt)
    require(exact_private_tmp(safe(root, receipt['entry']), receipt) == p, 'Binding log tmp berubah.')
    controls_unchanged(root, plan)
    require(stat_key(p) == tuple(item['hot_stat']), 'Log tmp berubah sebelum pelepasan.')
    file_matches(p, item['sha256'], item['plain_bytes'])
    verify_object(safe(archive, item['object']), item['sha256'], item['plain_bytes'])
    p.unlink(); durable_dir(p.parent)


def owned_attempts(root):
    # Hanya folder attempt yang dinyatakan oleh receipt, bukan semua runtime secara buta.
    out = []
    for p in sorted((root / 'runtime').glob('run-*/receipt.json')):
        r, h = snapshot(p); completed(r)
        require(safe(root, r['attempt']) == p.parent, 'Attempt overall tidak cocok.')
        out.append((p, r, h))
        for child in sorted(p.parent.glob('*/receipt.json')):
            cr, ch = snapshot(child); completed(cr)
            require(safe(root, cr['attempt']) == child.parent, 'Attempt tahap tidak cocok.')
            out.append((child, cr, ch))
    return out


def non_wfdoc_bytes(path):
    # Hanya baris komentar utuh yang diberi marker ini boleh berubah.
    out = []
    for line in Path(path).read_bytes().splitlines(keepends=True):
        if b'WFDOC-INJECTED' in line:
            require(line.lstrip().startswith(b'*'), 'Marker WFDOC muncul pada perintah executable.')
        else:
            out.append(line)
    return b''.join(out)


def verify_storage_continuity(root, plan, latest, latest_sha, wave_sha):
    current_sha = plan['implementation_manifest_sha256']
    if latest['implementation_manifest_sha256'] == current_sha:
        return None
    review, review_sha = snapshot(safe(root, 'implementation-review/static-review.json'))
    require(review_sha == plan['controls']['implementation-review/static-review.json'], 'Review berubah.')
    c = review.get('storage_replay_continuity', {})
    require(c.get('status') == 'PASS_FOR_ARCHIVING_PRIOR_COMPLETED_RUN' and c.get('reviewer') == '/root', 'Tidak ada review root untuk kesinambungan arsip.')
    require(c.get('current_implementation_manifest_sha256') == current_sha, 'Seal continuity berbeda.')
    require(c.get('prior_execution_manifest_sha256') == latest['implementation_manifest_sha256'], 'Seal eksekusi lama berbeda.')
    require(c.get('final_receipt_path') == latest['attempt'] + '/receipt.json' and c.get('final_receipt_sha256') == latest_sha, 'Receipt final continuity berbeda.')
    require(c.get('wave_output_manifest_sha256') == wave_sha, 'Wave manifest continuity berbeda.')
    old_path = safe(root, c['prior_execution_manifest_path'])
    old, old_sha = snapshot(old_path)
    require(old_sha == c['prior_execution_manifest_sha256'], 'Manifest lama berubah.')
    current, actual_current_sha = snapshot(safe(root, 'implementation-manifest.json'))
    require(actual_current_sha == current_sha, 'Manifest current berubah.')
    require(old['input_files'] == current['input_files'], 'Input_files berubah; continuity ditolak.')
    require(old['plan_freeze_sha256'] == current['plan_freeze_sha256'], 'Freeze berubah; continuity ditolak.')
    require(old.get('stata_sha256') == current.get('stata_sha256'), 'Executable Stata berubah.')
    dp = safe(root, c['reviewed_delta_manifest_path']); delta, dh = snapshot(dp)
    require(dh == c['reviewed_delta_manifest_sha256'], 'Delta manifest berubah.')
    require(delta.get('status') == 'PASS_ROOT_REVIEWED_COMMENT_METADATA_CONTINUITY', 'Delta belum direview root.')
    require(delta.get('old_implementation_manifest_sha256') == old_sha and delta.get('current_implementation_manifest_sha256') == current_sha, 'Endpoint delta berbeda.')
    before = {x['path']: x['sha256'] for x in old['code_files']}
    after = {x['path']: x['sha256'] for x in current['code_files']}
    require(before.keys() == after.keys(), 'Code path set berubah; perlu review kontrak lain.')
    changes = delta['changed_files']; listed = {x['path']: x for x in changes}
    require(len(listed) == len(changes), 'Path delta duplikat.')
    require(set(listed) == {p for p in before if before[p] != after[p]}, 'Delta tidak mencakup tepat semua perubahan.')
    metadata = set(c.get('reviewed_metadata_paths', []))
    require(set(c.get('delta_classes', [])) <= {'comments_only', 'metadata_only'}, 'Kelas perubahan tidak diizinkan.')
    used_metadata = set()
    for rel, x in listed.items():
        require(x['old_sha256'] == before[rel] and x['new_sha256'] == after[rel], 'Pin perubahan berbeda.')
        newp = safe(root, rel); oldp = safe(root, x['old_preserved_path'])
        require(sha(newp) == after[rel] and sha(oldp) == before[rel], 'Byte kode lama/current berbeda dari pin.')
        if x['kind'] == 'comments_only':
            require(rel.endswith('.do') and non_wfdoc_bytes(oldp) == non_wfdoc_bytes(newp), 'Perintah non-WFDOC berubah.')
        elif x['kind'] == 'metadata_only':
            require(rel in metadata and x.get('not_a_numerical_operand') is True, 'Metadata tidak direview secara eksplisit.')
            used_metadata.add(rel)
        else:
            raise RuntimeError('Perubahan di luar komentar/metadata; continuity ditolak.')
    require(used_metadata == metadata, 'Allowlist metadata bukan daftar tepat.')
    plan['controls'][c['prior_execution_manifest_path']] = old_sha
    plan['controls'][c['reviewed_delta_manifest_path']] = dh
    return {'descriptor': c, 'current_review_sha256': review_sha,
            'scope': 'Archive prior exact output bytes only; current full T000 execution still required.',
            'complete_changed_file_count': len(changes)}


def preparation_sources(root, plan):
    latest, lh = snapshot(safe(root, 'runtime/latest.json')); completed(latest, passed=True)
    require(sha(safe(root, latest['attempt']) / 'receipt.json') == lh, 'Receipt latest berbeda dari attempt final.')
    # Master dan 12 wave mempunyai perlindungan khusus sebelum keluaran lain dipindah.
    wm, wh = snapshot(safe(root, 'runtime/wave-output-manifest.json'))
    plan['storage_replay_continuity'] = verify_storage_continuity(root, plan, latest, lh, wh)
    require(wm.get('status') == 'passed' and wm.get('parent_process_exited') is True, 'Manifest wave belum passed/exited.')
    deliveries = [wm['master']] + wm['waves']
    require(len(wm['waves']) == 12 and len({x['path'] for x in deliveries}) == 13, 'Harus ada satu master dan 12 wave.')
    selected = {x['path'] for x in plan['generated'] if x['exists']}
    outputs = {x['path']: x for x in latest['output_hashes']}
    for x in deliveries:
        require(x['path'] in selected and x['path'] in outputs, 'Master/wave tidak tercatat sebagai output final.')
        require(outputs[x['path']]['sha256'] == x['sha256'], 'Hash master/wave antar-receipt berbeda.')
    for x in outputs.values():
        file_matches(safe(root, x['path']), x['sha256'], x['bytes'])
    for rpath in [root / 'runtime/latest.json', root / 'rd2017/runtime/latest.json']:
        if rpath.exists():
            completed(snapshot(rpath)[0])
    for p in (root / 'runtime').glob('run-*/**/receipt.json'):
        completed(snapshot(p)[0])
    receipts = owned_attempts(root)
    for p in (root / 'runtime').glob('*-latest.json'):
        r, _ = snapshot(p)
        if 'status' in r:
            completed(r)
    # Control snapshots ikut diperiksa sebelum setiap operasi yang melepas berkas.
    plan['controls']['runtime/latest.json'] = lh
    plan['controls']['runtime/wave-output-manifest.json'] = wh
    meta = {root / 'runtime/latest.json', root / 'runtime/wave-output-manifest.json'}
    for folder in ['runtime', 'corrections/runtime']:
        meta.update(p for p in (root / folder).glob('*.json') if p.is_file())
    movable = set(selected)
    external_logs = {}
    protected = set(plan['protected_paths']); pinodes = set(map(tuple, plan['protected_inodes']))
    for p, r, h in receipts:
        plan['controls'][p.relative_to(root).as_posix()] = h
        meta.update(q for q in p.parent.glob('*.json') if q.is_file())
        if 'entry' not in r:
            continue
        entry = safe(root, r['entry'])
        require(re.fullmatch(r'run_WF_\d{8}T\d{6}Z_[A-Za-z0-9]+\.do', entry.name) and entry.parent == root, 'Entry bukan file generated yang diizinkan.')
        for q in [entry, entry.with_suffix('.log'), p.parent / 'batch.log', p.parent / 'console.log']:
            rel = q.relative_to(root).as_posix()
            if q.exists():
                safe(root, rel)
                require(str(q.resolve()) not in protected and (q.stat().st_dev, q.stat().st_ino) not in pinodes, 'Log/entry berbenturan dengan sumber/kode.')
                movable.add(rel)
        tmp = exact_private_tmp(entry, r)
        if tmp is not None:
            require(str(tmp.resolve()) not in protected and stat_key(tmp)[:2] not in pinodes, 'Log tmp berbenturan dengan input/code.')
            external_logs[str(tmp)] = {'external_original_path': str(tmp), 'receipt_path': str(p.relative_to(root)), 'receipt_sha256': h}
    # Catat pertumbuhan yang benar-benar diamati, bukan tebak rasio kompresi.
    observed_growth = 0
    for _, r, _ in receipts:
        samples = r.get('disk_samples', [])
        if samples:
            observed_growth = max(observed_growth, max(x['bytes'] for x in samples))
    largest_log = max((r.get('batch_relay', {}).get('bytes_streamed', 0) for _, r, _ in receipts), default=0)
    largest_log = max(largest_log, max(((p.parent / 'batch.log').stat().st_size for p, _, _ in receipts if (p.parent / 'batch.log').is_file()), default=0))
    require(isinstance(largest_log, int) and largest_log >= 0, 'Ukuran log historis tidak sah.')
    return sorted(movable), sorted(meta), deliveries, observed_growth, largest_log, list(external_logs.values())


def prepare(root, archive, expected_manifest, dry_run=False):
    root = Path(root).absolute(); archive = Path(archive).absolute()
    require(archive.parent == root.parent and archive != root and not archive.exists(), 'Arsip harus sibling baru, tidak boleh menimpa folder.')
    if dry_run:
        # Tidak mengambil lock atau menulis apa pun; running ditampilkan sebagai blocker.
        p = inventory(root, expected_manifest)
        r, _ = snapshot(safe(root, 'runtime/latest.json'))
        p.update(status='DRY_RUN_ONLY', active_status=r.get('status'), archive=str(archive), no_files_changed=True)
        return p
    with lock(root.parent / 'G0-rebuild/runtime/stata-owned.lock'):
        no_stata()
        plan = inventory(root, expected_manifest)
        paths, metadata, deliveries, prior_peak, largest_log, external_logs = preparation_sources(root, plan)
        # Semua sumber immutable tetap di tempat dan diverifikasi terhadap seal.
        for p, h in plan['pins']:
            require(sha(p) == h, f'Input/kode tidak cocok seal: {p}')
        controls_unchanged(root, plan)
        archive.mkdir(mode=0o700); (archive / 'objects').mkdir(mode=0o700)
        durable_dir(archive.parent); durable_dir(archive)
        ledger = {'status': 'ARCHIVING', 'foundation': str(root), 'created_utc': datetime.datetime.now(datetime.timezone.utc).isoformat(),
                  'implementation_manifest_sha256': plan['implementation_manifest_sha256'], 'control_snapshots': plan['controls'], 'storage_replay_continuity': plan.get('storage_replay_continuity'),
                  'logical_paths': {}, 'no_original_sources_removed': True, 'full_rerun_from': 'T000', 'observed_prior_peak_bytes_diagnostic_only': prior_peak, 'largest_observed_completed_batch_log_bytes': largest_log, 'postexit_log_copy_reserve_bytes': 2 * largest_log}
        write_json(archive / 'selection.json', plan)
        write_json(archive / 'ledger.json', ledger)
        # Metadata tetap hot; salinan byte asli ikut katalog pemulihan.
        for p in metadata:
            rel = p.relative_to(root).as_posix()
            ledger['logical_paths'][rel] = dict(save_object(p, archive), disposition='retained_hot_metadata')
        write_json(archive / 'ledger.json', ledger)
        first = [x['path'] for x in deliveries]
        for i, rel in enumerate(first, 1):
            print(f'Cadangkan master/wave {i}/13: {rel}', flush=True)
            ledger['logical_paths'][rel] = dict(save_object(safe(root, rel), archive), disposition='verified_hot_pending_release')
            certified = next(x for x in deliveries if x['path'] == rel)
            require(ledger['logical_paths'][rel]['sha256'] == certified['sha256'] and ledger['logical_paths'][rel]['plain_bytes'] == certified['bytes'], 'Master/wave berubah sesudah verifikasi final.')
            write_json(archive / 'ledger.json', ledger)
        for i, rel in enumerate(first + [x for x in paths if x not in first], 1):
            if rel not in ledger['logical_paths']:
                ledger['logical_paths'][rel] = dict(save_object(safe(root, rel), archive), disposition='verified_hot_pending_release')
                write_json(archive / 'ledger.json', ledger)
            release_hot(root, rel, ledger['logical_paths'][rel], archive, plan)
            ledger['logical_paths'][rel]['disposition'] = 'cold_exact_bytes'
            write_json(archive / 'ledger.json', ledger)
            if i % 100 == 0:
                print(f'Arsip terverifikasi: {i}/{len(paths)} berkas', flush=True)
        for extra in external_logs:
            q = Path(extra['external_original_path'])
            key = 'external_private_tmp/' + q.name
            ledger['logical_paths'][key] = dict(save_object(q, archive), **extra, disposition='verified_hot_pending_release')
            write_json(archive / 'ledger.json', ledger)
            private_tmp_release(root, ledger['logical_paths'][key], archive, plan)
            ledger['logical_paths'][key]['disposition'] = 'cold_exact_bytes'
            write_json(archive / 'ledger.json', ledger)
        controls_unchanged(root, plan)
        for p, h in plan['pins']:
            require(sha(p) == h, f'Input/kode berubah: {p}')
        for x in plan['generated']:
            safe(root, x['path']).parent.mkdir(parents=True, exist_ok=True)
        now = sum(p.stat().st_size for p in root.rglob('*') if p.is_file() and not p.is_symlink())
        free = shutil.disk_usage(root).free
        # Peak lama adalah ukuran absolut (termasuk percobaan gagal), bukan tambahan.
        # Cadangan menutup dua salinan log yang dapat ditulis setelah PID berhenti.
        required = 12 * GIB + 10 * GIB + 2 * largest_log
        ready = now < 10 * GIB and free >= required
        ledger.update(status='READY_FOR_FULL_RERUN' if ready else 'ARCHIVED_BUT_SPACE_INSUFFICIENT',
                      foundation_bytes_after=now, free_bytes_after=free, required_free_bytes=required,
                      readiness_scope='Conservative storage admission bound, not a completion guarantee. Old absolute peak is diagnostic only; unchanged runner guards still apply. No Stata launched.')
        write_json(archive / 'ledger.json', ledger)
        return ledger


def dedupe_log(root, receipt_path, ledger_path, dry_run=False):
    root = Path(root).absolute(); ledger_path = Path(ledger_path).absolute()
    require(not ledger_path.is_relative_to(root), 'Ledger dedupe harus di luar foundation.')
    plan = inventory(root)
    p = safe(root, receipt_path)
    require(re.fullmatch(r'runtime/run-\d{8}T\d{6}Z/[A-Za-z0-9]+/receipt\.json', str(p.relative_to(root))), 'Receipt bukan attempt tahap.')
    r, rh = snapshot(p); completed(r, passed=True)
    require(safe(root, r['attempt']) == p.parent, 'Attempt receipt berbeda.')
    require(r['implementation_manifest_sha256'] == sha(safe(root, 'implementation-manifest.json')), 'Seal receipt sudah berbeda.')
    entry = safe(root, r['entry'])
    require(entry.name == p.parent.parent.name.replace('run-', 'run_WF_') + '_' + p.parent.name + '.do' and entry.parent == root, 'Entry bukan milik attempt.')
    hot = entry.with_suffix('.log'); keep = safe(root, str((p.parent / 'batch.log').relative_to(root)))
    result = {'receipt': str(p), 'receipt_sha256': rh, 'duplicate': str(hot), 'retained': str(keep)}
    if not hot.exists():
        return dict(result, status='ALREADY_ABSENT_NO_CHANGE')
    safe(root, hot.name)
    h = sha(keep); n = keep.stat().st_size
    relay = r.get('batch_relay', {})
    require(relay.get('status') == 'passed' and relay.get('sha256') == h and relay.get('bytes_streamed') == n, 'Log tidak cocok relay lengkap.')
    file_matches(hot, h, n)
    require(stat_key(hot)[:2] != stat_key(keep)[:2], 'Log memakai inode sama; tidak perlu dilepas.')
    protected = set(plan['protected_paths']); pinodes = set(map(tuple, plan['protected_inodes']))
    for q in [hot, keep]:
        require(str(q.resolve()) not in protected and stat_key(q)[:2] not in pinodes, 'Log berbenturan dengan input/code.')
    result.update(sha256=h, bytes=n, status='DRY_RUN_ONLY' if dry_run else 'VERIFIED_DUPLICATE_PENDING_UNLINK')
    if dry_run:
        return result
    require(ledger_path.parent.is_dir() and not ledger_path.is_symlink(), 'Folder ledger dedupe harus ada dan tanpa symlink.')
    with lock(root.parent / 'G0-rebuild/runtime/stata-owned.lock'), lock(ledger_path.with_suffix('.lock')):
        no_stata()
        completed(snapshot(p)[0], passed=True)
        prior = snapshot(ledger_path)[0] if ledger_path.exists() else {'events': []}
        # Pertahankan salinan lengkap dan bukti sebelum membuang duplikat.
        with keep.open('rb') as f:
            os.fsync(f.fileno())
        durable_dir(keep.parent)
        prior['events'].append(result); write_json(ledger_path, prior)
        require(sha(p) == rh, 'Receipt berubah sebelum dedupe.')
        completed(snapshot(p)[0], passed=True)
        file_matches(keep, h, n); file_matches(hot, h, n)
        controls_unchanged(root, plan)
        hot.unlink(); durable_dir(root)
        result['status'] = 'DUPLICATE_REMOVED_COMPLETE_ATTEMPT_LOG_RETAINED'
        write_json(ledger_path, prior)
        return result


def compact_stage(root, receipt_path, archive, expected_manifest, dry_run=False):
    """Antartahap saja: simpan satu objek gzip lengkap untuk setiap isi log."""
    root = Path(root).absolute(); archive = Path(archive).absolute()
    require(archive.parent == root.parent and archive != root and not archive.exists(), 'Arsip tahap harus sibling baru.')
    plan = inventory(root, expected_manifest)
    p = safe(root, receipt_path)
    require(re.fullmatch(r'runtime/run-\d{8}T\d{6}Z/[A-Za-z0-9]+/receipt\.json', str(p.relative_to(root))), 'Receipt bukan attempt tahap.')
    r, rh = snapshot(p); completed(r, passed=True)
    require(r['implementation_manifest_sha256'] == plan['implementation_manifest_sha256'], 'Seal tahap berbeda.')
    require(safe(root, r['attempt']) == p.parent, 'Attempt tahap berbeda.')
    entry = safe(root, r['entry'])
    require(entry.parent == root and entry.name == p.parent.parent.name.replace('run-', 'run_WF_') + '_' + p.parent.name + '.do', 'Entry berbeda dari attempt.')
    batch = safe(root, str((p.parent / 'batch.log').relative_to(root)))
    relay = r.get('batch_relay', {})
    require(relay.get('status') == 'passed', 'Relay log belum passed.')
    file_matches(batch, relay['sha256'], relay['bytes_streamed'])
    paths = [batch]
    duplicate = safe(root, entry.with_suffix('.log').name)
    if duplicate.exists():
        file_matches(duplicate, relay['sha256'], relay['bytes_streamed']); paths.append(duplicate)
    console = safe(root, str((p.parent / 'console.log').relative_to(root)))
    if console.exists():
        cr = r.get('console_relay', {})
        require(cr.get('status') == 'passed', 'Relay console belum passed.')
        file_matches(console, cr['sha256'], cr['bytes_streamed']); paths.append(console)
    tmp = exact_private_tmp(entry, r)
    protected = set(plan['protected_paths']); pinodes = set(map(tuple, plan['protected_inodes']))
    for q in paths + ([tmp] if tmp else []):
        require(str(q.resolve()) not in protected and stat_key(q)[:2] not in pinodes, 'Log bertabrakan dengan input/code.')
    if dry_run:
        return {'status': 'DRY_RUN_ONLY', 'paths': [str(q) for q in paths], 'exact_private_tmp': str(tmp) if tmp else None, 'archive': str(archive), 'no_files_changed': True}
    with lock(root.parent / 'G0-rebuild/runtime/stata-owned.lock'):
        no_stata(); completed(snapshot(p)[0], passed=True)
        require(sha(p) == rh, 'Receipt berubah sebelum pengarsipan log.')
        plan['controls'][str(p.relative_to(root))] = rh
        controls_unchanged(root, plan)
        archive.mkdir(mode=0o700); (archive / 'objects').mkdir(mode=0o700)
        durable_dir(archive.parent); durable_dir(archive)
        ledger = {'status': 'ARCHIVING_COMPLETED_STAGE_LOGS', 'foundation': str(root), 'receipt_sha256': rh,
                  'implementation_manifest_sha256': plan['implementation_manifest_sha256'], 'logical_paths': {}}
        ledger['logical_paths'][str(p.relative_to(root))] = dict(save_object(p, archive), disposition='retained_hot_metadata')
        # Seluruh salinan sudah dicadangkan dan diverifikasi sebelum salah satunya dilepas.
        for q in paths:
            ledger['logical_paths'][str(q.relative_to(root))] = dict(save_object(q, archive), disposition='verified_hot_pending_release')
            write_json(archive / 'ledger.json', ledger)
        if tmp is not None:
            key = 'external_private_tmp/' + tmp.name
            ledger['logical_paths'][key] = dict(save_object(tmp, archive), external_original_path=str(tmp), receipt_path=str(p.relative_to(root)), receipt_sha256=rh, disposition='verified_hot_pending_release')
            write_json(archive / 'ledger.json', ledger)
        for q in paths:
            rel = str(q.relative_to(root))
            release_hot(root, rel, ledger['logical_paths'][rel], archive, plan)
            ledger['logical_paths'][rel]['disposition'] = 'cold_exact_bytes'
            write_json(archive / 'ledger.json', ledger)
        if tmp is not None:
            key = 'external_private_tmp/' + tmp.name
            private_tmp_release(root, ledger['logical_paths'][key], archive, plan)
            ledger['logical_paths'][key]['disposition'] = 'cold_exact_bytes'
        ledger['status'] = 'COMPLETE_LOGS_COLD_EXACT_BYTES'
        write_json(archive / 'ledger.json', ledger)
        return ledger


def restore(archive, logical_path):
    archive = Path(archive).absolute()
    ledger, _ = snapshot(archive / 'ledger.json')
    require(logical_path in ledger['logical_paths'], 'Path tidak ada di katalog.')
    item = ledger['logical_paths'][logical_path]; root = Path(ledger['foundation'])
    if 'external_original_path' in item:
        out = Path(item['external_original_path'])
        rp = safe(root, item['receipt_path']); r, rh = snapshot(rp)
        require(rh == item['receipt_sha256'], 'Receipt restorasi tmp tidak cocok.')
        expected = Path('/private/tmp') / Path(r['entry']).with_suffix('.log').name
        require(logical_path == 'external_private_tmp/' + expected.name and out == expected and r['batch_relay']['source_path'] == str(out), 'Binding restorasi tmp tidak sah.')
        require(r['batch_relay']['sha256'] == item['sha256'] and r['batch_relay']['bytes_streamed'] == item['plain_bytes'], 'Hash restorasi tmp berbeda.')
        require(not out.is_symlink() and out.resolve() == out, 'Symlink restorasi tmp ditolak.')
    else:
        out = safe(root, logical_path)
    require(not out.exists(), 'Pemulihan tidak boleh menimpa hasil yang ada.')
    with lock(root.parent / 'G0-rebuild/runtime/stata-owned.lock'):
        no_stata()
        obj = safe(archive, item['object']); verify_object(obj, item['sha256'], item['plain_bytes'])
        require(out.parent.is_dir(), 'Folder pemulihan belum ada.')
        with tempfile.NamedTemporaryFile(dir=out.parent, prefix='.restore-', delete=False) as f:
            temp = Path(f.name)
            with gzip.open(obj, 'rb') as z:
                shutil.copyfileobj(z, f, 1024 * 1024)
            f.flush(); os.fsync(f.fileno())
        file_matches(temp, item['sha256'], item['plain_bytes'])
        # link() gagal jika tujuan muncul; tidak ada overwrite dalam perlombaan.
        os.link(temp, out); temp.unlink(); durable_dir(out.parent)
        return {'status': 'RESTORED_EXACT_BYTES', 'path': str(out), 'sha256': item['sha256']}


def main():
    ap = argparse.ArgumentParser(description=__doc__); sub = ap.add_subparsers(dest='command', required=True)
    for name in ['inventory', 'prepare']:
        s = sub.add_parser(name); s.add_argument('--foundation', required=True); s.add_argument('--manifest-sha256', required=True)
        if name == 'prepare':
            s.add_argument('--archive', required=True); s.add_argument('--dry-run', action='store_true')
    s = sub.add_parser('dedupe-log'); s.add_argument('--foundation', required=True); s.add_argument('--receipt', required=True); s.add_argument('--ledger', required=True); s.add_argument('--dry-run', action='store_true')
    s = sub.add_parser('compact-stage'); s.add_argument('--foundation', required=True); s.add_argument('--receipt', required=True); s.add_argument('--archive', required=True); s.add_argument('--manifest-sha256', required=True); s.add_argument('--dry-run', action='store_true')
    s = sub.add_parser('restore'); s.add_argument('--archive', required=True); s.add_argument('--logical-path', required=True)
    a = ap.parse_args()
    if a.command == 'inventory':
        out = inventory(a.foundation, a.manifest_sha256)
    elif a.command == 'prepare':
        out = prepare(a.foundation, a.archive, a.manifest_sha256, a.dry_run)
    elif a.command == 'dedupe-log':
        out = dedupe_log(a.foundation, a.receipt, a.ledger, a.dry_run)
    elif a.command == 'compact-stage':
        out = compact_stage(a.foundation, a.receipt, a.archive, a.manifest_sha256, a.dry_run)
    else:
        out = restore(a.archive, a.logical_path)
    print(json.dumps(out, indent=2))
    if out.get('status') == 'ARCHIVED_BUT_SPACE_INSUFFICIENT':
        raise SystemExit(2)


if __name__ == '__main__':
    main()
