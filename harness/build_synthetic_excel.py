#!/usr/bin/env python3
"""Build schema-only fictional Excel work files. Never read source observations.

Normal rebuilds use the committed header/schema contract only. --capture-contract
reads original first-row column headers and four classification reference tables.
No original company record is used, sampled, transformed or fitted by this builder.
This is not a replacement for executing and validating the Stata G0 pipeline.
"""
from pathlib import Path
from datetime import datetime
from zoneinfo import ZoneInfo
from collections import Counter
import argparse, csv, hashlib, json, math, re, shutil, struct
from openpyxl import Workbook, load_workbook
from openpyxl.cell import WriteOnlyCell
from openpyxl.styles import Font, PatternFill, Alignment
from openpyxl.comments import Comment
from openpyxl.workbook.properties import CalcProperties
from openpyxl.utils import get_column_letter

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / 'data/synthetic-development'
SCHEMA = OUT / 'schema'
YEARS = [2010,2011,2012,2013,2014,2015,2017,2018,2019,2020,2021,2022]
N = 100
NOTICE = 'SYNTHETIC SCHEMA FIXTURE. All company records are fictional. Stata G0 has NOT been rerun on these files. Not research findings.'
FIXED_TIME = datetime(2026,9,10,0,0,0)

def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()

def readcsv(p):
    with p.open(newline='') as f:
        return list(csv.DictReader(f))

def writecsv(p, rows):
    with p.open('w',newline='') as f:
        w=csv.DictWriter(f,fieldnames=list(rows[0]));w.writeheader();w.writerows(rows)

def workbook(path, headers, rows, note=NOTICE, dictionary=None):
    w=Workbook(write_only=True)
    w.properties.creator='Natanael';w.properties.title=note
    w.properties.description=note;w.properties.created=FIXED_TIME;w.properties.modified=FIXED_TIME
    w.calculation=CalcProperties(calcId=191029,calcMode='auto',fullCalcOnLoad=True,forceFullCalc=True)
    s=w.create_sheet('Sheet1');s.freeze_panes='C2'
    s.sheet_view.zoomScale=85
    for i,h in enumerate(headers,1):
        s.column_dimensions[get_column_letter(i)].width=min(30,max(14,len(str(h))+2))
    s.row_dimensions[1].height=32
    cells=[]
    for i,h in enumerate(headers):
        c=WriteOnlyCell(s,value=h);c.font=Font(name='Aptos',bold=True,color='FFFFFF')
        c.fill=PatternFill('solid',fgColor='17365D');c.alignment=Alignment(vertical='center',wrap_text=True)
        if i==0:c.comment=Comment(note,'Natanael')
        cells.append(c)
    s.append(cells);count=0
    for row in rows:
        # Values are literal fixtures/reference codes, never executable formulas.
        converted=[]
        for value in row:
            if isinstance(value,str) and value.startswith('='):
                c=WriteOnlyCell(s,value=value);c.data_type='s';converted.append(c)
            else:converted.append(value)
        s.append(converted);count+=1
    s.auto_filter.ref=f'A1:{get_column_letter(len(headers))}{count+1}'
    if dictionary:
        d=w.create_sheet('Dictionary');d.freeze_panes='C2'
        for k,width in [('A',12),('B',38),('C',14),('D',12),('E',18),('F',24),('G',85)]:d.column_dimensions[k].width=width
        d.append(list(dictionary[0]));
        for row in dictionary:d.append(list(row.values()))
    path.parent.mkdir(parents=True,exist_ok=True);w.save(path)
    return count

