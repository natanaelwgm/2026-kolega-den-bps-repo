#!/usr/bin/env python3
"""Verify the published context archive without running research or contacting a service.

Run from any directory. Use --verify-local-sources on the originating Mac to also
compare every discussion with the exact frozen prefix of its retained provider
source. Git pointer checks require the indexed main/PR commit objects locally.
"""
import argparse
from collections import Counter, defaultdict
from datetime import datetime
import hashlib
import json
from pathlib import Path
import re
import subprocess
import tempfile
from urllib.parse import unquote
from zoneinfo import ZoneInfo

from archive_discussions import SECRET_PATTERNS, clean_text, content_text, encoded, write_source

ROOT = Path(__file__).resolve().parents[1]
CONTEXT = ROOT / 'context'
TZ = ZoneInfo('Asia/Jakarta')
LIMIT = 1_000_000


def sha(data):
    return hashlib.sha256(data).hexdigest()


def blob(data):
    return hashlib.sha1(b'blob ' + str(len(data)).encode() + b'\0' + data).hexdigest()


def read_json(path):
    return json.loads(path.read_bytes())


def require(condition, message):
    if not condition:
        raise ValueError(message)


def checked_part(base, part):
    path = (base / part['path']).resolve()
    require(path.is_relative_to(base.resolve()), 'Part escaped its archive: ' + part['path'])
    data = path.read_bytes()
    require(len(data) <= LIMIT, 'Oversize archive part: ' + str(path))
    require(len(data) == part['bytes'], 'Part byte count mismatch: ' + str(path))
    require(sha(data) == part['sha256'], 'Part checksum mismatch: ' + str(path))
    return json.loads(data)


def frozen_discussions(source, receipt):
    """Read only the frozen prefix; an active source may have appended since then."""
    with Path(source['path']).open('rb') as stream:
        data = stream.read(receipt['frozen_source_bytes'])
    require(len(data) == receipt['frozen_source_bytes'], 'Source prefix shortened: ' + source['id'])
    require(sha(data) == receipt['frozen_source_sha256'], 'Source prefix changed: ' + source['id'])
    messages = {}
    for number, line in enumerate(data.splitlines(), 1):
        row = json.loads(line)
        payload = row.get('payload', {})
        item = payload.get('item', {})
        if source.get('provider') == 'hermes':
            if row.get('role') not in {'user', 'assistant'} or not row.get('content'):
                continue
            mid, text = str(row['id']), content_text(row['content'])
        elif row.get('type') == 'event_msg' and payload.get('type') == 'item_completed':
            if item.get('type') not in {'UserMessage', 'AgentMessage'}:
                continue
            if item['type'] == 'AgentMessage' and item.get('phase') not in {None, 'commentary', 'final_answer'}:
                continue
            mid, text = item.get('id') or f'line-{number}', content_text(item.get('content', []))
        elif row.get('type') == 'response_item' and payload.get('type') == 'agent_message':
            mid, text = payload.get('id') or f'line-{number}', content_text(payload.get('content', []))
        else:
            continue
        if text and mid not in messages:
            messages[mid] = (sha(text.encode()), clean_text(text)[0])
    return messages


def oversized_fixture():
    records = [
        {'id': 'large', 'role': 'user', 'timestamp': '2026-09-12T16:59:59Z',
         'content': ('猫 🐈 quote=" slash=\\\n' * 110000)},
        {'id': 'next-day', 'role': 'assistant', 'timestamp': '2026-09-12T17:00:00Z',
         'content': 'The date is now 13 September in Jakarta.'},
    ]
    source = {'id': 'verification-fixture', 'cwd': '/fixture', 'title': 'Oversized Unicode', 'workspace': 'fixture'}
    with tempfile.TemporaryDirectory(prefix='context-archive-verify-') as directory:
        base = Path(directory)
        result = write_source(source, records, {}, base, LIMIT)
        rebuilt = defaultdict(list)
        for part in result['parts']:
            value = checked_part(base, part)
            for record in value['messages']:
                rebuilt[record['id']].append(record)
        for original in records:
            pieces = sorted(rebuilt[original['id']], key=lambda r: r.get('content_part', 1))
            require(''.join(r['content'] for r in pieces) == original['content'], 'Unicode fixture reconstruction failed')
        require(len(rebuilt['large']) > 1, 'Oversized fixture was not split')
        require({p['date'] for p in result['parts']} == {'2026-09-12', '2026-09-13'}, 'Jakarta day boundary failed')
        return {'status': 'PASS', 'parts': len(result['parts']), 'largest_part_bytes': max(p['bytes'] for p in result['parts']),
                'covers': ['oversized single message', 'Unicode', 'quotes and backslashes', 'newlines', 'Jakarta midnight']}


