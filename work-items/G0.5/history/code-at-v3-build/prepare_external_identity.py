#!/usr/bin/env python3
"""Prepare company identity outside G0, directly from Excel, even before G0 runs.

Inputs/outputs with source row locations stay local. Only the later porting step
creates a screened observation-ID keyed payload for G0.5 publication. Source G0
and Excel are read-only. Existing complete usable company identity takes priority.
"""
from __future__ import annotations
import argparse
import hashlib
import hmac
import json
from pathlib import Path
import re

import numpy as np
import pandas as pd
from openpyxl import load_workbook

from build_development import sha, save
from panel_generator import FEATURES, RANK_COLUMNS, STATUS, VERSION, generate, strata

ROOT = Path(__file__).resolve().parents[2]


def read_excel(inventory, key):
    frames, receipts = [], []
    for item in inventory:
        path = Path(item['path']); digest = sha(path)
        if digest != item['sha256']: raise ValueError('Excel source hash mismatch')
        wb = load_workbook(path, read_only=True, data_only=True)
        try:
            ws = wb[item['sheet']]; iterator = ws.iter_rows(values_only=True)
            headers = [str(h) for h in next(iterator)]
            selected = {}
            for name, (_, _, stem) in FEATURES.items():
                pattern = re.compile(r'^'+stem+'('+str(item['year'])[-2:]+r')?(\.\.\.\d+)?$', re.I)
                found = [i for i,h in enumerate(headers) if pattern.fullmatch(h)]
                if len(found) != 1: raise ValueError(f'Ambiguous/missing feature: {item["year"]} {name}')
                selected[name] = found[0]
            prov = [i for i,h in enumerate(headers) if h.lower().startswith('dprovi')]
            industry = [i for i,h in enumerate(headers) if h.lower().startswith('disic5')]
            if not prov or len(industry) != 1: raise ValueError('Missing/ambiguous compulsory dimension')
            records = []
            def code(v):
                if isinstance(v, (float,int)) and np.isfinite(v) and float(v).is_integer(): return str(int(v))
                return str(v).strip() if v is not None else ''
            for row_number,row in enumerate(iterator,1):
                # Same keyed token can be created before G0 has a master/hash.
                token = hmac.new(key,f'G05-excel-observation-v1:{digest}:{item["sheet"]}:{row_number}'.encode(),hashlib.sha256).hexdigest()[:24]
                record = {'obs_id':'xobs_'+token,'source_year':float(item['year']), 'source_row':float(row_number),
                          'source_file_sha256':digest,'province_code':code(row[prov[0]]),'industry_code':code(row[industry[0]])}
                if any(code(row[i]) != record['province_code'] for i in prov): raise ValueError('Conflicting province columns')
                for name,index in selected.items():
                    try: value = float(str(row[index]).strip().replace(',',''))
                    except (ValueError,TypeError): value = np.nan
                    record[name] = value if np.isfinite(value) else np.nan
                records.append(record)
        finally: wb.close()
        assert sha(path) == digest and len(records) == item['max_row']-1
        frames.append(pd.DataFrame(records))
        receipts.append({'year':item['year'],'rows':len(records),'source_filename':path.name,'source_sha256':digest,
                         'headers':{name:headers[i] for name,i in selected.items()}})
    return pd.concat(frames,ignore_index=True), receipts


def inspect_g0(path):
    digest = sha(path)
    with pd.read_stata(path,iterator=True) as reader: names=set(reader.variable_labels())
    identity = ['psid','psid_status','selected_firm_id','dummy_firm_id','identity_mode',
                'identity_is_dummy','identity_real_link_verified','identity_xtset_ready']
    wanted = ['source_year','source_row','province_code','industry_code'] + [n for n in identity if n in names]
    if not set(wanted[:4]) <= names: raise ValueError('G0 lacks a source-row bridge; no row-order assumption permitted')
    frame = pd.concat(pd.read_stata(path,columns=wanted,chunksize=500,convert_categoricals=False),ignore_index=True)
    assert sha(path)==digest
    return frame, {'sha256':digest,'rows':len(frame),'identity_columns':[n for n in identity if n in names],
                   'identity_nonmissing':{n:int(frame[n].notna().sum()) for n in ['psid','selected_firm_id','dummy_firm_id'] if n in frame},
                   'source_file_unchanged':True}


def reusable_ids(frame):
    """Reuse complete declared company IDs; refuse partial or row-only keys.

    These are development structural checks, not proof of actual identity.
    Existing links must also obey the owner's compulsory province/sector rule.
    """
    block, valid = strata(frame)
    decisions=[]
    for name in ['psid','selected_firm_id','dummy_firm_id']:
        if name not in frame: continue
        candidate=frame[name]
        declared=(frame.get('identity_xtset_ready',pd.Series(0,index=frame.index)).eq(1).all()
                  or frame.get('psid_status',pd.Series('',index=frame.index)).isin(['verified','synthetic_development']).all())
        reason = ('identity_mode_not_ready' if not declared else 'missing_ids' if candidate.isna().any()
                  else 'repeated_firm_year' if frame.assign(_candidate=candidate).duplicated(['_candidate','source_year']).any()
                  else 'no_cross_year_continuity' if candidate.nunique()==len(frame)
                  else 'compulsory_block_conflict' if not valid.all() or block.groupby(candidate).nunique().gt(1).any()
                  else 'reuse')
        decisions.append({'column':name,'nonmissing':int(candidate.notna().sum()),'decision':reason})
        if reason=='reuse': return candidate,decisions
    return None,decisions


