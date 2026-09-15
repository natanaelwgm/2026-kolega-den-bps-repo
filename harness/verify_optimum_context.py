#!/usr/bin/env python3
"""Check the documented Optimum projection against repository evidence and contracts."""
from collections import Counter
from datetime import datetime
import hashlib
import json
from pathlib import Path
import re
from urllib.parse import unquote
from zoneinfo import ZoneInfo

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / 'context/optimum-harness'


def read(path):
    return json.loads(path.read_text())


def check(condition, message):
    if not condition:
        raise ValueError(message)


def verify():
    model = read(OUT / 'model.json')
    rows = read(ROOT / 'requests/registry.json')
    projection = read(OUT / 'work-items.json')
    source = {r['request_id']: r for r in rows}
    cards = {p.stem for p in (OUT / 'work-items').glob('*.md')}
    check(len(rows) == 44 and cards == set(source), 'Missing or extra source-row cards')
    check({r['source_row_id'] for r in projection['source_rows']} == set(source), 'Work-item projection source IDs differ')
    check(len(projection['source_rows']) == 44, 'Repeated work-item source IDs')
    check(source['G21a']['source_number'] == source['G21b']['source_number'] == '21', 'Original duplicate source number lost')
    check(all(r['source_completion_cell'] == '' for r in rows), 'Original completion cells changed')
    pic = dict(Counter(r['source_pic'].strip() or '(blank)' for r in rows))
    check(pic == {'Waran': 1, '(blank)': 6, 'Toar': 15, 'Schalke': 22}, 'Original PIC counts changed')
    for projected in projection['source_rows']:
        rid = projected['source_row_id']
        original = source[rid]
        for target, key in [('source_request_exact', 'source_request'), ('source_strategy_exact', 'source_strategy'),
                            ('source_notes_exact', 'source_notes'), ('source_pic_exact', 'source_pic'),
                            ('source_number', 'source_number'), ('source_completion_cell', 'source_completion_cell'),
                            ('source_locator', 'source_locator'), ('definition_of_done', 'definition_of_done')]:
            check(projected[target] == original[key], 'Word/contract projection mismatch: ' + rid + ':' + key)
        plan = read(ROOT / projected['current_plan_path'])
        check(plan['row_id'] == rid and plan['row_complete'] == projected['plan_row_complete'], 'Plan identity/status mismatch: ' + rid)
        check(projected['planned_node_count'] == len(plan['nodes']), 'Planned process count mismatch: ' + rid)
        check(projected['planned_exhibit_count'] == len(plan['exhibits']), 'Planned exhibit count mismatch: ' + rid)
        check(projected['planned_decision_count'] == len(plan['decisions']), 'Planned rule count mismatch: ' + rid)
        check(projected['full_row_completion_claim'] is False, 'Unsupported row completion claim: ' + rid)

    allowed = {}
    for relation, source_types, target_types in re.findall(r'^\| `([^`]+)` \| ([^|]+)→([^|]+) \|', (OUT / 'reference/contracts/relationships.md').read_text(), flags=re.M):
        allowed[relation] = {(s.strip(), t.strip()) for s in source_types.split('·') for t in target_types.split('·')}
    check(len(allowed) == 20, 'Unexpected relationship contract; review projection')
    nodes = {(n['type'], n['id']): n for n in model['nodes']}
    check(len(nodes) == len(model['nodes']), 'Duplicate primitive ID/type')
    check(len({n['id'] for n in model['nodes']}) == len(nodes), 'Duplicate identifier across primitives')
    counts = dict(Counter(n['type'] for n in model['nodes']))
    check(counts == model['counts'], 'Primitive count mismatch')
    check(counts['work_item'] == 46 and counts['workstream'] == 1, 'Expected 44 rows, G0.5 and one integration parent in one workstream')
    check(model['operational_extension_work_items'] == 1, 'Missing G0.5 extension count')
    check([x['id'] for x in projection['operational_extensions']] == ['WI-deasy-imed-g05'], 'Unexpected operational extension')
    check(nodes[('work_item', 'WI-deasy-imed-g05')]['source_row'] is False, 'G0.5 must not impersonate a Word row')
    check(set(counts) == {'workstream', 'work_item', 'communication', 'session', 'artifact', 'decision', 'share', 'actor'}, 'Unknown primitive type')
    seen, members = set(), set()
    for edge in model['relationships']:
        st, sid, relation, tt, tid = (edge[k] for k in ['source_type', 'source_id', 'link_type', 'target_type', 'target_id'])
        key = st, sid, relation, tt, tid
        check(key not in seen, 'Duplicate relationship: ' + str(key)); seen.add(key)
        check(relation in allowed and (st, tt) in allowed[relation], 'Invalid relationship shape: ' + str(key))
        check((st, sid) in nodes and (tt, tid) in nodes, 'Dangling relationship: ' + str(key))
        check(bool(edge['source_ref'] and edge['evidence_quote'] and edge['basis']), 'Missing relationship provenance')
        check((ROOT / edge['source_ref']).is_file(), 'Missing edge source: ' + edge['source_ref'])
        if relation == 'belongs_to':
            members.add((st, sid))
    for key, value in nodes.items():
        if key[0] not in {'actor', 'workstream'}:
            check(key in members, 'Non-actor node missing workstream membership: ' + str(key))
        if key[0] == 'decision' and value['status'] != 'needed':
            check(bool(value.get('source_quote')), 'Uncited accepted decision: ' + value['id'])
            check(value['source_quote'] in (ROOT / value['source']).read_text(), 'Decision quotation is not verbatim: ' + value['id'])
        if key[0] == 'session':
            check(value['ended_at'] is None, 'Retained session invented an end time')
        if key[0] == 'actor':
            check(value['actor_type'] in {'person', 'org'} and 'contact' not in value, 'Unexpected actor type/contact data')

    dev_users = {e['source_id'] for e in model['relationships'] if e['source_type'] == 'work_item'
                 and e['link_type'] == 'uses' and e['target_id'] == 'ART-deasy-imed-g05-development'}
    check(dev_users == {'WI-deasy-imed-' + rid.lower() for rid in source if rid != 'G0'}, 'G0.5 downstream dataflow coverage differs')
    for row in projection['source_rows']:
        policy = row['execution_input_policy']
        check(policy['development_mode'] == ('local_actual_preparation' if row['source_row_id'] == 'G0' else 'development'), 'Wrong default input mode')
        check(policy['fallback_to_historical_actual_Git_data'] is False, 'Historical actual fallback allowed')

    stored = 0
    for node in nodes.values():
        for item in node.get('stored_files', []):
            data = (ROOT / item['path']).read_bytes()
            check(len(data) == item['bytes'] and hashlib.sha256(data).hexdigest() == item['sha256'], 'Artifact byte mismatch: ' + item['path'])
            stored += 1
    for item in read(OUT / 'reference/source-manifest.json'):
        data = (ROOT / item['snapshot']).read_bytes()
        check(len(data) == item['bytes'] and hashlib.sha256(data).hexdigest() == item['sha256'], 'Contract snapshot changed: ' + item['snapshot'])

    expected_discussions = read(ROOT / 'context/discussions/index.json')
    expected_groups = {(s['source_id'], p['date']) for s in expected_discussions['sources'] for p in s['parts']}
    groups = {(n['source_id'], n['date']) for n in nodes.values() if n['type'] == 'communication' and n.get('source_id')}
    check(groups == expected_groups, 'Discussion source/day coverage mismatch')
    session_ids = {n['source_id'] for n in nodes.values() if n['type'] == 'session'}
    check(session_ids == {s['source_id'] for s in expected_discussions['sources']}, 'Session source coverage mismatch')
    expected_shares = 1 + int(nodes[('work_item', 'WI-deasy-imed-g05')]['status'] == 'complete')
    check(sum(n['type'] == 'share' for n in nodes.values()) == expected_shares, 'Share count changed without new receipt')
    if expected_shares == 2:
        receipt = read(ROOT / 'work-items/G0.5/publication-verification.json')
        share = nodes[('share', 'SHARE-deasy-imed-g05-github-20260913')]
        check(receipt['status'] == 'PASS' and share['commit'] == receipt['remote_main'], 'G0.5 delivery receipt mismatch')
        check(receipt['manifest_sha256'] == hashlib.sha256((ROOT / 'data/g0-5-development/manifest.json').read_bytes()).hexdigest(), 'G0.5 delivery data version differs')
        check(len(receipt['verified_development_parts']) == 28, 'Incomplete delivery part coverage')

    links = 0
    for path in OUT.rglob('*.md'):
        text = re.sub(r'```[\s\S]*?```', '', path.read_text())
        for target in re.findall(r'\[[^\]]*\]\(([^)]+)\)', text):
            target = unquote(target.strip('<>').split('#')[0])
            if not target or re.match(r'^[a-z]+:', target):
                continue
            resolved = (path.parent / target).resolve()
            check(resolved.exists() or resolved == OUT / 'verification.json', 'Broken handbook link: ' + str(path.relative_to(ROOT)) + ' -> ' + target)
            links += 1
    check((OUT / 'model.json').stat().st_size <= 1_000_000, 'Model JSON requires chunking')
    return {'timestamp': datetime.now(ZoneInfo('Asia/Jakarta')).isoformat(), 'status': 'PASS',
            'source_word_rows': 44, 'work_item_cards': len(cards), 'pic_counts': pic,
            'all_source_word_fields_preserved': True, 'all_completion_cells_preserved': True,
            'primitive_counts': counts, 'registered_relationship_types': len(allowed),
            'relationships_checked': len(seen), 'dangling_or_duplicate_relationships': 0,
            'artifact_stored_file_hashes_checked': stored, 'contract_snapshots_checked': 13,
            'discussion_source_day_groups': len(groups), 'source_sessions': len(session_ids),
            'markdown_files': len(list(OUT.rglob('*.md'))), 'navigation_links_checked': links,
            'model_json_bytes': (OUT / 'model.json').stat().st_size,
            'live_harness_databases_modified': False, 'analysis_executed': False}


def main():
    try:
        result = verify()
    except (ValueError, OSError, KeyError) as error:
        result = {'status': 'FAIL', 'error': str(error)}
    (OUT / 'verification.json').write_text(json.dumps(result, ensure_ascii=False, indent=2) + '\n')
    print(json.dumps(result, ensure_ascii=False, indent=2))
    return 0 if result['status'] == 'PASS' else 1


if __name__ == '__main__':
    raise SystemExit(main())