def capture():
    source=ROOT/'01-intake/taildrop-20260825-151442'
    reports=ROOT/'05-analysis/analytical-dag/dag/reports/word_data/G0'
    SCHEMA.mkdir(parents=True,exist_ok=True)
    contracts=[]
    for year in YEARS:
        name=f'sampel_mfg{year}_aman.xlsx';p=source/name
        w=load_workbook(p,read_only=True,data_only=False)
        headers=list(next(w['Sheet1'].iter_rows(min_row=1,max_row=1,values_only=True)));w.close()
        contracts.append({'filename':name,'year':year,'fixture_rows':N,'headers':headers,'source_role':'annual_sample'})
    w=load_workbook(source/'si2010.xlsx',read_only=True,data_only=False)
    headers=list(next(w['Sheet1'].iter_rows(min_row=1,max_row=1,values_only=True)));w.close()
    contracts.append({'filename':'si2010.xlsx','year':2010,'fixture_rows':200,'headers':headers,'source_role':'comparison_reference'})
    (SCHEMA/'input_headers.json').write_text(json.dumps(contracts,indent=2)+'\n')
    for src,dst in [
        ('identity-options/analysis_ready_schema.csv','G0_analysis_ready_schema.csv'),
        ('raw_field_map.csv','raw_field_map.csv'),
        ('20260910-code-verification/variable_year_rules.csv','variable_year_rules.csv'),
        ('identity-options/analysis-ready-manifest.json','original_G0_metadata_receipt.json')]:
        shutil.copy2(reports/src,SCHEMA/dst)
    references=OUT/'reference-excel';references.mkdir(parents=True,exist_ok=True)
    for name in ['konversi_btki2017_kbli2015.xlsx','master_hskbli.xlsx']:
        shutil.copy2(source/name,references/name)
    for name in ['konv_hs_22_17.DBF','konversi_btki2017_2022.DBF']:
        with (source/name).open('rb') as f:
            h=f.read(32);nr,hlen,rlen=struct.unpack_from('<IHH',h,4);fields=[]
            while f.tell()<hlen-1:
                h=f.read(32)
                if len(h)!=32 or h[0]==13:break
                fields.append((h[:11].split(b'\0')[0].decode('ascii'),chr(h[11]),h[16]))
            assert len(fields)==2 and all(t=='C' for _,t,_ in fields)
            f.seek(hlen);records=[]
            for _ in range(nr):
                record=f.read(rlen)
                if record[:1]==b'*':continue
                start=1;vals=[]
                for _,_,width in fields:
                    value=record[start:start+width].decode('ascii').strip();start+=width
                    assert re.fullmatch(r'[0-9 .]*',value), f'Unexpected non-code content in {name}'
                    vals.append(value)
                records.append(vals)
        workbook(references/(name[:-4]+'_DBF_as_XLSX.xlsx'),[x[0] for x in fields],records,
                 note='Classification concordance converted from DBF, codes preserved as strings. Not company observations.')
    # Latest already-produced aggregate report, not a company-level data table.
    (OUT/'reports').mkdir(exist_ok=True)
    shutil.copy2(reports/'G0_data_workbook.xlsx',OUT/'reports/G0_latest_aggregate_report.xlsx')

def scalar(header,year,index):
    """Fictional values from names and ordinal only; no confidential-record inputs."""
    h=str(header).lower();base=re.sub(r'(10|11|12|13|14|15|17|18|19|20|21|22)$','',h)
    token=int(hashlib.sha256(f'fictional-2026/{year}/{index}/{h}'.encode()).hexdigest()[:8],16)
    workers=20+index%81;output=100000+index*1000+(year-2010)*100
    if base in ['year']:return year
    if base in ['output']:return output
    if base in ['iinput']:return output*.6
    if base in ['vtlvcu']:return output*.4
    if base in ['ltlnou','ltlnof']:return workers
    if base in ['lprnou']:return workers-5
    if base in ['lnpnou']:return 5
    if base in ['ltlrnd']:return index%4
    if base in ['prprex','ppr ex2','pprex2','prprca']:return 25 if index%2 else 0
    if base in ['dasing']:return 20 if index%3==0 else 0
    if base in ['dpusat','dpemda']:return 0
    if base in ['ddmstk']:return 80 if index%3==0 else 100
    if base in ['ceksum']:return 100
    if base in ['ekspor','rnd','resech','costrd','inov','innova','inoprd','amdal','sowste','impor']:return 1 if index%2 else 2
    if base in ['inopcs','pplihi','liwste']:return 3 if index%2 else 4
    if base in ['inomkt','spplhi','b3wste']:return 5 if index%2 else 6
    if base in ['inoorg','inspli']:return 7 if index%2 else 8
    if base in ['dprovi','prov']:return '99'
    if base in ['dkabup','kodekab']:return '99'
    if base in ['dkecam','dkdesa','ddesa','kodekec','kodedesa']:return '999'
    if base in ['disic5','kki5d','kbli05','kbli09','kbli15','kbli20']:return ['10110','13111','20111','25111'][index%4]
    if base in ['kbli2']:return ['10','13','20','25'][index%4]
    if base.startswith(('kip','psid','dseqno','nib')):return str(800000+index)
    if any(x in base for x in ['nama','name','alamat','alpus','email','emaikp','web','tlp','fax','userid','namrtl','namypr']):return 'SYNTHETIC'
    if base in ['jan','feb','mar','apr','mei','jun','jul','ags','sep','okt','nop','des']:return 1
    if re.fullmatch('v11[0-9]+',h):return 50000+100*index
    if 'irdvcu' in h:return index*30 if index%2 else 0
    if 'rimvcu' in h:return index*100 if index%3 else 0
    if h.startswith('e') and any(x in h for x in ['liu','kgu','m3u','khu']):return 10+index
    # Unknown source fields are syntactic placeholders, not claimed valid domains.
    if index%23==0:return None
    if index%17==0:return 0
    return 10+token%90