def prepare(inventory_path, key_path, output, existing_g0=None):
    output,key_path=Path(output).resolve(),Path(key_path).resolve()
    if output.exists() or output.is_relative_to(ROOT) or key_path.is_relative_to(ROOT):
        raise ValueError('Use new local output and a private key outside Git')
    key=key_path.read_bytes()
    if len(key)!=32: raise ValueError('Expected existing private 32-byte G0.5 key')
    frame,receipts=read_excel(json.loads(Path(inventory_path).read_text()),key)
    output.mkdir(parents=True); output.chmod(0o700)
    existing=None; inspection={'state':'not_available_before_G0','decision':'generate_external_identity'}
    if existing_g0:
        upstream,inspection=inspect_g0(existing_g0)
        assert not upstream.duplicated(['source_year','source_row']).any()
        joined=frame[['source_year','source_row','province_code','industry_code']].merge(upstream,on=['source_year','source_row'],validate='one_to_one',suffixes=('_excel',''))
        if len(joined)!=len(frame) or len(upstream)!=len(frame):raise ValueError('G0/Excel record universe differs')
        for name in ['province_code','industry_code']:
            if not joined[name].astype(str).equals(joined[name+'_excel'].astype(str)):raise ValueError('G0/Excel dimension binding differs')
        existing,decisions=reusable_ids(joined)
        inspection['candidates']=decisions;inspection['decision']='reuse_existing' if existing is not None else 'generate_external_identity'
        upstream.to_parquet(output/'private-g0-row-bridge.parquet',index=False)
    panel,report=generate(frame,progress=lambda x:print(json.dumps(x),flush=True))
    if existing is not None:
        # Preserve the existing associations but pseudonymize their numbers; a
        # reused real/raw firm identifier must never leak into the dev package.
        mapped={}
        for v in existing.unique():
            message=f'G05-existing-company-v1:{v}'.encode()
            mapped[v]=float(1+int.from_bytes(hmac.new(key,message,hashlib.sha256).digest()[:6],'big'))
        if len(set(mapped.values()))!=len(mapped):raise ValueError('Reused firm surrogate collision')
        panel['psid']=existing.map(mapped).to_numpy()
        ordered=panel.sort_values(['psid','source_year'])
        prior=ordered.groupby('psid').shift()
        ordered['dev_prev_obs_id']=prior.obs_id.fillna('')
        ordered['dev_prev_year']=prior.source_year
        ordered['dev_link_distance']=np.nan
        ordered['dev_link_status']=np.where(prior.obs_id.notna(),'reused_existing_link','new_from_existing_identity')
        panel=ordered.set_index('obs_id').loc[frame.obs_id].reset_index()
        sizes=panel.groupby('psid').size()
        report.update(synthetic_firms=len(sizes),firms_multiple_waves=int(sizes.ge(2).sum()),firms_single_wave=int(sizes.eq(1).sum()),
                      matched_links=int(panel.dev_prev_obs_id.ne('').sum()),firm_wave_count_distribution=sizes.value_counts().sort_index().to_dict(),
                      transitions=[],inference_scope='Existing declared continuity reused; source identity numbers privately pseudonymized')
    private=frame[['obs_id','source_year','source_row','source_file_sha256','province_code','industry_code',*FEATURES]].merge(panel.drop(columns='source_year'),on='obs_id',validate='one_to_one')
    private.to_parquet(output/'private-identity-spine.parquet',index=False)
    for path in output.glob('*.parquet'):path.chmod(0o600)
    report.update(identity_workflow=inspection['decision'],g0_inspection=inspection,source_excel=receipts,
                  independent_of_G0_execution=True,source_excel_unmodified=True,
                  input_basis='Original Excel -> frozen within-year/sector ranks -> external identity spine',
                  source_key_is_private_HMAC=True,upstream_G0_modified=False,
                  generator_sha256=sha(Path(__file__).with_name('panel_generator.py')),prepare_code_sha256=sha(__file__))
    save(output/'identity-report.json',report)
    save(output/'manifest.json',{'status':'PASS','version':VERSION,'private_only':True,'rows':len(private),
                               'identity_spine_sha256':sha(output/'private-identity-spine.parquet'),
                               'report_sha256':sha(output/'identity-report.json'),'source_keys':['source_year','source_row','source_file_sha256']})
    print(json.dumps({'status':'PASS','workflow':inspection['decision'],'rows':len(private),'firms':report['synthetic_firms'],'G0_modified':False}),flush=True)


if __name__=='__main__':
    p=argparse.ArgumentParser()
    for name in ['inventory','private-key','output']:p.add_argument('--'+name,type=Path,required=True)
    p.add_argument('--existing-g0',type=Path);a=p.parse_args();prepare(a.inventory,a.private_key,a.output,a.existing_g0)
