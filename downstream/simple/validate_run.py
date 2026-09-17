#!/usr/bin/env python3
"""Validate the delivered preparation interface against its scientific receipts."""
import os
os.environ['OPENBLAS_NUM_THREADS']='1'
import argparse, csv, datetime, hashlib, json
from pathlib import Path
import pandas as pd

def sha(path):
    with path.open('rb') as f:
        return hashlib.file_digest(f,'sha256').hexdigest()

def read(path):
    return json.loads(path.read_text())

def validate(run):
    steps=[]
    for number in range(1,5):
        receipt=read(run/f'step-{number}.json')
        assert receipt['status']=='PASS' and receipt['stage']==number
        for item in receipt['files']:
            path=Path(item['path'])
            assert path.stat().st_size==item['bytes']
            assert sha(path)==item['sha256'],str(path)
        steps.append({'step':number,'status':'PASS','files_verified':len(receipt['files'])})
    output=run/'output'
    final=output/'analysis_ready_data.dta'
    assert sorted(output.rglob('*.dta'))==[final],'Output must deliver exactly one DTA'
    completed=read(output/'COMPLETE.json')
    lineage=read(output/'documentation/LINEAGE.json')
    estimation=read(run/'private/estimation-receipt.json')
    final_sha=sha(final)
    assert completed['status']==lineage['status']==estimation['status']=='PASS'
    assert final_sha==completed['sha256']==lineage['final_sha256']==estimation['final_sha256']
    assert completed['order']==['clean_data','obscure_values','construct_panel','estimate_productivity']
    assert lineage['no_post_estimation_perturbation'] and not lineage['g05_added_noise']
    assert lineage['g1_estimates_freshly_computed']
    assert not lineage['real_empirical_panel_admitted']
    assert all(value=='PASS' for value in estimation['qa'].values())
    metadata=read(output/'documentation/METADATA.json')
    assert metadata['recommended_entry_file']=='../analysis_ready_data.dta'
    assert metadata['recommendations_are_binding'] is False
    assert len(metadata['dataset_catalogue'])==1
    for entry in metadata['dataset_catalogue']:
        assert (output/'documentation'/entry['file']).resolve()==final.resolve()
        assert entry['contains_fresh_g1_results']
    for entry in metadata['downstream_starting_points']:
        if entry.get('available_in_delivery',True):
            assert (output/'documentation'/entry['file']).is_file(),entry['file']
        assert entry.get('binding',False) is False
    dictionary=output/'documentation/metadata/variable_dictionary.csv'
    with dictionary.open(newline='') as f:
        variables=list(csv.DictReader(f))
    with pd.io.stata.StataReader(final) as reader:
        labels=reader.variable_labels()
        nrows=reader._nobs
    assert nrows==completed['rows']==33049
    assert len(labels)==completed['variables']==516
    assert len(variables)==len(labels) and all(labels.values())
    assert {x['name']:x['label'] for x in variables}==labels
    columns=['obs_id','firm_id','year','panel_id_synthetic','panel_empirical_ready',
             'workers','value_added_nominal']+['dev_nominal_tfp_'+m for m in ['op','lp','acf','wrdg']]
    frame=pd.read_stata(final,columns=columns,convert_categoricals=False)
    assert frame.obs_id.is_unique
    assert not frame.duplicated(['firm_id','year']).any()
    assert sorted(frame.year.unique())==[2010,2011,2012,2013,2014,2015,2017,2018,2019,2020,2021,2022]
    assert frame.panel_id_synthetic.eq(1).all() and frame.panel_empirical_ready.eq(0).all()
    assert frame.workers.dropna().mod(1).eq(0).all()
    counts={m:int(frame['dev_nominal_tfp_'+m].notna().sum()) for m in ['op','lp','acf','wrdg']}
    assert counts==estimation['g1_nonmissing'] and all(counts.values())
    assert frame.firm_id.nunique()==estimation['firms']
    return dict(status='PASS',checked_at=datetime.datetime.now().astimezone().isoformat(),
                stages=steps,final_sha256=final_sha,rows=nrows,variables=len(labels),
                firms=int(frame.firm_id.nunique()),g1_nonmissing=counts,
                output_dta_count=1,metadata_paths_resolve=True,all_labels_match_dictionary=True,
                integer_workers=True,fictional_panel=True,fresh_estimation=True,
                no_post_estimation_masking=True,scientific_qa=estimation['qa'])

if __name__=='__main__':
    parser=argparse.ArgumentParser();parser.add_argument('run',type=Path)
    parser.add_argument('--receipt',type=Path);args=parser.parse_args()
    result=validate(args.run.resolve())
    if args.receipt:
        args.receipt.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(result,indent=2))
