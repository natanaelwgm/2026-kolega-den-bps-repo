"""Install only reviewed WFDOC comment lines; never regenerate scientific or logging code."""
from pathlib import Path
import collections
import datetime
import hashlib
import json
import shutil

HERE = Path(__file__).resolve().parent
F = HERE.parents[1] / 'G0-wave-foundation-v2'
PAYLOAD_SHA = '900dc4dd50f41b693a0cfd76892628dafc059782be7f63f0c531e172cce65aa8'
CORE_SHA = '39e3a264384b6522d15bf4bc25befd0047563bd88766933a4cde77fc32a8b306'
RD_SHA = 'e298efd96bd3dc3d99c3c63e99148d8bfe15201c40f1b0ea9b387e583f58fee0'
SUPPLEMENT_SHA = 'c28cd61065296565f3f9f088766186fedfa967b2f92fbcbbf69bb674a42eb74d'
HISTORY = F / 'provenance/wfdoc-final-20260913'
EVIDENCE = F / 'implementation-review/wfdoc-final'


def digest(data):
    return hashlib.sha256(data).hexdigest()


def sha(path):
    return digest(Path(path).read_bytes())


def write_json(path, obj):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(obj, indent=2, ensure_ascii=False) + '\n')


def non_wfdoc(data):
    out = []
    for line in data.splitlines(keepends=True):
        if b'WFDOC-INJECTED' in line:
            assert line.lstrip().startswith(b'*'), 'Executable WFDOC marker rejected'
        else:
            out.append(line)
    return b''.join(out)


def science_projection(data):
    return b''.join(line for line in non_wfdoc(data).splitlines(keepends=True)
                    if b'WFLOG-INJECTED' not in line)


def current_v090_entry(entry, science):
    """The passed worker-key comparison supersedes the old archived line anchors."""
    entry = dict(entry)
    entry['source_sha256'] = digest(science)
    entry['header_comments'] = [
        '* Tujuan: Bandingkan seluruh nilai pada 30 tabel agregat baru dengan tabel pembanding yang sudah dipatok.',
        '* Input: tabel dalam corrections/reports dan pasangan pembandingnya dalam G0-rebuild/corrections/reports.',
        '* Output: tanda kelulusan WF_REPORT_VALUES_30_EXACT; tahap ini hanya memeriksa hasil, bukan menghitung estimasi baru.',
        '* Untuk tabel penyebut pekerja, cocokkan kunci source_year/ratio lalu urutkan kedua sisi agar urutan baris tidak menjadi perbedaan palsu.',
        '* Jika nilai, kunci, atau syarat lain berbeda, pemeriksaan berhenti dan hasil belum dinyatakan lulus.',
    ]
    notes = []
    for i, line in enumerate(science.decode().splitlines(), 1):
        text = line.strip()
        comment = None
        if text.startswith('cf '):
            comment = '* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan.'
        elif text.startswith('isid source_year ratio'):
            comment = '* Pastikan setiap pasangan tahun dan rasio hanya muncul sekali sebelum membandingkan tabel.'
        elif text.startswith('sort source_year ratio'):
            comment = '* Urutkan menurut kunci tahun dan rasio yang sama pada kedua tabel; jangan mengubah nilai tabel.'
        elif text.startswith('tempfile sorted_worker_witness'):
            comment = '* Sediakan nama berkas sementara untuk pembanding pekerja yang sudah diurutkan.'
        elif text == 'preserve':
            comment = '* Simpan sementara tabel baru di memori ketika menyiapkan urutan pembanding.'
        elif text.startswith('save `sorted_worker_witness'):
            comment = '* Simpan pembanding yang sudah diurutkan agar pemeriksaan berikutnya memakai pasangan baris yang tepat.'
        elif text == 'restore':
            comment = '* Kembalikan tabel baru ke memori, lalu bandingkan dengan pembanding yang sudah diurutkan.'
        if comment:
            notes.append({'line': i, 'comment': comment})
    assert sum(line.lstrip().startswith(b'cf ') for line in science.splitlines()) == 30
    entry['block_notes'] = notes
    entry['anchor_adaptation'] = 'Current passed V090 worker-key comparison; comments only.'
    return entry