def verify(local_sources):
    discussion_base = CONTEXT / 'discussions'
    index = read_json(discussion_base / 'index.json')
    sources = {s['id']: s for s in read_json(discussion_base / 'sources.json')['sources']}
    discussion_paths, source_ids = set(), set()
    message_count = 0
    for source in index['sources']:
        sid = source['source_id']
        require(sid not in source_ids, 'Repeated source ID: ' + sid)
        source_ids.add(sid)
        require(not source['parse_errors'], 'Provider parse errors: ' + sid)
        by_message = defaultdict(list)
        for part in source['parts']:
            require(part['path'] not in discussion_paths, 'Repeated discussion part')
            discussion_paths.add(part['path'])
            value = checked_part(discussion_base, part)
            require(value['source']['source_id'] == sid, 'Wrong source in discussion part')
            require(value['date'] == part['date'] and value['part'] == part['part'], 'Wrong day/part metadata')
            require(len(value['messages']) == part['message_fragments'], 'Wrong fragment count')
            for message in value['messages']:
                require(message['role'] in {'user', 'assistant', 'agent_to_agent'}, 'Unexpected archived role')
                stamp = datetime.fromisoformat(message['timestamp'].replace('Z', '+00:00'))
                require(stamp.astimezone(TZ).date().isoformat() == value['date'], 'Wrong Jakarta discussion date')
                by_message[message['id']].append(message)
        originals = frozen_discussions(sources[sid], source) if local_sources else None
        require(len(by_message) == source['messages'], 'Wrong source message count: ' + sid)
        if originals is not None:
            require(set(originals) == set(by_message), 'Frozen-source coverage mismatch: ' + sid)
        roles = Counter()
        for mid, fragments in by_message.items():
            fragments.sort(key=lambda r: r.get('content_part', 1))
            expected = fragments[0].get('content_parts', 1)
            require([r.get('content_part', 1) for r in fragments] == list(range(1, expected + 1)), 'Missing/duplicate message fragment')
            require(all(r.get('content_parts', 1) == expected for r in fragments), 'Fragment total mismatch')
            text = ''.join(r['content'] for r in fragments)
            roles[fragments[0]['role']] += 1
            require(all(r['source_content_sha256'] == fragments[0]['source_content_sha256'] for r in fragments), 'Fragment source checksum mismatch')
            if originals is not None:
                require(originals[mid] == (fragments[0]['source_content_sha256'], text), 'Frozen-source text mismatch: ' + sid + ':' + mid)
            elif not any(r.get('redactions') for r in fragments):
                require(sha(text.encode()) == fragments[0]['source_content_sha256'], 'Reconstructed source checksum mismatch')
        require(dict(roles) == source['roles'], 'Role count mismatch: ' + sid)
        message_count += len(by_message)
    require(source_ids == set(sources), 'Source manifest mismatch')
    require(len(source_ids) == index['source_count'] and message_count == index['messages'], 'Discussion totals mismatch')
    require(len(discussion_paths) == index['parts'], 'Discussion part total mismatch')
    actual_parts = {p.relative_to(discussion_base).as_posix() for p in discussion_base.rglob('*--part-*.json')}
    require(actual_parts == discussion_paths, 'Unindexed or missing discussion parts')

    file_base = CONTEXT / 'files'
    files_index = read_json(file_base / 'index.json')
    extra_base = file_base / 'worktree-extras'
    extra_index = read_json(extra_base / 'index.json')
    inventories = [(file_base, files_index['parts'], files_index['files_in_inventory'], files_index['status_counts'], 'main')]
    inventories += [(extra_base, w['parts'], w['extra_files'], w['extra_status_counts'], w['name']) for w in extra_index['worktrees']]
    file_rows, catalog_paths = [], set()
    for base, parts, total, counts, label in inventories:
        rows = []
        for part in parts:
            value = checked_part(base, part)
            require(len(value['files']) == part['files'], 'Wrong file count: ' + label)
            path = base / part['path']
            require(path not in catalog_paths, 'Repeated file-catalog part')
            catalog_paths.add(path)
            rows.extend(value['files'])
        require(len(rows) == total and dict(Counter(r['status'] for r in rows)) == counts, 'File-catalog totals mismatch: ' + label)
        require(len({(r.get('source', r.get('worktree')), r['path']) for r in rows}) == len(rows), 'Duplicate local paths: ' + label)
        file_rows.extend(rows)
    expected_extra = len(file_rows) - files_index['files_in_inventory']
    require(expected_extra == extra_index['extra_files'], 'Extra file total mismatch')
    actual_catalog = set(file_base.glob('*/files-*.json')) | set(extra_base.glob('*-[0-9][0-9][0-9].json'))
    require(actual_catalog == catalog_paths, 'Unindexed or missing file-catalog parts')

    revisions = sorted({r['github_revision'] for r in file_rows if r.get('github_revision')})
    trees = {}
    for revision in revisions:
        raw = subprocess.check_output(['git', 'ls-tree', '-r', '-z', revision], cwd=ROOT)
        entries = {}
        for item in raw.split(b'\0'):
            if item:
                meta, name = item.split(b'\t', 1)
                entries[name.decode()] = meta.split()[2].decode()
        trees[revision] = entries
    snapshot_paths, hashes = set(), {}
    github_pointers = 0
    for row in file_rows:
        relative = row.get('github_path')
        if not relative:
            continue
        if row.get('github_revision'):
            require(trees[row['github_revision']].get(relative) == row['git_blob'], 'Git pointer content mismatch: ' + relative)
            github_pointers += 1
        else:
            path = (ROOT / relative).resolve()
            require(path.is_relative_to(CONTEXT / 'file-snapshots'), 'Snapshot escaped archive: ' + relative)
            if relative not in hashes:
                data = path.read_bytes()
                hashes[relative] = (sha(data), blob(data))
            if row.get('archived_sha256'):
                require(hashes[relative][0] == row['archived_sha256'], 'Snapshot checksum mismatch: ' + relative)
            if not row.get('redactions'):
                require(hashes[relative][1] == row['git_blob'], 'Snapshot original blob mismatch: ' + relative)
            snapshot_paths.add(relative)
    actual_snapshots = {p.relative_to(ROOT).as_posix() for p in (CONTEXT / 'file-snapshots').rglob('*') if p.is_file()}
    require(actual_snapshots == snapshot_paths | {'context/file-snapshots/README.md'}, 'Unindexed or missing file snapshots')

    meetings = read_json(CONTEXT / 'meetings/index.json')
    for item in meetings['files']:
        path = CONTEXT / 'meetings' / item['path']
        data = path.read_bytes()
        require(len(data) == item['bytes'] and sha(data) == item['sha256'], 'Meeting-source copy mismatch: ' + item['path'])

    forbidden = {'.dta', '.dbf', '.parquet', '.feather', '.arrow', '.rds', '.rdata', '.sav', '.sas7bdat', '.sqlite', '.sqlite3', '.db', '.zip', '.7z', '.mp4', '.m4a', '.mp3', '.wav', '.log', '.jsonl'}
    secret_patterns = [re.compile(pattern) for pattern in SECRET_PATTERNS] + [re.compile(r'\bAIza[A-Za-z0-9_-]{30,}')]
    screened = 0
    for path in CONTEXT.rglob('*'):
        if not path.is_file():
            continue
        require(not path.is_symlink(), 'Archive symlink: ' + str(path))
        require(path.suffix.lower() not in forbidden and path.name not in {'.env', '_chat.txt'}, 'Excluded payload in context: ' + str(path))
        require(path.stat().st_size < 30_000_000, 'Unexpectedly large context file: ' + str(path))
        try:
            text = path.read_text()
        except UnicodeError:
            continue
        require(not any(p.search(text) for p in secret_patterns), 'Credential pattern found in: ' + str(path))
        screened += 1

    links_checked = 0
    for path in CONTEXT.rglob('*.md'):
        if path.is_relative_to(CONTEXT / 'file-snapshots') and path != CONTEXT / 'file-snapshots/README.md':
            continue
        if path.is_relative_to(CONTEXT / 'meetings') and path != CONTEXT / 'meetings/README.md':
            continue
        text = re.sub(r'```[\s\S]*?```', '', path.read_text())
        for target in re.findall(r'\[[^\]]*\]\(([^)]+)\)', text):
            target = unquote(target.strip('<>').split('#')[0])
            if not target or target.startswith(('https:', 'http:', 'mailto:', 'codex:')):
                continue
            resolved = (path.parent / target).resolve()
            require(resolved.exists() or resolved == CONTEXT / 'verification.json', 'Broken archive navigation: ' + str(path) + ' -> ' + target)
            links_checked += 1
    return {
        'timestamp': datetime.now(TZ).isoformat(), 'status': 'PASS',
        'discussion_sources': len(source_ids), 'discussion_messages': message_count,
        'discussion_parts': len(discussion_paths), 'largest_discussion_part_bytes': max(p['bytes'] for s in index['sources'] for p in s['parts']),
        'frozen_provider_sources_verified': len(source_ids) if local_sources else 0,
        'file_inventory_entries': len(file_rows), 'file_inventory_parts': len(catalog_paths),
        'largest_file_inventory_part_bytes': max(p['bytes'] for _, parts, _, _, _ in inventories for p in parts),
        'immutable_git_revisions_checked': revisions, 'immutable_git_file_pointers_checked': github_pointers,
        'unique_file_snapshots_checked': len(snapshot_paths), 'meeting_file_hashes_checked': len(meetings['files']),
        'text_files_screened_for_credential_patterns': screened, 'new_archive_navigation_links_checked': links_checked,
        'oversized_message_fixture': oversized_fixture(), 'analysis_executed': False,
        'limits': ['Only identified retained sources are represented; see COVERAGE.md.',
                   'A checksum proves byte identity, not scientific validity.',
                   'Credential pattern checks supplement the recorded source screening; they are not a guarantee against every possible secret format.'],
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--verify-local-sources', action='store_true')
    args = parser.parse_args()
    try:
        result = verify(args.verify_local_sources)
    except (ValueError, OSError, KeyError, subprocess.CalledProcessError) as error:
        result = {'timestamp': datetime.now(TZ).isoformat(), 'status': 'FAIL', 'error': str(error), 'analysis_executed': False}
    (CONTEXT / 'verification.json').write_bytes(encoded(result))
    print(json.dumps(result, ensure_ascii=False, indent=2))
    return 0 if result['status'] == 'PASS' else 1


if __name__ == '__main__':
    raise SystemExit(main())
