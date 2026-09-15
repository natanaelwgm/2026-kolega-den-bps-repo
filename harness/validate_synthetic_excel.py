#!/usr/bin/env python3
"""Independent saved-workbook interface and input/output raw-value checks."""
from pathlib import Path
from decimal import Decimal, InvalidOperation
from datetime import datetime
from zoneinfo import ZoneInfo
import csv,hashlib,json,math
from openpyxl import load_workbook

ROOT=Path(__file__).resolve().parents[1]
BASE=ROOT/'data/synthetic-development'

def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def normalized(v):
    if v is None or v=='':return None
    try:return Decimal(str(v))
    except InvalidOperation:return str(v)

def main():
    contract=json.loads((BASE/'schema/input_headers.json').read_text())
    with (BASE/'schema/raw_field_map.csv').open() as f:rawmap=list(csv.DictReader(f))
    with (BASE/'schema/G0_analysis_ready_schema.csv').open() as f:schema=list(csv.DictReader(f))
    names=[r['name'] for r in schema];pos={n:i for i,n in enumerate(names)}
    source={};counts=[]
    for c in contract:
        p=BASE/'input-excel'/('SYNTHETIC_'+c['filename']);w=load_workbook(p,read_only=True,data_only=False)
        assert w.sheetnames==['Sheet1'];s=w['Sheet1'];rows=s.iter_rows(values_only=True);headers=list(next(rows))
        assert headers==c['headers'];body=list(rows);assert len(body)==c['fixture_rows']
        assert w.calculation.calcMode=='auto' and w.calculation.fullCalcOnLoad
        if c['source_role']=='annual_sample':source[c['year']]=[{h:v for h,v in zip(headers,row)} for row in body]
        counts.append({'path':str(p.relative_to(BASE)),'rows':len(body),'columns':len(headers),'status':'PASS'})
        w.close()
    p=BASE/'output-excel/G0_analysis_ready_SYNTHETIC_SCHEMA.xlsx';w=load_workbook(p,read_only=True,data_only=False)
    assert w.sheetnames==['Sheet1','Dictionary'];rows=w['Sheet1'].iter_rows(values_only=True);assert list(next(rows))==names
    mapping={y:[(pos[r['candidate_field']],r['original_header']) for r in rawmap if int(r['source_year'])==y and r['candidate_field'].startswith('raw_') and r['candidate_field'] in pos] for y in source}
    lineage=0;ratios=0;keys=set();firmkeys=set();n=0
    for row in rows:
        n+=1;y,i=row[0],row[1];key=(y,i);assert key not in keys;keys.add(key)
        firmkey=(row[pos['selected_firm_id']],y);assert firmkey not in firmkeys;firmkeys.add(firmkey)
        assert y in source and y!=2016
        assert row[pos['identity_is_dummy']]==1 and row[pos['identity_real_link_verified']]==0
        assert 'SCHEMA_FIXTURE' in row[pos['candidate_status']]
        src=source[y][i-1]
        for col,header in mapping[y]:
            # XLSX may omit trailing empty cells; omitted and blank are equivalent.
            assert normalized(row[col])==normalized(src.get(header)),(y,i,names[col]);lineage+=1
        for dest,num in [('labor_productivity_nominal','value_added_nominal'),('output_per_worker_nominal','gross_output_nominal'),('inputs_per_worker_nominal','intermediate_inputs_nominal'),('rd_cost_per_worker_nominal','rd_cost_nominal')]:
            denom=row[pos['workers']];a=row[pos[num]];b=row[pos[dest]]
            if a is not None and denom and denom>0:
                assert b is not None and math.isclose(b,a/denom,rel_tol=1e-12,abs_tol=1e-10);ratios+=1
        assert row[pos['deflator_applied']]==0 and row[pos['gross_output_real']] is None
    assert n==1200 and len(keys)==1200;w.close()
    for p in sorted((BASE/'reference-excel').glob('*.xlsx')):
        w=load_workbook(p,read_only=True,data_only=False);s=w['Sheet1'];nr=sum(1 for _ in s.iter_rows(values_only=True))-1
        assert nr>10000;counts.append({'path':str(p.relative_to(BASE)),'rows':nr,'columns':s.max_column,'status':'PASS'});w.close()
    p=BASE/'reports/G0_latest_aggregate_report.xlsx';w=load_workbook(p,read_only=True,data_only=False)
    assert len(w.sheetnames)==13 and 'Final dataset' in w.sheetnames and 'Identity schema' in w.sheetnames
    assert w['Final dataset'].max_row==16 and w['Identity schema'].max_row==18
    w.close()
    report={'timestamp':datetime.now(ZoneInfo('Asia/Jakarta')).isoformat(),'status':'PASS','input_workbooks':13,
        'reference_workbooks':4,'G0_fixture_rows':n,'G0_fixture_columns':len(names),'G0_raw_cells_reconciled_to_input_excel':lineage,
        'illustrative_worker_ratios_checked':ratios,'latest_aggregate_report_sheets':13,'full_Stata_DAG_executed':False,
        'source_company_observations_used':False,'checks':counts}
    (BASE/'independent-validation.json').write_text(json.dumps(report,indent=2)+'\n')
    manifest=json.loads((BASE/'release-manifest.json').read_text())
    manifest['independent_validation']=report
    manifest['files']=[{'path':str(p.relative_to(BASE)),'bytes':p.stat().st_size,'sha256':sha(p)} for p in sorted(BASE.rglob('*')) if p.is_file() and p.name!='release-manifest.json']
    (BASE/'release-manifest.json').write_text(json.dumps(manifest,indent=2)+'\n')
    print(json.dumps({k:v for k,v in report.items() if k!='checks'},indent=2))

if __name__=='__main__':main()
