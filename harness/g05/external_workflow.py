#!/usr/bin/env python3
"""External G0.5 workflow: prepare IDs, port lineage, package; never execute G0.

Prepare can run first from Excel alone. Existing hash-verified outputs are reused.
Changed inputs require a new output version instead of silently changing IDs.
"""
import argparse
import json
from pathlib import Path

from build_development import sha, save
from prepare_external_identity import prepare
from port_external_identity import port
from build_panel_package import build


def run(config_path, phase, receipt):
    cfg=json.loads(Path(config_path).read_text());receipt=Path(receipt)
    if receipt.exists():raise ValueError('Use a new workflow receipt path')
    spine=Path(cfg['identity_output']);g0=Path(cfg['g0_master']) if cfg.get('g0_master') else None
    inventory=json.loads(Path(cfg['excel_inventory']).read_text())
    steps=[]
    if (spine/'manifest.json').exists():
        m=json.loads((spine/'manifest.json').read_text())
        assert m['status']=='PASS' and sha(spine/'private-identity-spine.parquet')==m['identity_spine_sha256']
        assert sha(spine/'identity-report.json')==m['report_sha256']
        report=json.loads((spine/'identity-report.json').read_text())
        expected={(x['year'],x['source_sha256']) for x in report['source_excel']}
        current={(x['year'],sha(Path(x['path']))) for x in inventory}
        if current!=expected:raise ValueError('Excel sources changed; create a new identity version')
        checked_g0=report.get('g0_inspection',{}).get('sha256')
        if g0 and g0.exists() and checked_g0 and sha(g0)!=checked_g0:
            raise ValueError('G0 identity source changed; reconcile in a new version')
        steps.append({'stage':'prepare','action':'reuse_verified_existing_spine'})
    else:
        prepare(cfg['excel_inventory'],cfg['private_key'],spine,g0 if g0 and g0.exists() else None)
        report=json.loads((spine/'identity-report.json').read_text())
        steps.append({'stage':'prepare','action':report['identity_workflow']})
    result={'status':'PREPARED','steps':steps,'rows':report['rows'],
            'identity_basis':report['identity_workflow'],'g0_executed':False,'g0_modified':False,
            'can_prepare_before_G0':True}
    if phase=='prepare':save(receipt,result);return result
    if g0 is None or not g0.exists():
        result['status']='IDENTITY_READY_AWAITING_G0_OUTPUT'
        save(receipt,result);return result
    target=Path(cfg['ported_output'])
    if (target/'manifest.json').exists():
        m=json.loads((target/'manifest.json').read_text())
        assert m['status']=='PASS' and sha(target/'identity-payload.parquet')==m['payload_sha256']
        assert sha(g0)==m['g0_master_sha256'] and sha(target/'identity-report.json')==m['report_sha256']
        if sha(spine/'identity-report.json')!=m['report_sha256']:raise ValueError('Ported spine is a different version')
        steps.append({'stage':'port','action':'reuse_verified_port'})
    else:
        port(spine,g0,cfg['g05_measurements'],cfg['actual_projection'],target)
        steps.append({'stage':'port','action':'port_external_IDs_only'})
    if phase=='port':result['status']='PORTED';save(receipt,result);return result
    package=Path(cfg['package_output'])
    if (package/'manifest.json').exists():
        m=json.loads((package/'manifest.json').read_text())
        assert m['status']=='PASS'
        if m['panel_parent_manifest_sha256'] != sha(Path(cfg['g05_measurements'])/'manifest.json'):
            raise ValueError('Disturbed measurement input changed; create a new package version')
        for item in m['parts']+m['metadata_files']+m.get('excel_views',[]):
            assert sha(package/item['path'])==item['sha256']
        proof=json.loads((package/'panel-generation.json').read_text())['port_verification']
        assert proof['payload_sha256']==sha(target/'identity-payload.parquet')
        steps.append({'stage':'package','action':'reuse_verified_package'})
    else:
        build(cfg['g05_measurements'],package,target)
        steps.append({'stage':'package','action':'attach_IDs_to_disturbed_G05'})
    result.update(status='PASS',scope='External preparation/port/package workflow; independent statistical validation is separate',
                  version=json.loads((package/'manifest.json').read_text())['version'])
    save(receipt,result);return result


if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('phase',choices=['prepare','port','all'])
    p.add_argument('--config',type=Path,required=True);p.add_argument('--receipt',type=Path,required=True)
    a=p.parse_args();print(json.dumps(run(a.config,a.phase,a.receipt)))
