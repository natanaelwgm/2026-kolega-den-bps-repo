#!/usr/bin/env python3
"""Build a documented Optimum Harness projection from repository evidence.

This writes Markdown/JSON in context/optimum-harness only. It does not open or
mutate live harness databases, execute research, infer completed Word rows, or
send communications. Hand-authored explanatory Markdown is kept separately.
"""
from collections import Counter, defaultdict
import hashlib
import json
from pathlib import Path
import re
from urllib.parse import quote

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / 'context/optimum-harness'
PLAN = 'releases/2026-09-13-data-foundation/stata-preparation/row-plans'
WS = 'WS-deasy-imed-si-2010-2022'
PARENT = 'WI-deasy-imed-study-integration'
PR = {'G0': 1, 'G3': 2, 'G2': 3, 'G1': 4, 'R9': 5, 'R3': 6, 'R1': 7, 'R2': 8}
ACTOR = {'Waran': 'ACT-natanael-waraney', 'Toar': 'ACT-toar', 'Schalke': 'ACT-schalke-anindya-prospera'}


def read(path):
    return json.loads((ROOT / path).read_text())


def save(path, value):
    target = OUT / path
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n')


def link(path, label, depth=0):
    return f'[{label}](<{"../" * (2 + depth)}{path}>)'


def esc(value):
    return str(value).replace('|', '\\|').replace('\n', '<br>')


def slug(text):
    return re.sub('[^a-z0-9]+', '-', text.lower()).strip('-')