def install():
    assert sha(HERE / 'comment-manifest.json') == PAYLOAD_SHA
    assert sha(F / 'implementation-manifest.json') == CORE_SHA
    assert sha(F / 'rd2017/implementation-manifest.json') == RD_SHA
    assert not HISTORY.exists(), 'Preserve the previous installation; do not overwrite it.'
    payload = json.loads((HERE / 'comment-manifest.json').read_text())
    assert sha(HERE / 'supplemental-final-notes.json') == SUPPLEMENT_SHA
    supplement = json.loads((HERE / 'supplemental-final-notes.json').read_text())
    assert supplement['main_manifest_sha256'] == PAYLOAD_SHA
    supplement_by_path = {x['path']: x for x in supplement['supplemental_entries']}
    core = json.loads((F / 'implementation-manifest.json').read_text())
    rd = json.loads((F / 'rd2017/implementation-manifest.json').read_text())
    instrumentation = json.loads((F / 'registry/instrumentation-manifest.json').read_text())
    old_core = json.loads(json.dumps(core))
    old_rd = json.loads(json.dumps(rd))
    entries = {x['path']: x for x in payload['entries']}
    entries.update({x['path']: x for x in payload['supplemental_original_projections']})
    paths = {x['path'] for x in instrumentation['files']}
    assert len(paths) == 6306 and paths == set(entries)
    core_pins = {x['path']: x for x in core['code_files']}
    rd_pins = {'rd2017/' + x['path']: x for x in rd['files']}
    expected = {**core_pins, **rd_pins}
    prepared = {}
    adapted = []
    for rel in sorted(paths):
        target = F / rel
        assert target.is_file() and not target.is_symlink()
        before = target.read_bytes()
        assert digest(before) == expected[rel]['sha256'], rel
        scientific = science_projection(before)
        entry = entries[rel]
        if rel == 'code/validation/compare_reports.do':
            entry = current_v090_entry(entry, scientific)
            adapted.append(entry)
        if rel in supplement_by_path:
            extra = supplement_by_path[rel]
            assert extra['source_sha256'] == digest(scientific)
            entry = dict(entry)
            entry['header_comments'] = extra['header_comments']
            entry['block_notes'] = entry['block_notes'] + extra['block_notes']
        assert digest(scientific) == entry['source_sha256'], rel
        headers = entry['header_comments']
        assert headers or entry.get('existing_source_header'), rel
        notes = collections.defaultdict(list)
        scientific_lines = scientific.splitlines(keepends=True)
        for item in entry['block_notes']:
            assert 1 <= item['line'] <= len(scientific_lines), rel
            notes[item['line']].append(item['comment'])
        for comment in headers + [x for values in notes.values() for x in values]:
            assert comment.startswith('* ') and '\n' not in comment and '\r' not in comment
            assert 'WFDOC-INJECTED' not in comment
        out = [(x + ' // WFDOC-INJECTED\n').encode() for x in headers]
        n = 0
        for line in non_wfdoc(before).splitlines(keepends=True):
            if b'WFLOG-INJECTED' not in line:
                n += 1
                out.extend((x + ' // WFDOC-INJECTED\n').encode() for x in notes[n])
            out.append(line)
        after = b''.join(out)
        assert n == len(scientific_lines)
        assert non_wfdoc(before) == non_wfdoc(after)
        assert science_projection(before) == science_projection(after)
        prepared[rel] = (before, after, entry)

    # Complete all validation before the first operative write.
    controls = ['implementation-manifest.json', 'implementation-review/static-review.json',
                'registry/instrumentation-manifest.json', 'rd2017/implementation-manifest.json',
                'rd2017/implementation-review/static-review.json', 'runtime/latest.json',
                'runtime/wave-output-manifest.json', 'rd2017/runtime/latest.json']
    for rel in controls + sorted(paths):
        dest = HISTORY / rel
        dest.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(F / rel, dest)
        assert sha(dest) == sha(F / rel)
    for name in ['comment-manifest.json', 'supplemental-final-notes.json', 'samples.json', 'build_comments.py', 'install_final_wfdoc.py']:
        shutil.copy2(HERE / name, HISTORY / name)
    for rel, (before, after, entry) in prepared.items():
        assert (F / rel).read_bytes() == before
        (F / rel).write_bytes(after)

    now = datetime.datetime.now(datetime.timezone.utc).isoformat()
    coverage = []
    for record in instrumentation['files']:
        rel = record['path']
        before, after, entry = prepared[rel]
        assert (F / rel).read_bytes() == after
        record.update(instrumented_sha256=digest(after), instrumented_bytes=len(after))
        coverage.append({'path': rel, 'old_sha256': digest(before), 'new_sha256': digest(after),
                         'non_wfdoc_sha256': digest(non_wfdoc(after)),
                         'header_comments': len(entry['header_comments']),
                         'block_notes': len(entry['block_notes']),
                         'non_wfdoc_bytes_exact': True,
                         'old_preserved_path': str((HISTORY / rel).relative_to(F))})
    instrumentation.update(comment_manifest=str((HERE / 'comment-manifest.json').resolve()),
                           comment_manifest_sha256=PAYLOAD_SHA, comments_refreshed_utc=now,
                           files_count=len(paths), block_count=sum(len(x['blocks']) for x in instrumentation['files']),
                           status='WFDOC_UPDATED_ALL_NON_WFDOC_BYTES_EXACT_PENDING_ROOT_REVIEW',
                           wfdoc_final_install={'files': len(paths), 'header_comments': sum(x['header_comments'] for x in coverage),
                                                'block_notes': sum(x['block_notes'] for x in coverage),
                                                'supplemental_final_notes_sha256': SUPPLEMENT_SHA,
                                                'all_non_wfdoc_bytes_exact': True,
                                                'current_V090_anchors_adapted': True,
                                                'RD_compact_globals_preserved': 2352})
    write_json(F / 'registry/instrumentation-manifest.json', instrumentation)
    for x in core['code_files']:
        p = F / x['path']; x.update(sha256=sha(p), bytes=p.stat().st_size)
    core.update(status='COMMENTED_IMPLEMENTATION_PINNED', created_utc=now)
    assert core['input_files'] == old_core['input_files']
    assert [x['path'] for x in core['code_files']] == [x['path'] for x in old_core['code_files']]
    write_json(F / 'implementation-manifest.json', core)
    for x in rd['files']:
        p = F / 'rd2017' / x['path']; x.update(sha256=sha(p), bytes=p.stat().st_size)
    for x in rd['external_code_files']:
        p = F / x['path']; x.update(sha256=sha(p), bytes=p.stat().st_size)
    rd['status'] = 'COMMENTED_IMPLEMENTATION_PINNED'
    write_json(F / 'rd2017/implementation-manifest.json', rd)
    core_sha = sha(F / 'implementation-manifest.json')
    rd_sha = sha(F / 'rd2017/implementation-manifest.json')
    changed = []
    for old, new in zip(old_core['code_files'], core['code_files']):
        assert old['path'] == new['path']
        if old['sha256'] != new['sha256']:
            item = {'path': old['path'], 'old_sha256': old['sha256'], 'new_sha256': new['sha256'],
                    'old_preserved_path': str((HISTORY / old['path']).relative_to(F)),
                    'kind': 'comments_only' if old['path'].endswith('.do') else 'metadata_only'}
            if item['kind'] == 'metadata_only':
                assert old['path'] == 'registry/instrumentation-manifest.json'
                item['not_a_numerical_operand'] = True
            changed.append(item)
    delta = {'status': 'PENDING_ROOT_REVIEW_COMMENT_METADATA_CONTINUITY', 'created_utc': now,
             'old_implementation_manifest_sha256': CORE_SHA,
             'current_implementation_manifest_sha256': core_sha, 'changed_files': changed,
             'code_path_set_unchanged': True, 'input_files_identical': True,
             'plan_freeze_and_stata_hashes_unchanged': True}
    write_json(EVIDENCE / 'core-delta.json', delta)
    rd_changed = [{'path': old['path'], 'old_sha256': old['sha256'], 'new_sha256': new['sha256'],
                   'kind': 'comments_only', 'old_preserved_path': str((HISTORY / 'rd2017' / old['path']).relative_to(F))}
                  for old, new in zip(old_rd['files'], rd['files']) if old['sha256'] != new['sha256']]
    assert all(x['path'].endswith('.do') for x in rd_changed)
    write_json(EVIDENCE / 'rd-delta.json', {'status': 'PENDING_ROOT_REVIEW_COMMENT_METADATA_CONTINUITY',
               'old_implementation_manifest_sha256': RD_SHA, 'current_implementation_manifest_sha256': rd_sha,
               'changed_files': rd_changed, 'external_core_manifest_only_updated': True,
               'prior_external_code_files': old_rd['external_code_files'],
               'current_external_code_files': rd['external_code_files']})
    write_json(EVIDENCE / 'coverage.json', {'status': 'PASS_COMMENT_ONLY_INSTALLATION', 'files': coverage,
               'files_count': len(paths), 'header_comments': sum(x['header_comments'] for x in coverage),
               'block_notes': sum(x['block_notes'] for x in coverage), 'source_payload_sha256': PAYLOAD_SHA,
               'supplemental_final_notes_sha256': SUPPLEMENT_SHA,
               'supplemental_entries_used': len(payload['supplemental_original_projections']),
               'adapted_current_source_entries': adapted})
    latest = json.loads((F / 'runtime/latest.json').read_text())
    assert latest['status'] == 'passed' and latest['owned_process_exited'] and latest['implementation_manifest_sha256'] == CORE_SHA
    descriptor = {'status': 'PENDING_ROOT_REVIEW', 'reviewer': None,
                  'current_implementation_manifest_sha256': core_sha,
                  'prior_execution_manifest_path': str((HISTORY / 'implementation-manifest.json').relative_to(F)),
                  'prior_execution_manifest_sha256': CORE_SHA,
                  'final_receipt_path': latest['attempt'] + '/receipt.json',
                  'final_receipt_sha256': sha(F / 'runtime/latest.json'),
                  'wave_output_manifest_sha256': sha(F / 'runtime/wave-output-manifest.json'),
                  'reviewed_delta_manifest_path': str((EVIDENCE / 'core-delta.json').relative_to(F)),
                  'reviewed_delta_manifest_sha256': sha(EVIDENCE / 'core-delta.json'),
                  'delta_classes': ['comments_only', 'metadata_only'],
                  'reviewed_metadata_paths': ['registry/instrumentation-manifest.json']}
    write_json(EVIDENCE / 'storage-replay-continuity-template.json', descriptor)
    write_json(EVIDENCE / 'installation-summary.json', {'status': 'PASS_COMMENT_ONLY_INSTALLATION_PENDING_ROOT_REVIEW',
               'core_manifest_sha256': core_sha, 'rd_manifest_sha256': rd_sha,
               'files': len(paths), 'header_comments': sum(x['header_comments'] for x in coverage),
               'block_notes': sum(x['block_notes'] for x in coverage),
               'core_changed_files': len(changed), 'RD_changed_files': len(rd_changed),
               'all_non_WFDOC_bytes_exact': True, 'no_Stata_run': True,
               'core_execution_receipt_unchanged': sha(F / 'runtime/latest.json') == sha(HISTORY / 'runtime/latest.json'),
               'RD_execution_receipt_unchanged': sha(F / 'rd2017/runtime/latest.json') == sha(HISTORY / 'rd2017/runtime/latest.json')})
    print(json.dumps({'core_sha256': core_sha, 'RD_sha256': rd_sha, 'coverage': len(paths),
                      'core_delta': len(changed), 'RD_delta': len(rd_changed), 'evidence': str(EVIDENCE)}))


if __name__ == '__main__':
    install()