def make_context(contract,index):
    return {str(h):scalar(h,contract['year'],index) for h in contract['headers']}

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--capture-contract',action='store_true');args=ap.parse_args()
    if args.capture_contract:capture()
    contracts=json.loads((SCHEMA/'input_headers.json').read_text());schema=readcsv(SCHEMA/'G0_analysis_ready_schema.csv')
    assert len(schema)==3793
    rawmap=readcsv(SCHEMA/'raw_field_map.csv');rules=readcsv(SCHEMA/'variable_year_rules.csv')
    raw_by_year={y:{r['candidate_field']:r['original_header'] for r in rawmap if int(r['source_year'])==y and r['candidate_field'].startswith('raw_')} for y in YEARS}
    rule_by_year={y:[r for r in rules if int(r['year'])==y] for y in YEARS}
    fixtures=[]
    for c in contracts:
        p=OUT/'input-excel'/('SYNTHETIC_'+c['filename'])
        workbook(p,c['headers'],([scalar(h,c['year'],i) for h in c['headers']] for i in range(1,c['fixture_rows']+1)))
        fixtures.append({'path':str(p.relative_to(OUT)),'rows':c['fixture_rows'],'columns':len(c['headers']),'kind':'fictional_raw_schema_fixture'})
        print('BUILT',p.name,flush=True)
    names=[r['name'] for r in schema]
    numeric={r['name']:r['isnumeric']=='1' for r in schema}
    def final_rows():
        for c in contracts[:12]:
            year=c['year']
            for i in range(1,N+1):
                raw=make_context(c,i)
                record={name:(None if numeric[name] else '') for name in names}
                record.update(source_year=year,source_row=i)
                for name,header in raw_by_year[year].items():
                    if name in record:
                        value=raw.get(header);record[name]='' if value is None else str(value)
                for r in rule_by_year[year]:
                    field=r['field'];source=r['source'];value=record.get(source,'');kind=r['kind']
                    state=4 if not value else 3
                    if kind=='string':v=value
                    elif not value or kind=='unit_unavailable':v=None
                    else:
                        try:v=float(value)*float(r['factor'])
                        except ValueError:v=None
                    if kind=='binary' and v is not None:
                        yes,no=float(r['yes']),float(r['no'])
                        if r['definition_status']=='codes_verified' and v in [yes,no]:v=int(v==yes)
                        else:v=None
                        if r.get('parent') and record.get(r['parent'])!='7':v=None
                    if field in record:record[field]=v
                    if v is not None and v!='':state=0 if isinstance(v,str) or v>0 else 1 if v==0 else 2
                    if 'vs_'+field in record:record['vs_'+field]=state
                    if 'st_'+field in record:record['st_'+field]=state
                # Illustrative accounting/log/ratio cases only. Full Stata output is not asserted.
                workers=record.get('workers')
                for field in names:
                    if field.startswith('ln_val_'):
                        v=record.get(field[3:]);record[field]=math.log(v) if isinstance(v,(int,float)) and v>0 else None
                    if field.startswith('pw_val_'):
                        v=record.get(field[3:]);record[field]=v/workers if isinstance(v,(int,float)) and workers and workers>0 else None
                pairs={'ln_output_nominal':'gross_output_nominal','ln_va_nominal':'value_added_nominal','ln_workers':'workers','ln_inputs_nominal':'intermediate_inputs_nominal','ln_rd_cost_nominal':'rd_cost_nominal'}
                for dest,src in pairs.items():
                    v=record.get(src);record[dest]=math.log(v) if isinstance(v,(int,float)) and v>0 else None
                for dest,src in [('labor_productivity_nominal','value_added_nominal'),('output_per_worker_nominal','gross_output_nominal'),('inputs_per_worker_nominal','intermediate_inputs_nominal'),('rd_cost_per_worker_nominal','rd_cost_nominal')]:
                    v=record.get(src);record[dest]=v/workers if isinstance(v,(int,float)) and workers and workers>0 else None
                record.update(identity_mode='dummy',identity_is_dummy=1,identity_real_link_verified=0,identity_xtset_ready=1,
                    selected_firm_id=800000+i,dummy_firm_id=800000+i,selected_district_code='SYNTHETIC_DISTRICT',dummy_district_code='SYNTHETIC_DISTRICT',
                    identity_method='FABRICATED_SCHEMA_FIXTURE; NOT_G0_STATA_OUTPUT',identity_eligibility='software_development_only',identity_district_status='fictional',
                    dummy_district_count=1,identity_seed=20260910,demo_province='99',demo_industry2=str(record.get('industry_code',''))[:2],demo_slot=i,demo_district_slot=1,
                    candidate_status='SYNTHETIC_SCHEMA_FIXTURE_NOT_FULL_PIPELINE_OUTPUT',g0_schema_version='3793_columns_schema_fixture',analysis_contract='SYNTHETIC schema example; omitted derivations remain missing; no research inference',
                    deflator_applied=0,deflator_status='not_provided_in_schema_fixture')
                yield [record.get(name) for name in names]
    final=OUT/'output-excel/G0_analysis_ready_SYNTHETIC_SCHEMA.xlsx'
    workbook(final,names,final_rows(),dictionary=schema)
    fixtures.append({'path':str(final.relative_to(OUT)),'rows':N*len(YEARS),'columns':3793,'kind':'fictional_G0_schema_fixture_NOT_full_Stata_output'})
    print('BUILT',final.name,flush=True)
    checks=[]
    for spec in fixtures:
        p=OUT/spec['path'];w=load_workbook(p,read_only=True,data_only=False);s=w['Sheet1']
        rows=s.iter_rows(values_only=True);headers=list(next(rows));count=0;keys=set();populated=0
        expected=names if spec['columns']==3793 else next(c['headers'] for c in contracts if p.name=='SYNTHETIC_'+c['filename'])
        assert headers==expected
        for row in rows:
            count+=1;populated+=sum(v is not None for v in row)
            assert not any(isinstance(v,str) and v.startswith('=') for v in row)
            if spec['columns']==3793:
                assert (row[0],row[1]) not in keys;keys.add((row[0],row[1]))
        assert count==spec['rows']
        assert w.calculation.calcMode=='auto' and w.calculation.fullCalcOnLoad
        assert 'SYNTHETIC' in w.properties.description
        if spec['columns']==3793:assert len(keys)==1200 and 2016 not in {k[0] for k in keys}
        w.close();checks.append({**spec,'status':'PASS','header_exact':True,'records_reopened':count,'populated_cells':populated,'sha256':sha(p)})
        print('VERIFIED',p.name,flush=True)
    # Independently reconcile raw values across the input Excel and final fixture.
    for c in contracts[:12]:
        w=load_workbook(OUT/'input-excel'/('SYNTHETIC_'+c['filename']),read_only=True,data_only=True)
        rows=list(w['Sheet1'].iter_rows(values_only=True));w.close()
        assert len(rows)==101
    files=[]
    for p in sorted(OUT.rglob('*')):
        if p.is_file() and p.name!='release-manifest.json':files.append({'path':str(p.relative_to(OUT)),'bytes':p.stat().st_size,'sha256':sha(p)})
    result={'timestamp':datetime.now(ZoneInfo('Asia/Jakarta')).isoformat(),'status':'PASS','release_type':'fictional_schema_work_files',
        'source_observations_used':False,'statistical_synthesizer_fitted':False,'full_stata_G0_run':False,'estimators_run':False,
        'annual_fixture_rows':N,'G0_fixture_rows':1200,'G0_columns':3793,'input_observation_workbooks':13,
        'classification_workbooks':4,'existing_aggregate_report_workbooks':1,'fixture_checks':checks,'files':files}
    (OUT/'release-manifest.json').write_text(json.dumps(result,indent=2)+'\n')
    print('ALL_SYNTHETIC_EXCEL_CHECKS_PASS',len(fixtures),'fixtures',flush=True)

if __name__=='__main__':main()