def main():
    rows = read('requests/registry.json')
    plans = {r['request_id']: read(f'{PLAN}/{r["request_id"]}.json') for r in rows}
    discussions = read('context/discussions/index.json')
    identities = read('context/optimum-harness/reference/existing-identities.json')
    nodes, edges, workitems = [], [], []

    def node(primitive, ident, name, **attrs):
        value = {'type': primitive, 'id': ident, 'name': name, **attrs}
        nodes.append(value)
        return value

    def edge(st, sid, relation, tt, tid, source, evidence, basis='documented'):
        edges.append({'source_type': st, 'source_id': sid, 'link_type': relation,
                      'target_type': tt, 'target_id': tid, 'source_ref': source,
                      'evidence_quote': evidence, 'basis': basis})

    def member(kind, ident, source):
        edge(kind, ident, 'belongs_to', 'workstream', WS, source,
             'This repository documents the Deasy–Imed SI 2010–2022 workstream.', 'documentation_projection')

    def artifact(ident, name, paths, role='source', status='retained'):
        files = []
        for path in paths:
            data = (ROOT / path).read_bytes()
            files.append({'path': path, 'bytes': len(data), 'sha256': hashlib.sha256(data).hexdigest()})
        node('artifact', ident, name, artifact_role=role, status=status, stored_files=files)
        member('artifact', ident, paths[0] if paths else 'context/optimum-harness/README.md')

    node('workstream', WS, 'Deasy–Imed — Survei Industri 2010–2022', status='active',
         registration='documentation projection; no exact current workstream match in inspected live registry',
         source='context/optimum-harness/OWNER-REQUEST.md', predecessor=identities['predecessor_workstream']['id'])
    node('work_item', PARENT, 'Integrasi 44 baris menjadi satu studi yang dapat ditelusuri', subtype='task',
         status='open', origin_type='documentation_projection', source_row=False,
         definition_of_done='Every source clause has accepted output or an explicitly unresolved status; common data/version definitions, reconciled cross-row results and a readable integrated study are preserved.',
         source='context/optimum-harness/OWNER-REQUEST.md')
    member('work_item', PARENT, 'context/optimum-harness/OWNER-REQUEST.md')
    for actor in identities['actors']:
        node('actor', actor['id'], actor['name'], actor_type='person', aliases=actor['aliases'],
             identity_basis='existing predecessor actor ID; current assignment derived separately from Word',
             source='context/optimum-harness/reference/existing-identities.json')
    node('actor', 'ACT-bps-indonesia', 'BPS', actor_type='org', identity_basis='documentation-only organization ID',
         source='context/meetings/2026-09-10/concerns-and-actions.md')

    artifact('ART-deasy-imed-word-requests', 'Word Deasy: List do file yang perlu dibuat',
             ['references/deasy-word/List do file yang perlu dibuat.docx'])
    artifact('ART-deasy-imed-master-release', 'Rilis master dan salinan cloud yang disaring',
             ['releases/2026-09-13-data-foundation/README.md',
              'releases/2026-09-13-data-foundation/cloud-data/manifest.json',
              'releases/2026-09-13-data-foundation/verification/master-acceptance.json',
              'releases/2026-09-13-data-foundation/verification/actual-loader-check.json'], 'output', 'bounded_release_accepted')
    artifact('ART-deasy-imed-context-archive', 'Arsip konteks dan bukti verifikasinya',
             ['context/discussions/index.json', 'context/meetings/index.json', 'context/files/index.json'], 'output')
    artifact('ART-deasy-imed-handbook', 'Penjelasan workstream dengan primitive Optimum Harness',
             ['context/optimum-harness/README.md', 'context/optimum-harness/AGGREGATION.md',
              'context/optimum-harness/ACTORS-COMMUNICATIONS.md', 'context/optimum-harness/DECISIONS-STATE.md',
              'context/optimum-harness/READING-MAINTENANCE.md'], 'output', 'documented')

    source_comm = 'COMM-deasy-imed-word-request'
    node('communication', source_comm, 'Permintaan Word Deasy, dibaca 8 September', comm_type='brief',
         date='2026-09-08', platform='retained Word from coauthor exchange',
         source='README.md', date_basis='document retrieval date; not a newly inferred sending time')
    member('communication', source_comm, 'README.md')
    edge('communication', source_comm, 'extracts', 'artifact', 'ART-deasy-imed-word-requests', 'README.md',
         'Source Word copy and exact 44-row registry were verified against the original document.')
    edge('communication', source_comm, 'involves', 'actor', 'ACT-deasy-pane-bappenas', 'README.md', 'Permintaan Word Deasy')

    overlays = {
        'G0': 'Master lokal 33.049 × 4.593 dan 30 tabel aktual diterima pada rilis G0. G0.5 v3 kini menjadi input development 33.049 × 4.396 dengan 10.395 perusahaan fiktif. Actual cloud lama retired dari tree aktif. Seluruh permintaan G0 dan linkage panel actual belum dinyatakan selesai.',
        'G1': 'Kode/metode terdahulu dan PR uji sintetis tersedia. Empat estimator pada panel aktual belum dinyatakan selesai.',
        'G2': 'Hasil kualitas versi 9 September dan PR sintetis tersedia. Penerimaan atas master terbaru perlu receipt G2 yang cocok dengan versi itu.',
        'G3': 'Perbandingan versi lama tersedia dan PR sintetis ada. Ketersediaan old2015, cakupan sampel/populasi dan validasi versi terbaru tetap terpisah.',
    }
    for row in rows:
        rid, plan = row['request_id'], plans[row['request_id']]
        wid = 'WI-deasy-imed-' + rid.lower()
        cid, pid = 'ART-deasy-imed-' + rid.lower() + '-contract', 'ART-deasy-imed-' + rid.lower() + '-plan'
        contract_path, plan_path = row['folder'] + '/task.json', f'{PLAN}/{rid}.json'
        exact_keys = [('request', 'source_request'), ('strategy', 'source_strategy'), ('notes', 'source_notes'), ('number', 'source_number'), ('pic', 'source_pic'), ('completion_cell', 'source_completion_cell')]
        for pk, rk in exact_keys:
            assert plan['source'][pk] == row[rk], (rid, pk)
        assert plan['row_complete'] is False, rid
        overlay = overlays.get(rid, 'PR uji metode sintetis tersedia; hasil empiris penuh pada SI aktual belum dinyatakan selesai.' if rid in PR else 'Rencana rinci tersedia; belum ada penerimaan seluruh baris pada versi data terbaru dalam sumber yang dipakai pemetaan ini.')
        data = {'id': wid, 'source_row_id': rid, 'name': row['title'], 'family': row['family'],
                'source_number': row['source_number'], 'source_pic_exact': row['source_pic'],
                'source_completion_cell': row['source_completion_cell'], 'source_locator': row['source_locator'],
                'source_request_exact': row['source_request'], 'source_strategy_exact': row['source_strategy'], 'source_notes_exact': row['source_notes'],
                'source_contract_path': contract_path, 'current_plan_path': plan_path,
                'plan_status': plan['status'], 'plan_row_complete': plan['row_complete'],
                'older_registry_assessment_date': row['assessment_as_of'],
                'older_registry_assessment': row['current_assessment'], 'current_evidence_interpretation': overlay,
                'question': plan['question'], 'unit_of_analysis': plan.get('unit_of_analysis'),
                'execution_input_policy': plan['execution_input_policy'],
                'definition_of_done': row['definition_of_done'], 'dependencies': plan['dependencies'],
                'planned_node_count': len(plan['nodes']), 'planned_exhibit_count': len(plan['exhibits']),
                'planned_decision_count': len(plan['decisions']), 'planned_primary_do': plan['primary_do'],
                'older_primary_exists': row['primary_exists'], 'older_primary_path': row['primary_do'],
                'planned_outputs': row['planned_outputs'], 'existing_outputs': row['existing_outputs'],
                'historical_worker_label': row['worker'], 'next_action_from_registry': row['next_action'],
                'open_pr_as_of_archive': PR.get(rid), 'full_row_completion_claim': False}
        workitems.append(data)
        node('work_item', wid, row['title'], subtype='task', status='open', source_row_id=rid,
             origin_type='exact_Word_request', definition_of_done=row['definition_of_done'],
             source=contract_path, current_interpretation=overlay, plan_row_complete=False)
        member('work_item', wid, contract_path)
        edge('work_item', PARENT, 'decomposes', 'work_item', wid, 'context/optimum-harness/OWNER-REQUEST.md',
             'Per baris dijelaskan sebagai work item dan hasilnya diagregasikan menjadi satu studi.', 'documentation_projection')
        edge('communication', source_comm, 'spawns', 'work_item', wid, contract_path, row['source_request'])
        if row['source_pic'].strip() in ACTOR:
            edge('work_item', wid, 'involves', 'actor', ACTOR[row['source_pic'].strip()], contract_path, row['source_pic'])
        artifact(cid, rid + ' — kontrak sumber Word', [contract_path])
        artifact(pid, rid + ' — rencana rinci dengan pengikatan input terbaru', [plan_path, f'{PLAN}/{rid}.md'], 'reference', 'plan_not_completion')
        edge('work_item', wid, 'documents', 'artifact', cid, contract_path, row['source_request'])
        edge('work_item', wid, 'documents', 'artifact', pid, plan_path, plan['question'])
        edge('work_item', wid, 'uses', 'artifact', 'ART-deasy-imed-master-release', plan_path,
             'Actual finalisation uses the explicit local accepted G0; development uses its G0.5 derivative.', 'planned_actual_finalisation_contract' if rid != 'G0' else 'bounded_release_context')
        if rid != 'G0':
            edge('work_item', wid, 'uses', 'artifact', 'ART-deasy-imed-g05-development', plan_path,
                 'execution_input_policy: development uses data/g0-5-development/manifest.json through harness.data_source.load_data.',
                 'planned_development_input_contract_not_execution')

        text = f'# {rid} — {row["title"]}\n\n'
        text += f'Primitive: **work_item** · ID pemetaan `{wid}` · anggota `{WS}`.\n\n'
        text += f'**Keadaan yang dapat dinyatakan:** {overlay}\n\n'
        text += ('**Input saat ini:** G0 tetap produsen aktual lokal; G0.5 menyiapkan turunan untuk downstream.\n\n' if rid == 'G0' else
                 '**Input saat ini:** development memakai G0.5 melalui adapter bersama; finalisasi memilih aktual lokal dan menjalankan ulang kode yang sama. Panel development memakai psid fiktif resmi G0.5 v3; obs_id dan cluster tahunan bukan ID perusahaan. Linkage actual tetap terpisah.\n\n')
        text += '[G0.5 operasional](../operational-items/G0.5.md) · [Mode data](../../../docs/DATA-MODES.md)\n\n'
        text += f'{link(contract_path, "Kontrak persis dari Word", 1)} · {link(plan_path, "Rencana JSON terbaru", 1)} · {link(f"{PLAN}/{rid}.md", "Penjelasan rencana lengkap", 1)}\n\n'
        text += '## Sumber dan tanggung jawab\n\n'
        text += f'- Nomor Word: `{row["source_number"]}`; locator `{row["source_locator"]}`.\n- PIC Word: **{row["source_pic"].strip() or "kosong — belum diisi pada sumber"}**.\n- Sel completion Word: **kosong**; dipertahankan.\n- Kelompok: `{row["family"]}`.\n\n'
        for heading, key in [('Permintaan asli', 'source_request'), ('Strategi asli', 'source_strategy'), ('Catatan asli', 'source_notes')]:
            text += f'### {heading}\n\n' + ('\n'.join('> ' + line for line in row[key].splitlines()) if row[key] else '*Kosong pada Word.*') + '\n\n'
        text += f'## Pertanyaan dan kontribusi pada studi\n\n{plan["question"]}\n\nUnit analisis dalam rencana: {plan.get("unit_of_analysis", "Lihat rencana sumber.")}\n\n'
        text += 'Kontribusi masuk ke hasil gabungan melalui pertanyaan, definisi variabel, sampel, tabel/grafik utama dan batas interpretasinya. Sumber perhitungan dan versi data harus tetap dapat ditelusuri setelah hasil dirangkai dengan baris lain.\n\n'
        text += '## Kontrak penyelesaian baris\n\n'
        for n, item in enumerate(row['definition_of_done'], 1):
            text += f'{n}. {item}\n'
        text += '\nKriteria di atas adalah minimum manager dalam registry; teks Word tetap sumber permintaan. Rencana terbaru merinci pemeriksaan tambahan dan seluruh cabang. Penyebutan PDF dalam rencana historis tidak memerintahkan pembuatan PDF untuk pekerjaan dokumentasi ini.\n\n'
        text += '## Input dan hubungan dengan pekerjaan lain\n\n| Kebutuhan | Status tertulis di rencana | Syarat penggunaan |\n|---|---|---|\n'
        for dep in plan['dependencies']:
            text += '| ' + ' | '.join(esc(dep.get(k, '')) for k in ['id', 'availability', 'gate']) + ' |\n'
        text += '\nStatus ketergantungan adalah teks saat rencana disusun. Receipt rilis yang lebih baru memperbarui milestone tertentu; ketersediaan master tidak otomatis menyelesaikan identitas panel, harga, atau validasi semua field. Dependency analitis tidak diubah menjadi tipe relationship baru di luar kontrak Optimum.\n\n'
        text += f'## Detail implementasi yang dapat dibuka\n\nRencana mencatat **{len(plan["nodes"])} node proses**, **{len(plan["exhibits"])} exhibit**, dan **{len(plan["decisions"])} aturan/keputusan rancangan**. Jumlah tersebut mengukur rincian rencana, bukan pekerjaan selesai. Entry point yang direncanakan: `{plan["primary_do"]}`.\n\n'
        text += '### Hasil yang direncanakan pada registry\n\n' + '\n'.join('- `' + x + '`' for x in row['planned_outputs']) + '\n\n'
        if row['existing_outputs']:
            text += '### Hasil lama yang tercatat\n\n'
            for path in row['existing_outputs']:
                text += '- ' + (link(path, Path(path).name, 1) if (ROOT / path).is_file() else '`' + path + '` — lokasi lama, telusuri inventaris') + '\n'
            text += '\nBaca tanggal dan versi pada berkas; keberadaannya tidak menjadi penerimaan baris terhadap master terbaru.\n\n'
        if rid in PR:
            text += f'### Cabang uji yang tersedia\n\n[PR #{PR[rid]}](https://github.com/natanaelwgm/deasy-imed-si-research-2026/pull/{PR[rid]}) masih terbuka pada saat audit. Hasil sintetis dan hasil aktual dipisahkan.\n\n'
        text += f'## Jejak penilaian dan langkah berikutnya\n\nPenilaian registry bertanggal `{row["assessment_as_of"]}`:\n\n> {row["current_assessment"]}\n\nLangkah dalam registry: {row["next_action"]}\n\nLabel pekerja historis: `{row["worker"] or "tidak tercatat"}`. Ini identitas pelaksanaan dalam sumber, bukan PIC manusia baru atau bukti proses masih aktif.\n\n'
        text += 'Untuk melanjutkan, baca rencana terbaru, receipt input terakhir, dan komunikasi terkait. Beri status pada hasil yang benar-benar tersedia; pertahankan bagian yang masih belum dipenuhi. [Kembali ke 44 work item](../WORK-ITEMS.md).\n'
        (OUT / 'work-items').mkdir(exist_ok=True)
        (OUT / 'work-items' / f'{rid}.md').write_text(text)

    g05_source = 'work-items/G0.5/OWNER-REQUEST.md'
    g05_task = read('work-items/G0.5/task.json')
    g05_id = g05_task['optimum_work_item_id']
    g05_node = node('work_item', g05_id, 'G0.5 — external identity workflow and fictional development panel',
                   subtype='task', status=g05_task['status'], source_row=False,
                   origin_type='owner_operational_extension', source='work-items/G0.5/task.json',
                   definition_of_done=g05_task['definition_of_done'],
                   research_completion_claim=False)
    member('work_item', g05_id, g05_source)
    edge('work_item', PARENT, 'decomposes', 'work_item', g05_id, g05_source,
         'tolong bikin ada itu jadi tambahan kayak jadi G0.5', 'owner_requested_extension')
    artifact('ART-deasy-imed-g05-development', 'G0.5 development package, schema, identity and validation',
             ['data/g0-5-development/manifest.json', 'data/g0-5-development/schema.json',
              'data/g0-5-development/verification.json', 'data/g0-5-development/package-verification.json',
              'data/g0-5-development/adapter-verification.json', 'data/g0-5-development/panel-generation.json',
              'data/g0-5-development/external-workflow-verification.json', 'harness/g05/EXTERNAL-WORKFLOW.md',
              'work-items/G0.5/README.md',
              'work-items/G0.5/task.json', 'work-items/G0.5/downstream-routing.json'], 'output', 'locally_validated')
    edge('work_item', g05_id, 'uses', 'artifact', 'ART-deasy-imed-master-release', g05_source,
         'G0.5 is a perturbed development derivative of the exact accepted G0 projection.', 'verified_parent_lineage')
    edge('work_item', 'WI-deasy-imed-g0', 'produces', 'artifact', 'ART-deasy-imed-master-release',
         'releases/2026-09-13-data-foundation/verification/master-acceptance.json',
         'Accepted actual G0 master; bounded data milestone, not full source-row completion.', 'bounded_release_accepted')
    edge('work_item', g05_id, 'produces', 'artifact', 'ART-deasy-imed-g05-development',
         'data/g0-5-development/package-verification.json',
         '33049 records, 4396 columns, 28 parts and 12 waves; 10395 explicitly fictional companies and 22654 links; external Excel-first identity with verified G0 port.', 'locally_verified_output')
    g05_comm, g05_dec = 'COMM-deasy-imed-owner-g05-20260913', 'DEC-deasy-imed-g05-input-mode'
    g05_quote = 'nanti gpt pro dan semua downstream akan menggunakan data tsb'
    node('communication', g05_comm, 'Owner request: G0.5 perturbed development data and ID treatment',
         comm_type='chat', date='2026-09-13', source=g05_source, platform='current Codex task')
    member('communication', g05_comm, g05_source)
    edge('communication', g05_comm, 'spawns', 'work_item', g05_id, g05_source,
         'tolong bikin ada itu jadi tambahan kayak jadi G0.5', 'direct_owner_request')
    edge('communication', g05_comm, 'involves', 'actor', 'ACT-natanael-waraney', g05_source,
         'Direct owner request in the current task.', 'direct_owner_request')
    node('decision', g05_dec, 'G0.5 for development; rerun the same code on local actual data for finalisation',
         kind='decision', status='accepted', topic='data-input-mode', source=g05_source, source_quote=g05_quote,
         scope='Owner chose the development/actual separation; 0.1–0.5% amplitude is an explicitly recorded agent implementation choice.')
    member('decision', g05_dec, g05_source)
    edge('communication', g05_comm, 'surfaces', 'decision', g05_dec, g05_source, g05_quote)
    edge('decision', g05_dec, 'decided_by', 'actor', 'ACT-natanael-waraney', g05_source, g05_quote)

    if g05_task['status'] == 'complete':
        delivery_path = 'work-items/G0.5/publication-verification.json'
        delivery = read(delivery_path)
        assert delivery['status'] == 'PASS'
        assert delivery['manifest_sha256'] == hashlib.sha256((ROOT / 'data/g0-5-development/manifest.json').read_bytes()).hexdigest()
        delivery_id = 'SHARE-deasy-imed-g05-github-20260913'
        node('share', delivery_id, 'G0.5 verified on private GitHub main', channel='private GitHub',
             status='sent', sent_at=delivery['checked_at'], commit=delivery['remote_main'], source=delivery_path,
             receipt_scope='Remote commit and exact 28 part hashes; not proof of connector indexing or coauthor acceptance')
        member('share', delivery_id, delivery_path)
        edge('share', delivery_id, 'delivers', 'artifact', 'ART-deasy-imed-g05-development', delivery_path,
             'All 67 G0.5 artifact blobs verified at the published main commit, including 28 data parts and 12 annual Excel views.', 'verified_private_GitHub_publication')
        edge('share', delivery_id, 'targets', 'actor', 'ACT-natanael-waraney', g05_source,
             'Owner requested development data in the private GitHub repository.', 'direct_owner_request')

    for source in discussions['sources']:
        sid = 'SES-deasy-imed-' + slug(source['terminal_name'] or source['title'] or source['agent_path'] or source['source_id'])[:60] + '-' + source['source_id'][:8]
        stamps = [p['first_timestamp'] for p in source['parts']] + [p['last_timestamp'] for p in source['parts']]
        node('session', sid, source['terminal_name'] or source['title'] or source['agent_path'] or source['source_id'],
             session_type='retained_agent_episode', source_id=source['source_id'], status='archived_through_frozen_prefix',
             started_at=min(stamps), last_observed_at=max(stamps), ended_at=None,
             provider=source['provider'], summary=f'{source["messages"]} retained discussion records; not an execution-success claim.',
             source='context/discussions/index.json')
        member('session', sid, 'context/discussions/index.json')
        grouped = defaultdict(list)
        for part in source['parts']:
            grouped[part['date']].append(part)
        for day, parts in grouped.items():
            suffix = source['source_id'][:13] + '-' + day
            comm, art = 'COMM-deasy-imed-discussion-' + suffix, 'ART-deasy-imed-discussion-' + suffix
            paths = ['context/discussions/' + part['path'] for part in parts]
            node('communication', comm, f'{source["title"] or source["terminal_name"] or source["agent_path"]} / {day}',
                 comm_type='chat', date=day, platform=source['provider'], source_id=source['source_id'],
                 source=paths[0], granularity='one source/day bundle; JSON parts are storage boundaries')
            member('communication', comm, paths[0])
            artifact(art, f'Arsip diskusi {day} / {source["source_id"]}', paths)
            edge('communication', comm, 'extracts', 'artifact', art, paths[0], 'Retained user/assistant and explicit agent correspondence for this source and Jakarta day.')
            edge('session', sid, 'produces', 'artifact', art, paths[0], 'Conversation text originated in this observed episode; archive serialization was performed later.', 'episode_discussion_evidence')

    for date, kind, name, paths in [
        ('2026-08-25', 'voice_note', 'Brief audio intake 25 Agustus', ['context/meetings/2026-08-25/intake-audio-transcript.md']),
        ('2026-09-03', 'meeting', 'Diskusi Deasy/SI 3 September', ['context/meetings/2026-09-03/transcript-soniox-v5.md', 'context/meetings/2026-09-03/review-and-actions.md']),
        ('2026-09-10', 'meeting', 'Diskusi Deasy/SI 10 September', ['context/meetings/2026-09-10/transcript-gemini-flash-latest.md', 'context/meetings/2026-09-10/concerns-and-actions.md']),
    ]:
        cid, aid = 'COMM-deasy-imed-' + date, 'ART-deasy-imed-transcript-' + date
        node('communication', cid, name, comm_type=kind, date=date, source=paths[0], speaker_identity='contextual; no authenticated speaker identification')
        member('communication', cid, paths[0]); artifact(aid, name + ' — transkrip dan konteks', paths)
        edge('communication', cid, 'extracts', 'artifact', aid, paths[0], 'Existing retained transcript; coverage is the saved capture.')

    owner = 'COMM-deasy-imed-owner-context-20260913'
    owner_path = 'context/optimum-harness/OWNER-REQUEST.md'
    node('communication', owner, 'Permintaan pemilik: arsip dan penjelasan Optimum Harness', comm_type='chat', date='2026-09-13', source=owner_path)
    member('communication', owner, owner_path)
    edge('communication', owner, 'involves', 'actor', 'ACT-natanael-waraney', owner_path, 'Permintaan langsung pemilik pada task arsip.')
    edge('communication', owner, 'spawns', 'work_item', PARENT, owner_path, 'lalu aggregated jadi 1 den stuyff', 'documentation_scope')
    for suffix, title, quote_text in [
        ('destination', 'Arsip diterbitkan di repo Deasy–Imed', 'bukan tailterm kan ? hrsnya dia di deasy imed thing'),
        ('small-discussions', 'Potong JSON menurut workspace, terminal dan hari', 'kita bagi per. Workspace, per terminal, gitu. Per hari, gitu.'),
        ('checkpoint-first', 'Tuntaskan checkpoint arsip sebelum perluasan dokumentasi', 'do what u were doing ... then lmk when done.. THEN Continue'),
    ]:
        did = 'DEC-deasy-imed-' + suffix
        node('decision', did, title, kind='decision', status='accepted', topic='context-publication', source_quote=quote_text, source=owner_path)
        member('decision', did, owner_path)
        edge('communication', owner, 'surfaces', 'decision', did, owner_path, quote_text)
        edge('decision', did, 'decided_by', 'actor', 'ACT-natanael-waraney', owner_path, quote_text)

    research_questions = [
        ('real-panel', ['C_REAL_PANEL', 'C_ID'], 'Identitas perusahaan antarwaktu yang mana dapat disahkan?'),
        ('prices', ['C_WPI'], 'Hubungan harga, konsep deflator dan pemetaan tahunan mana yang telah disahkan?'),
        ('classification', ['C_CLASSIFICATION'], 'Vintage klasifikasi dan padanan tahunan mana yang dapat dipakai?'),
        ('energy-factors', ['C_ENERGY_FACTORS'], 'Komponen, satuan energi dan faktor emisi mana yang mempunyai bukti?'),
        ('products', ['C_PRODUCTS'], 'Cakupan produk dan identitas produk apa yang benar-benar tersedia?'),
        ('destinations', ['C_DESTINATIONS'], 'Cakupan destinasi mana yang lengkap dan mana yang terbatas?'),
        ('covid-frame', ['C_COVID_FRAME', 'C_COVID_COHORT'], 'Bagaimana membedakan hilang dari survei, tutup dan pulih saat COVID?'),
        ('environmental-goods', ['C_ENV_GOODS'], 'Pemetaan barang lingkungan dan input impor mana yang dapat dibuktikan?'),
        ('workforce', ['C_WORKFORCE'], 'Definisi pekerja, upah dan komposisi mana yang konsisten antarwave?'),
        ('annual-semantics', ['C_CODEBOOK'], 'Definisi, kode jawaban dan respondent universe mana yang disahkan per tahun?'),
    ]
    for suffix, dep_ids, title in research_questions:
        hits = [(rid, dep) for rid, plan in plans.items() for dep in plan['dependencies'] if dep['id'] in dep_ids]
        if not hits:
            continue
        did = 'DEC-deasy-imed-' + suffix
        path = f'{PLAN}/{hits[0][0]}.json'
        node('decision', did, title, kind='question', status='needed', topic='research-input-contract',
             source_quote=hits[0][1].get('gate', ''), source=path,
             scope='Open evidence question for the applicable branch; it does not stop unrelated preparation or assert every row is wholly blocked.')
        member('decision', did, path)
        by_row = {}
        for rid, dep in hits:
            by_row.setdefault(rid, dep)
        for rid, dep in by_row.items():
            edge('work_item', 'WI-deasy-imed-' + rid.lower(), 'requires', 'decision', did,
                 f'{PLAN}/{rid}.json', dep.get('gate', dep.get('required_for', title)),
                 'conditional_requirement_for_source_branch; not a blanket execution-status change')

    share = 'SHARE-deasy-imed-context-github-20260913'
    node('share', share, 'Checkpoint arsip terverifikasi di main GitHub', channel='private GitHub',
         sent_at='2026-09-13T13:58:53+07:00', status='sent',
         commit='2e0b0e718522d9324ce883ada377f394585f3975', source=owner_path,
         receipt_scope='remote main verification; not coauthor reading or approval')
    member('share', share, owner_path)
    edge('share', share, 'delivers', 'artifact', 'ART-deasy-imed-context-archive', owner_path, 'Remote main verified at 2e0b0e718522d9324ce883ada377f394585f3975.')
    edge('share', share, 'targets', 'actor', 'ACT-natanael-waraney', owner_path, 'Owner requested the private GitHub checkpoint.')

    model = {'schema_version': 1, 'kind': 'documented_read_model_not_live_harness_database',
             'basis_commit': '2d5e190f4aa23ae9598a70f9053d7cb3961c0aaf',
             'basis_extension': 'Current owner G0.5 work item and hash-bound development package',
             'discussion_snapshot': discussions['created_at'], 'workstream_id': WS,
             'source_word_rows': 44, 'integration_work_items': 1, 'operational_extension_work_items': 1,
             'nodes': nodes, 'relationships': edges,
             'counts': dict(Counter(n['type'] for n in nodes)),
             'limitations': ['IDs other than the captured existing actor IDs are documentation mappings, not proof of live registration.',
                             'Relationships have an explicit basis; planned input contracts are not proof of executed consumption.',
                             'Sessions have no invented end time, continuation link, or success state.',
                             'Historical Word/plan states coexist with later bounded release receipts.']}
    save('model.json', model)
    save('work-items.json', {'workstream_id': WS, 'source_rows': workitems, 'rows': len(workitems),
                            'operational_extensions': [g05_node],
                            'pic_counts': dict(Counter(r['source_pic'].strip() or '(blank)' for r in rows))})

    groups = [('data', 'Penyiapan dan pemeriksaan data'), ('general', 'Deskriptif umum'), ('decarbonisation', 'Deskriptif dekarbonisasi'), ('estimation', 'Estimasi')]
    text = '# Semua work item dari 44 baris Word\n\n'
    text += '**Tambahan operasional pemilik:** [G0.5 — data development](operational-items/G0.5.md) adalah work item tersendiri di luar 44 baris sumber. Dengan induk integrasi, model memuat 46 work item dalam satu workstream.\n\n'
    text += 'Setiap baris mempertahankan identitas, nomor, PIC, permintaan asli dan acceptance criteria. Nomor 21 muncul dua kali pada sumber: `G21a` dan `G21b` tetap dua work item. Empat kelompok di bawah adalah tampilan; primitive-nya tetap work_item dalam satu workstream.\n\n'
    text += '**PIC Word:** Waran 1 baris; Toar 15; Schalke 22; kosong 6. Ini pembagian tertulis pada Word, bukan hitungan seluruh kontribusi orang/agen. Semua 44 plan menyimpan `row_complete=false`; master G0 yang diterima adalah milestone yang lebih sempit.\n\n'
    for key, title in groups:
        selected = [x for x in workitems if (x['family'] == key if key in {'data', 'estimation'} else x['family'] == 'descriptive' and (x['source_row_id'].startswith('G') if key == 'general' else x['source_row_id'].startswith('D')))]
        text += f'## {title} — {len(selected)} baris\n\n| Work item | PIC asli | Pertanyaan/hasil yang dikejar | Proses / exhibit dalam rencana |\n|---|---|---|---:|\n'
        for x in selected:
            text += f'| [{x["source_row_id"]}](work-items/{x["source_row_id"]}.md) | {esc(x["source_pic_exact"].strip() or "kosong")} | {esc(x["name"])} | {x["planned_node_count"]} / {x["planned_exhibit_count"]} |\n'
        text += '\n'
    text += '## Cara membaca satu kartu\n\nMulai dari permintaan asli dan kontrak selesai, kemudian input/versi, rencana, hasil terdahulu, cabang uji, dan tindakan berikutnya. Jumlah node/exhibit merupakan rincian rancangan dan tidak dijumlahkan sebagai penyelesaian atau jam kerja. [Pemetaan terstruktur](work-items.json) mengikat semua kartu ke sumbernya. [Cara menggabungkan hasil](AGGREGATION.md) menjelaskan kapan hasil per baris dapat menjadi satu studi.\n'
    (OUT / 'WORK-ITEMS.md').write_text(text)
    print(json.dumps({'primitive_counts': model['counts'], 'relationships': len(edges), 'source_work_item_cards': len(workitems), 'json_bytes': (OUT / 'model.json').stat().st_size}, indent=2))


if __name__ == '__main__':
    main()
