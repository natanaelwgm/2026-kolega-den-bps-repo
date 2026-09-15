#!/usr/bin/env python3
"""Register the owner G0.5 extension without changing Deasy's 44 source rows."""
import csv
import json
from pathlib import Path

from build_development import sha, save

ROOT = Path(__file__).resolve().parents[2]
BASE = ROOT / 'work-items/G0.5'
PLANS = ROOT / 'releases/2026-09-13-data-foundation/stata-preparation/row-plans'
PARENT_COMMIT = '2d5e190f4aa23ae9598a70f9053d7cb3961c0aaf'


def register():
    source = ROOT / 'requests/registry.json'
    source_hash = sha(source)
    rows = json.loads(source.read_text())
    assert len(rows) == 44 and len({r['request_id'] for r in rows}) == 44
    manifest = json.loads((ROOT / 'data/g0-5-development/manifest.json').read_text())
    assert manifest['status'] == 'PASS'
    routes = []
    for row in rows:
        rid = row['request_id']
        policy = {
            'authority': 'work-items/G0.5/OWNER-REQUEST.md',
            'effective_date': '2026-09-13',
            'role': 'actual_G0_producer' if rid == 'G0' else 'downstream_consumer',
            'development_mode': 'local_actual_preparation' if rid == 'G0' else 'development',
            'development_input': 'explicit local source inputs' if rid == 'G0' else 'data/g0-5-development/manifest.json',
            'adapter': None if rid == 'G0' else 'harness.data_source.load_data',
            'finalisation_mode': 'actual',
            'finalisation_input': 'explicit local accepted G0; exact parent checksum required',
            'actual_parent_sha256': manifest['source_g0_master_sha256'],
            'identity_workflow': 'harness/g05/EXTERNAL-WORKFLOW.md',
            'identity_preparation_independent_of_G0_execution': True,
            'same_analysis_code_both_modes': True,
            'recompute_all_results_for_finalisation': True,
            'fallback_to_historical_actual_Git_data': False,
            'supersedes_older_planned_company_input_for_development': rid != 'G0',
            'historical_source_references_retained_for_provenance': True,
            'panel_rule': 'Development accepts declared synthetic_development psid with firm-year uniqueness; actual requires verified real linkage. obs_id and annual clusters are not firm keys.',
            'row_specific_source_and_method_gates_still_apply': True,
            'research_execution_authorized_by_this_registration': False,
        }
        routes.append({'row_id': rid, **policy})
        path = PLANS / f'{rid}.json'
        plan = json.loads(path.read_text())
        for k, rk in [('request', 'source_request'), ('number', 'source_number'), ('pic', 'source_pic'), ('completion_cell', 'source_completion_cell')]:
            assert plan['source'][k] == row[rk]
        assert plan['row_complete'] is False
        plan['execution_input_policy'] = policy
        save(path, plan)
        md = PLANS / f'{rid}.md'
        text = md.read_text()
        start, end = '<!-- G0.5 INPUT POLICY -->', '<!-- END G0.5 INPUT POLICY -->'
        if start in text:
            text = text.split(end, 1)[1].lstrip()
        note = ('G0 remains the local actual-data producer. G0.5 packages its accepted projection for downstream development.' if rid == 'G0' else
                'Development uses G0.5 through `harness.data_source.load_data()` by default. Finalisation explicitly selects local actual data and reruns the same analysis code. Older actual paths below are historical input bindings, superseded for development.')
        md.write_text(f'{start}\n**Current input policy — 13 September 2026:** {note} G0.5 v3 supplies explicitly fictional province-sector firm IDs for development; actual linkage remains separate. Original source text and row completion are unchanged. See [G0.5](../../../../work-items/G0.5/README.md).\n{end}\n\n' + text)
    save(BASE / 'downstream-routing.json', {'status': 'REGISTERED_NOT_ESTIMATED', 'source_rows': 44,
         'upstream_producers': 1, 'downstream_default_development': 43, 'routes': routes})
    save(ROOT / 'data/active-dataset.json', {
         'status': 'PASS', 'default_mode': 'development', 'work_item': 'G0.5',
         'manifest': 'data/g0-5-development/manifest.json',
         'manifest_sha256': sha(ROOT / 'data/g0-5-development/manifest.json'),
         'rows': manifest['rows'], 'columns': manifest['columns'], 'waves': manifest['year_counts'],
         'loader': 'harness.data_source.load_data', 'actual_requires_explicit_local_path': True,
         'actual_data_retained_in_prior_Git_history': True, 'anonymity_guaranteed': False})
    save(BASE / 'task.json', {
         'id': 'G0.5', 'optimum_work_item_id': 'WI-deasy-imed-g05',
         'workstream_id': 'WS-deasy-imed-si-2010-2022', 'origin': 'owner_operational_extension',
         'source_row': False, 'source_word_rows_unchanged': 44,
         'title': 'External G0.5 identity workflow, development data and actual finalisation',
         'status': 'implemented_and_locally_validated', 'remote_publication': 'see agent-history and Git commit containing this work item',
         'authority': 'work-items/G0.5/OWNER-REQUEST.md', 'basis_commit': PARENT_COMMIT,
         'input_master_sha256': manifest['source_g0_master_sha256'],
         'output': 'data/g0-5-development/manifest.json', 'downstream_routing': 'work-items/G0.5/downstream-routing.json',
         'grain': 'one supplied observation with a fictional firm-year assignment for development',
         'keys': ['obs_id'], 'development_panel_key': ['psid', 'source_year'],
         'panel_identity_kind': 'synthetic_development', 'actual_panel_linkage_verified': False,
         'definition_of_done': ['All supplied observations/waves retained in labelled perturbed parts',
             'Explicit field treatment, coherent derived values, checksums and coverage verified',
             'Same column interface and observation IDs through development/actual adapters',
             'Excel-first identity preparation outside G0, reuse suitable existing IDs or generate, then verify lineage port',
             'Nine-feature province-sector fictional panel, full replay and Stata calendar checks',
             'Synthetic company links never copied into actual finalisation',
             'Default development routing for all 43 downstream source requests',
             'Actual current-tree parts retired after verified local preservation',
             'G0.5 available on private main; original 44 Word requests preserved'],
         'verification': ['data/g0-5-development/verification.json', 'data/g0-5-development/package-verification.json',
             'data/g0-5-development/adapter-verification.json', 'data/g0-5-development/panel-generation.json',
             'data/g0-5-development/stata-panel-verification.json', 'data/g0-5-development/external-workflow-verification.json',
             'harness/g05/test_g05.py', 'harness/g05/test_panel.py', 'harness/g05/test_external_identity.py'],
         'not_completed_by_this_item': ['real longitudinal psid verification', 'TFP/other estimations', '44 source-row research completion']})
    publication = BASE / 'publication-verification.json'
    if publication.exists():
        receipt = json.loads(publication.read_text())
        if receipt.get('status') == 'PASS' and receipt.get('manifest_sha256') == sha(ROOT / 'data/g0-5-development/manifest.json'):
            task = json.loads((BASE / 'task.json').read_text())
            task['status'] = 'complete'
            task['completion_scope'] = 'G0.5 development package and input/ID contract only; no source-row research completion'
            task['remote_publication'] = {'commit': receipt['remote_main'], 'verified_at': receipt['checked_at'],
                                          'receipt': 'work-items/G0.5/publication-verification.json'}
            save(BASE / 'task.json', task)
    plan_manifest = PLANS / 'manifest.json'
    pm = json.loads(plan_manifest.read_text())
    for item in pm['rows']:
        item.setdefault('pre_g05_revised_plan_sha256', item['revised_plan_sha256'])
        item['revised_plan_sha256'] = sha(PLANS / f"{item['row_id']}.json")
        item['repository_json'] = str((PLANS / f"{item['row_id']}.json").relative_to(ROOT))
        item['repository_markdown'] = str((PLANS / f"{item['row_id']}.md").relative_to(ROOT))
    pm['g05_input_policy'] = {'source_rows_preserved': 44, 'downstream_default_development': 43,
                              'registration': 'work-items/G0.5/downstream-routing.json'}
    save(plan_manifest, pm)
    assert sha(source) == source_hash
    print(json.dumps({'source_rows_unchanged': 44, 'downstream_default_development': 43, 'operational_extension': 'G0.5'}))


if __name__ == '__main__':
    register()
