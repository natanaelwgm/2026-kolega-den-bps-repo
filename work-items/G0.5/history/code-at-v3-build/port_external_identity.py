#!/usr/bin/env python3
"""Port an external Excel identity spine into G0.5 without modifying G0.

The join is source observation lineage, not a second firm matching operation.
Only screened surrogate IDs and normalized ranks leave the private workspace.
"""
import argparse
import json
from pathlib import Path
import shutil

import numpy as np
import pandas as pd
import pyarrow.parquet as pq

from build_development import sha, save
from prepare_external_identity import inspect_g0, ROOT
from panel_generator import FEATURES, NEW_COLUMNS


def port(spine, g0, development, actual, output):
    spine,development,actual,output=map(lambda p:Path(p).resolve(),[spine,development,actual,output])
    if output.exists() or output.is_relative_to(ROOT):raise ValueError('Use new local output outside Git')
    sm=json.loads((spine/'manifest.json').read_text())
    if sm['status']!='PASS' or sha(spine/'private-identity-spine.parquet')!=sm['identity_spine_sha256']:
        raise ValueError('External spine integrity failure')
    if sha(spine/'identity-report.json')!=sm['report_sha256']:raise ValueError('Spine report hash mismatch')
    dm=json.loads((development/'manifest.json').read_text());am=json.loads((actual/'manifest.json').read_text())
    bridge,inspection=inspect_g0(g0)
    if inspection['sha256']!=dm['source_g0_master_sha256'] or sha(actual/'manifest.json')!=dm['source_g0_manifest_sha256']:
        raise ValueError('G0/actual/development versions differ; explicit reconciliation required')
    ids=[]
    for item in dm['parts']:
        p=development/item['path']
        if sha(p)!=item['sha256']:raise ValueError('Development part hash mismatch')
        ids.append(pq.ParquetFile(p).read(columns=['obs_id','source_year'],use_threads=False).to_pandas())
    ids=pd.concat(ids,ignore_index=True)
    if not ids.source_year.equals(bridge.source_year.astype(float)):raise ValueError('Frozen G0 observation order differs')
    bridge['obs_id']=ids.obs_id.to_numpy()
    records=[]
    for item in am['parts']:
        p=actual/item['path']
        if sha(p)!=item['sha256']:raise ValueError('Actual part hash mismatch')
        records.append(pq.ParquetFile(p).read(columns=['source_year',*FEATURES],use_threads=False).to_pandas())
    actual_fields=pd.concat(records,ignore_index=True)
    if not np.array_equal(actual_fields.source_year.to_numpy(),bridge.source_year.to_numpy()):raise ValueError('Actual parent row order differs')
    for name in FEATURES:bridge['g0_'+name]=actual_fields[name].to_numpy()
    private=pd.read_parquet(spine/'private-identity-spine.parquet').rename(columns={'obs_id':'external_obs_id'})
    bound=bridge.merge(private,on=['source_year','source_row'],validate='one_to_one',suffixes=('_g0',''))
    if len(bound)!=len(bridge) or len(bound)!=len(private):raise ValueError('External/G0 row coverage differs')
    for name in ['province_code','industry_code']:
        if not bound[name].astype(str).equals(bound[name+'_g0'].astype(str)):raise ValueError('Source dimension mismatch')
    for name in FEATURES:
        if not np.allclose(bound[name],bound['g0_'+name],rtol=1e-12,atol=1e-10,equal_nan=True):
            raise ValueError('Excel/G0 feature binding mismatch: '+name)
    translation=dict(zip(bound.external_obs_id,bound.obs_id))
    linked=bound.dev_prev_obs_id.ne('')
    if not set(bound.loc[linked,'dev_prev_obs_id'])<=set(translation):raise ValueError('Unknown external predecessor')
    bound.loc[linked,'dev_prev_obs_id']=bound.loc[linked,'dev_prev_obs_id'].map(translation)
    payload=bound[['obs_id','source_year','psid','psid_status',*NEW_COLUMNS]].copy()
    if payload.obs_id.isna().any() or not payload.obs_id.is_unique:raise ValueError('Invalid observation port')
    output.mkdir(parents=True)
    payload.to_parquet(output/'identity-payload.parquet',index=False)
    shutil.copy2(spine/'identity-report.json',output/'identity-report.json')
    save(output/'manifest.json',{'status':'PASS','rows':len(payload),'columns':list(payload),
                                'g0_master_sha256':inspection['sha256'],
                                'payload_sha256':sha(output/'identity-payload.parquet'),
                                'report_sha256':sha(output/'identity-report.json'),
                                'original_values_or_source_row_map_in_payload':False,
                                'existing_obs_id_preserved':True,'source_year_row_and_nine_features_verified':True,
                                'upstream_G0_modified':False,'port_code_sha256':sha(__file__)})
    print(json.dumps({'status':'PASS','ported_observations':len(payload),'G0_modified':False,'raw_value_columns_published':0}))


if __name__=='__main__':
    p=argparse.ArgumentParser()
    for n in ['spine','g0','development','actual','output']:p.add_argument('--'+n,type=Path,required=True)
    a=p.parse_args();port(a.spine,a.g0,a.development,a.actual,a.output)
