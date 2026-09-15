#!/usr/bin/env python3
"""Owner workflow I/O, identity, receipts and presentation. Statistics stay in Stata."""
from __future__ import annotations
import argparse
import csv
import datetime as dt
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import re
import shutil
import sys
import traceback
import uuid

for thread_setting in ['OPENBLAS_NUM_THREADS','OMP_NUM_THREADS','MKL_NUM_THREADS']:
    os.environ[thread_setting]='1'

ROLES = {
    'WORKERS': 'workers', 'OUTPUT': 'gross_output_nominal',
    'VALUE_ADDED': 'value_added_nominal', 'INPUTS': 'intermediate_inputs_nominal',
    'MATERIALS': 'val_rtlvcu', 'FUEL_COST': 'val_efuvcu',
    'ELECTRICITY': 'elec_pln_kwh', 'PAYROLL_PROD': 'val_zpdvcu',
    'PAYROLL_OTHER': 'val_zndvcu',
}
STAGES = ['input','waves','coverage','panel','summaries','g0_tables','workbook','figures']
SOURCE_RELEASE = 'releases/2026-09-13-data-foundation/stata-preparation'
CORE_FIELDS = ['workers','production_workers','gross_output_nominal','value_added_nominal',
    'intermediate_inputs_nominal','capital_stock_nominal','capital_additions_nominal',
    'import_value_nominal','labor_productivity_nominal','output_per_worker_nominal',
    'inputs_per_worker_nominal','capital_stock_per_worker','capital_additions_per_worker',
    'fuel_coal_kg','fuel_natgas_mmbtu','fuel_biomass_kg','elec_purchased_kwh',
    'energy_expenditure_rp000','gj_fuel_s1','gj_electricity','total_gj_s1',
    'co2_scope1_s1','co2_scope2_s1','co2_total_s1','rd_cost_nominal','rd_workers']


def sha(p):
    h = hashlib.sha256()
    with Path(p).open('rb') as f:
        for block in iter(lambda:f.read(1024*1024), b''): h.update(block)
    return h.hexdigest()


def digest(obj):
    return hashlib.sha256(json.dumps(obj,sort_keys=True,ensure_ascii=False).encode()).hexdigest()


def now(): return dt.datetime.now(dt.timezone.utc).isoformat()


def write_json(p, obj):
    p = Path(p); p.parent.mkdir(parents=True,exist_ok=True)
    tmp=p.with_name(p.name+'.tmp');tmp.write_text(json.dumps(obj,indent=2,ensure_ascii=False)+'\n');tmp.replace(p)


def load(p): return json.loads(Path(p).read_text())


def quoted(value):
    text = str(value)
    if any(c in text for c in ['"','`','$','\r','\n','\t']):
        raise ValueError('Path/header contains a Stata metacharacter; use a neutral alias or @Excel-column selector.')
    return '"'+text+'"'


def reply(path, **values):
    p=Path(path)
    if p.exists(): raise ValueError('Reply path must be fresh')
    p.write_text(''.join(f'global {name} {quoted(value)}\n' for name,value in values.items()))


def request(path):
    pairs=[line.split('\t',1) for line in Path(path).read_text().splitlines()]
    if any(len(x)!=2 for x in pairs): raise ValueError('Invalid configuration row')
    out=dict(pairs)
    if len(out)!=len(pairs): raise ValueError('Repeated configuration key')
    return out


def schema(path):
    import pandas as pd
    with pd.read_stata(path,iterator=True,convert_categoricals=False,convert_dates=False) as r:
        labels=r.variable_labels()
        return {'rows':r._nobs,'columns':r._nvar,'names':r._varlist,'types':dict(zip(r._varlist,r._typlist)), 'labels':labels}


def csv_write(path, rows, names=None):
    rows=list(rows)
    if not names: names=list(rows[0]) if rows else []
    with Path(path).open('w',newline='') as f:
        w=csv.DictWriter(f,fieldnames=names);w.writeheader();w.writerows(rows)


def source_column_name(header):
    clean=re.sub('[^a-zA-Z0-9_]','_',str(header)).lower().strip('_') or 'column'
    if len(clean)>27: clean=clean[:19]+'_'+hashlib.sha256(str(header).encode()).hexdigest()[:7]
    return 'src_'+clean


def inspect_source(path, kind, sheet, header, first, last):
    if kind=='excel':
        from openpyxl import load_workbook
        from openpyxl.utils import get_column_letter
        if header<1 or first<=header: raise ValueError('First data row must be after the Excel header row')
        wb=load_workbook(path,read_only=True,data_only=False)
        sheet=sheet or wb.sheetnames[0]
        if sheet not in wb.sheetnames: raise ValueError(f'Sheet {sheet!r} not found in {path.name}')
        ws=wb[sheet]
        values=next(ws.iter_rows(min_row=header,max_row=header,values_only=True))
        ncols=len(values)
        while ncols and values[ncols-1] is None: ncols-=1
        if not ncols: raise ValueError('Empty Excel header')
        values=values[:ncols]
        if any(v is None or str(v).strip()=='' for v in values): raise ValueError('Blank interior Excel header; name every input column')
        headers=[str(v) for v in values]
        if len(set(headers))!=len(headers): raise ValueError('Duplicate Excel headers')
        end=last or ws.max_row
        if end<first or end>ws.max_row: raise ValueError('Invalid last data row')
        columns=[{'header':h,'stata_input':get_column_letter(i+1),'storage':'string',
                  'excel_column':get_column_letter(i+1)} for i,h in enumerate(headers)]
        result={'sheet':sheet,'range':f'A{first}:{get_column_letter(ncols)}{end}',
                'expected_rows':end-first+1,'header_row':header,'first_data_row':first,'columns':columns}
        wb.close()
    elif kind=='dta':
        s=schema(path)
        columns=[{'header':h,'stata_input':h,'storage':s['types'][h],'excel_column':''} for h in s['names']]
        result={'sheet':'','range':'','expected_rows':s['rows'],'header_row':None,'first_data_row':1,'columns':columns}
    else: raise ValueError('FORMAT must be excel or dta')
    for c in columns: c['normalized_source_name']=source_column_name(c['header'])
    if len({c['normalized_source_name'] for c in columns})!=len(columns):
        raise ValueError('Source headers collide after normalization; rename the colliding source headers')
    return result


def resolve_map(inventory, mapping, year):
    result={}
    for role, wanted in mapping.items():
        if not wanted:
            result[role]=None;continue
        matches=[c for c in inventory['columns'] if c['header']==wanted or (wanted.startswith('@') and c['excel_column']==wanted[1:].upper())]
        if len(matches)!=1:
            raise ValueError(f'{year}: mapping {role}={wanted!r} does not name exactly one column. See source_columns.csv / original header, or use @A for Excel.')
        result[role]=matches[0]['normalized_source_name']
    # A duplicated continuous mapping could give a proxy multiple votes.
    selected=[result[r] for r in ROLES if result.get(r)]
    if len(selected)!=len(set(selected)): raise ValueError(f'{year}: continuous fields must not map to the same source column twice')
    return result


def validate_selected_rows(path,kind,inv,mapping,year,filtered,check_firm_precision=True):
    """Validate declared year filtering and Excel numeric-ID storage, without inference."""
    import math
    import pandas as pd
    by_name={c['normalized_source_name']:c for c in inv['columns']}
    year_col=by_name.get(mapping['YEAR']);firm_col=by_name.get(mapping['FIRM_ID'])
    if filtered and not year_col: raise ValueError(f'{year}: FILTER_YEAR=1 requires MAP_YEAR')
    selected=inv['expected_rows']
    if kind=='dta' and filtered:
        values=pd.read_stata(path,columns=[year_col['stata_input']],convert_categoricals=False,convert_dates=False).iloc[:,0]
        numbers=pd.to_numeric(values,errors='coerce')
        if numbers.isna().any() or not numbers.eq(numbers.astype(int)).all():raise ValueError(f'{year}: year column has missing/non-integer values')
        selected=int(numbers.eq(year).sum())
    if kind=='excel' and (filtered or (check_firm_precision and firm_col)):
        from openpyxl import load_workbook
        from openpyxl.utils.cell import column_index_from_string
        wb=load_workbook(path,read_only=True,data_only=True);ws=wb[inv['sheet']]
        year_index=column_index_from_string(year_col['excel_column'])-1 if year_col else None
        firm_index=column_index_from_string(firm_col['excel_column'])-1 if firm_col else None
        selected=0 if filtered else selected
        for cells in ws.iter_rows(min_row=inv['first_data_row'],max_row=inv['first_data_row']+inv['expected_rows']-1):
            if filtered:
                try:value=float(cells[year_index].value)
                except (ValueError,TypeError):raise ValueError(f'{year}: year column has a missing/non-numeric value')
                if not math.isfinite(value) or value!=int(value):raise ValueError(f'{year}: year column is not an integer')
                if int(value)!=year:continue
                selected+=1
            if check_firm_precision and firm_index is not None:
                cell=cells[firm_index];value=cell.value
                if isinstance(value,(int,float)) and not isinstance(value,bool):
                    if not math.isfinite(value) or value!=int(value) or abs(value)>2**53-1:
                        raise ValueError(f'{year}: numeric Excel firm ID is outside the exact integer range; supply IDs as text')
                    if re.fullmatch(r'0{2,}',cell.number_format or ''):
                        raise ValueError(f'{year}: a firm ID uses zero-padding only as Excel display formatting; supply the intended ID as text')
        wb.close()
    if selected<=0:raise ValueError(f'{year}: no data rows remain after year filtering')
    inv['selected_rows']=selected


def normalized_program(run, inventories, cfg):
    lines=['version 17','clear all','set more off','set varabbrev off','set maxvar 10000',
           'capture log close NORMALIZE',f'log using {quoted(run/"logs/01_normalize.log")}, name(NORMALIZE) text replace']
    for x in inventories:
        year=x['year']; inv=x['inventory']; mapping=x['mapping']
        lines += [f'* Tahun {year}: file dan pemetaan tepat dicatat dalam source_inventory.json.',
                  f'noisily display "NORMALIZE | year={year} | {x["format"]}"']
        if x['format']=='excel':
            lines += [f'import excel using {quoted(x["path"])}, sheet({quoted(inv["sheet"])}) cellrange({inv["range"]}) allstring clear']
        else: lines += [f'use {quoted(x["path"])}, clear']
        lines += [f'assert _N=={inv["expected_rows"]}']
        firm_column=next((c for c in inv['columns'] if c['normalized_source_name']==mapping['FIRM_ID']),None)
        if x['format']=='dta' and firm_column and firm_column['storage'] in ['b','h','l','f','d']:
            var=firm_column['stata_input']
            limit=16777216 if firm_column['storage']=='f' else 9007199254740991
            lines += [f'assert abs({var})<={limit} & {var}==floor({var}) if !missing({var})']
        # Move every input to neutral temporary names before introducing canonical columns.
        for i,c in enumerate(inv['columns']):
            temp=f'__incoming_{i+1}'
            lines += [f'rename {c["stata_input"]} {temp}']
        for i,c in enumerate(inv['columns']):
            temp=f'__incoming_{i+1}'; target=c['normalized_source_name']
            if x['format']=='dta' and c['storage'] in ['b','h','l','f','d']:
                lines += [f'generate strL {target}=cond(missing({temp}),"",strofreal({temp},"%24.17g"))',f'drop {temp}']
            else:
                lines += [f'rename {temp} {target}',f'recast strL {target}']
        lines += [f'generate int source_year={year}','generate long source_row=_n',
                  f'generate long source_file_row=source_row+{inv["first_data_row"]-1}']
        if mapping['YEAR']:
            if x.get('filter_year'):
                lines += [f'keep if real(strtrim({mapping["YEAR"]}))==source_year']
            else:
                lines += [f'assert real(strtrim({mapping["YEAR"]}))==source_year']
        lines += [f'assert _N=={inv.get("selected_rows", inv["expected_rows"])}']
        if mapping['OBS_ID']:
            lines += [f'generate strL obs_id=strtrim({mapping["OBS_ID"]})','assert !missing(obs_id)','compress obs_id']
        else:
            lines += [f'generate str80 obs_id="incoming-{x["sha256"][:20]}-{year}-"+string(source_row,"%09.0f")']
        for role, name in [('FIRM_ID','firm_id_original'),('PROVINCE','province_code'),('SECTOR','industry_code')]:
            value=f'strtrim({mapping[role]})' if mapping[role] else '""'
            lines += [f'generate strL {name}={value}',f'compress {name}']
        numeric_roles={**ROLES,**{'EXTRA_'+n:n for n in cfg.get('extra_fields','').split()}}
        for role,name in numeric_roles.items():
            source=mapping[role]
            if not source:
                lines += [f'generate double {name}=.'];continue
            lines += [f'generate strL __token=strtrim({source})']
            for token in cfg['missing_tokens'].split(): lines += [f'replace __token="" if __token=={quoted(token)}']
            if cfg['number_style']=='comma_thousands':
                # Strict groups: a comma in decimal notation must not become a thousand silently.
                lines += ['assert regexm(__token,"^[-+]?[0-9]{1,3}(,[0-9]{3})+([.][0-9]+)?$") | strpos(__token,",")==0',
                          'replace __token=subinstr(__token,",","",.)']
            elif cfg['number_style']=='comma_decimal':
                lines += ['assert strpos(__token,".")==0 if strpos(__token,",")>0',
                          'replace __token=subinstr(__token,",",".",.)']
            lines += [f'generate double {name}=real(__token)',
                      f'noisily display "CHECK NUMBER | year={year} | {role}"',
                      f'assert !missing({name}) | __token=="" | regexm(__token,"^[.][a-z]?$")',
                      'drop __token']
        lines += ['isid obs_id','isid source_year source_row',
                  f'save {quoted(run/f"intermediate/normalized_{year}.dta")}, replace']
    first,*rest=inventories
    lines += [f'use {quoted(run/f"intermediate/normalized_{first["year"]}.dta")}, clear']
    for x in rest: lines += [f'append using {quoted(run/f"intermediate/normalized_{x["year"]}.dta")}']
    lines += ['isid obs_id','isid source_year source_row',f'assert _N=={sum(x["inventory"].get("selected_rows",x["inventory"]["expected_rows"]) for x in inventories)}',
              f'generate str20 data_mode={quoted(cfg["mode"])}',
              f'save {quoted(run/"intermediate/normalized.dta")}, replace','log close NORMALIZE']
    (run/'code/normalize.do').write_text('\n'.join(lines)+'\n')


def code_sha(path):
    path=Path(path)
    if path.name=='00_RUN_ME.do':
        # Resume is an invocation setting, not a changed analytical program.
        text=path.read_text()
        text=re.sub(r'(?m)^global RUN_RESUME[ \t]+"[^"\n]*"[^\n]*$', 'global RUN_RESUME ""',text)
        return hashlib.sha256(text.encode()).hexdigest()
    return sha(path)


def code_inventory(home, repo):
    # Never recurse into previous runs, verification archives or generated code.
    paths=list(home.glob('[0-9][0-9]_*.do'))+list((home/'code').rglob('*.do'))+list((home/'scripts').glob('*.py'))
    paths += [repo/'harness/data_source.py',repo/'harness/g05/panel_generator.py']
    from g0_reuse import SELECTED
    paths += [repo/SOURCE_RELEASE/x for x in ['rows/G0/corrections/_utils.do',*SELECTED]]
    return [{'path':str(p),'sha256':code_sha(p),
             'hash_scope':'RUN_RESUME value normalized to empty' if p.name=='00_RUN_ME.do' else 'whole_file'} for p in sorted(paths)]


def prepare(args):
    cfg=request(args.request)
    if cfg['profile'] not in ['excel_demo','g05_full','custom']: raise ValueError('RUN_INPUT must be excel_demo, g05_full, or custom')
    if cfg['mode'] not in ['development','actual']: raise ValueError('RUN_DATA_MODE must be development or actual')
    if cfg['id_policy'] not in ['auto','supplied','synthetic']: raise ValueError('RUN_ID_POLICY must be auto, supplied, or synthetic')
    if cfg['mode']=='actual' and (cfg['profile']=='excel_demo' or cfg['id_policy']=='synthetic'):
        raise ValueError('Actual mode refuses bundled development Excel and fictional identity generation')
    if cfg['number_style'] not in ['plain','comma_thousands','comma_decimal']: raise ValueError('Unknown numeric notation')
    years=[int(y) for y in cfg['years'].split()]
    if not years or len(set(years))!=len(years) or years!=sorted(years): raise ValueError('INPUT_YEARS must be unique and increasing')
    for s in STAGES[1:]:
        if cfg['run_'+s.upper()] not in ['0','1']: raise ValueError('Run switches must be 0 or 1')
    if cfg['real_id_confirmed'] not in ['0','1']: raise ValueError('RUN_REAL_ID_CONFIRMED must be 0 or 1')
    int(cfg['seed'])
    extras=cfg.get('extra_fields','').split()
    if len(set(extras))!=len(extras) or any(not re.fullmatch(r'[A-Za-z][A-Za-z0-9_]{0,31}',x) for x in extras):
        raise ValueError('INPUT_EXTRA_FIELDS must contain unique Stata variable names, at most 32 characters')
    if set(extras)&set([*ROLES.values(),'obs_id','psid','psid_status','source_year','source_row','firm_id_original','province_code','industry_code']):
        raise ValueError('An extra field repeats a reserved canonical name')
    repo=Path(cfg['repo']).resolve();home=Path(cfg['home']).resolve();out=Path(cfg['output']).expanduser().resolve()
    if out.is_relative_to(repo): raise ValueError('RUN_OUTPUT must be outside the Git checkout; it can contain original data')
    out.mkdir(parents=True,exist_ok=True)
    # Budget this job's writes; cached read-only input does not need another full copy.
    paths={Path(cfg.get(f'FILE_{y}','')).expanduser() for y in years if cfg.get(f'FILE_{y}','')}
    source_bytes=sum(p.stat().st_size for p in paths if p.is_file())
    required_bytes=(1024**3 if cfg['profile']=='g05_full' and cfg['run_WAVES']=='0' else max(1024**3,source_bytes*8+512*1024**2))
    if cfg['profile']=='g05_full' and cfg['run_WAVES']=='1': required_bytes=5*1024**3
    if shutil.disk_usage(out).free<required_bytes: raise ValueError(f'Disk reserve failed: need {required_bytes/1024**3:.2f} GiB for this profile; use another RUN_OUTPUT volume')
    cfg.update(repo=str(repo),home=str(home),output=str(out))
    code=code_inventory(home,repo)
    identity_cfg={k:v for k,v in cfg.items() if k!='resume'}
    signature=digest({'config':identity_cfg,'code':code})
    if cfg['resume']:
        run=Path(cfg['resume']).resolve();state=load(run/'run.json')
        if not run.is_relative_to(out) or state['configuration_signature']!=signature: raise ValueError('Resume requires the same configuration and code; use a new run for edits')
        for x in state['sources']:
            if sha(x['path'])!=x['sha256']: raise ValueError('A resume input has changed')
        for receipt in state['stages'].values():
            if receipt['status']=='passed':
                for item in receipt['outputs']:
                    if sha(run/item['path'])!=item['sha256']: raise ValueError('A completed output changed; start a new run')
        state['status']='running';state['resumed_at']=now();write_json(run/'run.json',state)
    else:
        run=out/(dt.datetime.now().strftime('%Y%m%d-%H%M%S')+'-'+cfg['profile']+'-'+uuid.uuid4().hex[:6]);run.mkdir()
        globals()['_preparing_run']=run
        for p in ['code','data','waves','tables','logs','reports','figures','intermediate','scratch']: (run/p).mkdir()
        state={'status':'preparing','created_at':now(),'config':cfg,'configuration_signature':signature,
               'code':code,'sources':[],'stages':{},'scope':'Selected preparation/diagnostic modules; no downstream estimator is launched.'}
        write_json(run/'run.json',state)
        dev=repo/'data/g0-5-development';manifest=load(dev/'manifest.json')
        if cfg['profile']=='g05_full':
            sys.path.insert(0,str(repo))
            from harness.data_source import load_data,export_data
            cache_key=digest({'mode':cfg['mode'],'development_manifest':sha(dev/'manifest.json'),
                              'actual_path':cfg['actual_path'],'adapter':sha(repo/'harness/data_source.py')})
            cache=out/'cache'/cache_key;cache.mkdir(parents=True,exist_ok=True)
            target=cache/'G0_analysis_ready.dta';receipt=cache/'cache.json'
            if receipt.exists():
                cached=load(receipt)
                if sha(target)!=cached['dta_sha256']: raise ValueError('Input cache changed; preserve it and choose a new output root')
                # Every upstream part must still match, even when reusing a cached DTA.
                for x in manifest['parts']+manifest['metadata_files']:
                    if sha(dev/x['path'])!=x['sha256']: raise ValueError('G0.5 source package changed')
                if cfg['mode']=='actual' and sha(cfg['actual_path'])!=manifest['source_g0_master_sha256']: raise ValueError('Actual source changed')
            else:
                if target.exists(): raise ValueError('Incomplete cache exists; preserve it and choose another RUN_OUTPUT')
                if shutil.disk_usage(out).free<5*1024**3: raise ValueError('Cache hydration needs 5 GiB free; reuse the verified existing cache or choose another output volume')
                print('INPUT | Converting the complete named-column interface to Stata once...',flush=True)
                frame=load_data(mode=cfg['mode'],actual_path=cfg['actual_path'] or None)
                export_data(frame,target,purpose='final' if cfg['mode']=='actual' else 'development',code_path=__file__)
                cached={'dta_sha256':sha(target),'rows':len(frame),'columns':len(frame.columns),'provenance':frame.attrs['deasy_data']}
                write_json(receipt,cached)
                del frame
            actual_source=Path(cfg['actual_path']) if cfg['mode']=='actual' else dev/'manifest.json'
            state['sources']=[{'path':str(actual_source),'sha256':sha(actual_source)},{'path':str(target),'sha256':sha(target)}]
            state.update(input=str(target),needs_normalization=False,data_basis=cached['provenance'],years=sorted(map(int,manifest['year_counts'])),expected_rows=cached['rows'])
        else:
            inventories=[];column_rows=[]
            for year in years:
                mapping={role:cfg[f'MAP_{role}_{year}'] for role in ['FIRM_ID','OBS_ID','YEAR','PROVINCE','SECTOR',*ROLES]}
                mapping.update({'EXTRA_'+n:cfg[f'MAP_EXTRA_{n}_{year}'] for n in extras})
                if cfg['profile']=='excel_demo':
                    item=next((x for x in manifest['excel_views'] if x['year']==year),None)
                    if item is None: raise ValueError(f'Demo Excel wave {year} does not exist')
                    path=dev/item['path'];kind='excel';sheet='';header=1;first=2;last=0
                    if sha(path)!=item['sha256']: raise ValueError('Demo Excel hash mismatch')
                    # The default demo is an immutable published view. Custom mapping edits still apply.
                else:
                    if not cfg[f'FILE_{year}']: raise ValueError(f'{year}: FILE_{year} is blank in 01_INPUTS.do')
                    path=Path(cfg[f'FILE_{year}']).expanduser().resolve();kind=cfg[f'FORMAT_{year}'];sheet=cfg[f'SHEET_{year}']
                    header=int(cfg[f'HEADER_{year}']);first=int(cfg[f'FIRST_{year}']);last=int(cfg[f'LAST_{year}'])
                if not path.is_file(): raise FileNotFoundError(f'{year}: input file not found: {path}')
                inv=inspect_source(path,kind,sheet,header,first,last)
                column_rows += [dict(year=year,**c) for c in inv['columns']]
                csv_write(run/'reports/source_columns.csv',column_rows)
                mapped=resolve_map(inv,mapping,year)
                filtered=cfg.get(f'FILTER_YEAR_{year}','0')=='1' and cfg['profile']=='custom'
                validate_selected_rows(path,kind,inv,mapped,year,filtered,check_firm_precision=cfg['profile']=='custom')
                inventories.append({'year':year,'path':str(path),'sha256':sha(path),'format':kind,'inventory':inv,'mapping':mapped,'filter_year':filtered})
                print(f'PREFLIGHT | {year} | {kind} | rows={inv["expected_rows"]} | columns={len(inv["columns"])}',flush=True)
            write_json(run/'reports/source_inventory.json',inventories)
            normalized_program(run,inventories,cfg)
            state.update(sources=[{'path':x['path'],'sha256':x['sha256']} for x in inventories],
                         input=str(run/'data/analysis_ready.dta'),needs_normalization=True,years=years,
                         expected_rows=sum(x['inventory'].get('selected_rows',x['inventory']['expected_rows']) for x in inventories),
                         data_basis={'mode':cfg['mode'],'measurement_source':'Published perturbed Excel views' if cfg['profile']=='excel_demo' else 'User-supplied files; measurements preserved, no new perturbation',
                         'final_results_allowed':False,'note':'An actual run still needs module validation; a demo label alone is not anonymization.'})
        state['status']='running';write_json(run/'run.json',state)
    (run/'STATUS.md').write_text('# Run in progress\n\nSee `run.json` and separate stage logs. A prepared input is not a completed estimator.\n')
    if state['needs_normalization'] and (run/'data/analysis_ready.dta').exists() and state['stages'].get('input',{}).get('status')=='passed':
        needs='0'
    else: needs='1' if state['needs_normalization'] else '0'
    reply(args.reply,DR_RUN=run,DR_INPUT=state['input'],DR_YEARS=' '.join(map(str,state['years'])),
          DR_EXPECTED_ROWS=state['expected_rows'],DR_NEEDS_NORMALIZATION=needs,DR_MODE=cfg['mode'],DR_EXTRA_FIELDS=cfg.get('extra_fields',''))
    print('READY | '+str(run),flush=True)


def identity(args):
    import numpy as np
    import pandas as pd
    run=Path(args.run);state=load(run/'run.json');cfg=state['config']
    sys.path.insert(0,cfg['repo'])
    from harness.g05.panel_generator import generate,INPUT_COLUMNS,new_psid,STATUS
    cols=list(dict.fromkeys(['firm_id_original',*INPUT_COLUMNS]))
    frame=pd.read_stata(run/'intermediate/normalized.dta',columns=cols,convert_categoricals=False,convert_dates=False)
    if len(frame)!=state['expected_rows'] or frame.obs_id.isna().any() or not frame.obs_id.is_unique: raise ValueError('Normalized observation spine is invalid')
    supplied=frame.firm_id_original.astype(str).str.strip()
    has=supplied.ne(''); policy=cfg['id_policy'];seed=int(cfg['seed'])
    if policy!='synthetic' and has.any():
        if not has.all():
            years=sorted(frame.loc[~has,'source_year'].unique().tolist())
            raise ValueError(f'Firm IDs are partial (missing in years {years}). Supply a coherent complete ID, or explicitly select synthetic for development.')
        if pd.DataFrame({'id':supplied,'year':frame.source_year}).duplicated().any():
            years=sorted(frame.loc[pd.DataFrame({'id':supplied,'year':frame.source_year}).duplicated(keep=False),'source_year'].unique().tolist())
            raise ValueError(f'Duplicate firm × year IDs in {years}; correct the mapping/grain. They are not silently rematched.')
        originals=sorted(supplied.unique());numeric=[]
        for value in originals:
            # Keep safe, canonical numeric IDs exactly. Leading-zero or text IDs get a stable surrogate.
            if re.fullmatch(r'[1-9][0-9]*',value) and int(value)<=2**53-1: numeric.append(int(value))
            else: numeric.append(new_psid('provided-id:'+value,seed))
        if len(set(numeric))!=len(numeric): raise ValueError('Numeric identity collision; a separate namespace/crosswalk is required')
        mapped=dict(zip(originals,numeric));out=frame[['obs_id']].copy();out['psid']=supplied.map(mapped).astype(float)
        kind=(STATUS if cfg['profile']=='excel_demo' else 'supplied_development') if cfg['mode']=='development' else ('verified' if cfg['real_id_confirmed']=='1' else 'supplied_unverified')
        out['psid_status']=kind
        report={'method':'reuse_supplied_continuity','firms':len(originals),'status':kind,
                'real_id_confirmation':'Owner declaration' if cfg['real_id_confirmed']=='1' else 'Not declared',
                'source_values_preserved_in':'firm_id_original; local only','seed':seed}
        pd.DataFrame({'firm_id_original':originals,'psid':numeric}).to_stata(run/'intermediate/private_id_crosswalk.dta',write_index=False,version=118)
    elif policy=='supplied': raise ValueError('RUN_ID_POLICY=supplied requires a complete firm ID')
    elif cfg['mode']=='actual':
        out=frame[['obs_id']].copy();out['psid']=np.nan;out['psid_status']='unverified_no_longitudinal_crosswalk'
        report={'method':'no_fabrication_in_actual_mode','firms':None,'status':'unverified_no_longitudinal_crosswalk'}
    else:
        available=frame[list(ROLES.values())].notna().any()
        if available.sum()<6: raise ValueError('Synthetic matching needs at least 6 of the 9 mapped continuous features; fill the mappings first')
        print('IDENTITY | Province × sector; annual clusters and optional one-to-one links...',flush=True)
        out,report=generate(frame[INPUT_COLUMNS],seed=seed,progress=lambda x:None)
        out=out.drop(columns=['source_year'])
        report={'method':'existing_v3_generator_on_new_normalized_inputs','status':STATUS,'details':report,'seed':seed}
    out.to_stata(run/'intermediate/identity.dta',write_index=False,version=118)
    write_json(run/'reports/identity-method.json',report)
    reply(args.reply,DR_IDENTITY_READY='1')


def source_bindings(run):
    state=load(run/'run.json')
    for x in state['sources']:
        if sha(x['path'])!=x['sha256']: raise ValueError('Input changed during the run: '+Path(x['path']).name)
    for x in state['code']:
        if code_sha(x['path'])!=x['sha256']: raise ValueError('Code changed during the run: '+Path(x['path']).name)


def stage_start(args):
    run=Path(args.run);state=load(run/'run.json');stage=args.stage
    if stage not in STAGES: raise ValueError('Unknown stage')
    selected=stage=='input' or state['config']['run_'+stage.upper()]=='1'
    prior=state['stages'].get(stage,{})
    if prior.get('status')=='passed':
        reply(args.reply,DR_SKIP_STAGE='1');print('REUSE | '+stage);return
    if not selected:
        state['stages'][stage]={'status':'not_selected'};write_json(run/'run.json',state)
        reply(args.reply,DR_SKIP_STAGE='1');return
    state['stages'][stage]={'status':'running','started_at':now()};write_json(run/'run.json',state)

    available='0'
    if stage=='g0_tables':
        from g0_reuse import prepare_tables
        available='1' if prepare_tables(run) else '0'
    reply(args.reply,DR_SKIP_STAGE='0',DR_G0_AVAILABLE=available)


def artifacts(run, stage):
    patterns={
        'input':['reports/input_check.csv'], 'waves':['waves/*.dta','reports/wave_counts.csv'],
        'coverage':['tables/variable_year_coverage.csv','tables/schema.csv'],
        'panel':['tables/panel_*.csv'], 'summaries':['tables/descriptive_statistics.csv'],
        'g0_tables':['reports/g0-reuse.json','tables/g0/*.csv'],
        'workbook':['reports/Deasy-Imed-results.xlsx','reports/workbook-validation.json'],
        'figures':['figures/*.svg','reports/figure-trace.json','reports/writeup.tex'],
    }[stage]
    paths=sorted({p for pattern in patterns for p in run.glob(pattern) if p.is_file()})
    if not paths: raise ValueError('Stage produced no expected outputs: '+stage)
    return [{'path':str(p.relative_to(run)),'sha256':sha(p),'bytes':p.stat().st_size} for p in paths]


def stage_end(args):
    run=Path(args.run);state=load(run/'run.json');stage=args.stage;rc=int(args.rc)
    rec=state['stages'][stage]
    rec.update(status='failed' if rc else 'passed',return_code=rc,elapsed_seconds=float(args.elapsed),finished_at=now())
    if not rc:
        if stage=='g0_tables':
            from g0_reuse import collect_tables
            collect_tables(run)
            if load(run/'reports/g0-reuse.json')['status']=='not_applicable': rec['status']='not_applicable'
        if stage=='figures' and load(run/'reports/figure-trace.json')['status']=='not_applicable':
            rec['status']='not_applicable'
        rec['outputs']=artifacts(run,stage)
        if stage=='input':
            dta=Path(state['input']);state['input_sha256']=sha(dta);state['input_schema']=schema(dta)
            if state['input_schema']['rows']!=state['expected_rows']: raise ValueError('Input row count changed')
            if state['needs_normalization']: state['sources'].append({'path':str(dta),'sha256':sha(dta)})
    else: state['status']='failed'
    write_json(run/'run.json',state)
    (run/'STATUS.md').write_text('# Run status\n\n'+('\n'.join(f'- {s}: {v["status"]}' for s,v in state['stages'].items()))+'\n')
    if rc: raise RuntimeError(f'Stata stage {stage} failed with r({rc}); earlier outputs retained')
    reply(args.reply,DR_STAGE_ACCEPTED='1',DR_STAGE_STATUS=rec['status'].upper())


def present(args):
    run=Path(args.run)
    sys.path.insert(0,str(Path(__file__).parent))
    os.environ['MPLCONFIGDIR']=str(run/'scratch/matplotlib')
    from presentation import workbook,figures
    (workbook if args.stage=='workbook' else figures)(run)
    reply(args.reply,DR_PRESENTATION_READY='1')


def finish(args):
    run=Path(args.run);state=load(run/'run.json')
    source_bindings(run)
    if (run/'reports/g0-reuse.json').exists():
        g0=load(run/'reports/g0-reuse.json')
        for item in g0.get('files',[]):
            if sha(item['source'])!=item['source_sha256'] or sha(run/item['generated'])!=item['generated_sha256']:
                raise ValueError('G0 source or rebound code changed during execution')
    for stage in STAGES:
        selected=stage=='input' or state['config']['run_'+stage.upper()]=='1'
        if selected and state['stages'].get(stage,{}).get('status') not in ['passed','not_applicable']: raise ValueError('Selected stage did not pass: '+stage)
    state.update(status='selected_stages_passed',finished_at=now())
    write_json(run/'run.json',state)
    text=f'''# Hasil run Deasy–Imed

Input: **{state['config']['profile']} / {state['config']['mode']}**. {state['input_schema']['rows']:,} baris × {state['input_schema']['columns']:,} kolom.

Tahap yang sesuai dengan input sudah lulus; lihat STATUS.md untuk tahap yang tidak tersedia pada profil ini. Ini penyiapan data dan diagnostik; bukan penyelesaian TFP atau 11 estimasi.

- Dataset: `{state['input']}`
- Wave tahunan: `waves/` (jika dipilih).
- Tabel dan cakupan variabel per tahun: `tables/`.
- Workbook: `reports/Deasy-Imed-results.xlsx` (jika dipilih).
- Grafik SVG: `figures/` (jika dipilih).
- Status/log tiap tahap: `STATUS.md`, `logs/`, `run.json`.

ID fiktif hanya menyatakan kontinuitas development. Tahun yang tidak tersedia tetap hilang dari kalender. Nilai sumber custom disimpan tanpa perturbasi baru; label demo sendiri tidak membuat data anonim.

Untuk run lain, ubah pilihan atas `00_RUN_ME.do` dan `01_INPUTS.do`, lalu jalankan lagi. Folder hasil ini dipertahankan.
'''
    (run/'START_HERE.md').write_text(text)
    (run/'STATUS.md').write_text('# Tahap terpilih selesai; lihat cakupan setiap tahap\n\n'+''.join(f'- {s}: {v["status"]}\n' for s,v in state['stages'].items()))
    reply(args.reply,DR_FINISHED='1')


def fail(args):
    run=Path(args.run);state=load(run/'run.json')
    state.update(status='failed',failed_stage=args.stage,return_code=int(args.rc))
    write_json(run/'run.json',state)
    (run/'STATUS.md').write_text(f'# Failed\n\n{args.stage}: r({args.rc}). Earlier outputs remain available.\n')
    reply(args.reply,DR_FAILURE_RECORDED='1')


def main():
    ap=argparse.ArgumentParser(description=__doc__);sub=ap.add_subparsers(dest='command',required=True)
    p=sub.add_parser('prepare');p.add_argument('--request',required=True);p.add_argument('--reply',required=True)
    for name in ['identity','stage-start','stage-end','present','finish','fail']:
        p=sub.add_parser(name);p.add_argument('--run',required=True);p.add_argument('--reply',required=True)
        if name in ['stage-start','stage-end','present','fail']:p.add_argument('--stage',choices=STAGES+['normalization'],required=True)
        if name=='fail':p.add_argument('--rc',required=True)
        if name=='stage-end':p.add_argument('--rc',required=True);p.add_argument('--elapsed',required=True)
    a=ap.parse_args()
    try: globals()[a.command.replace('-','_')](a)
    except Exception as e:
        print(f'FAILED | {e}',file=sys.stderr,flush=True)
        error_run=getattr(a,'run',None) or globals().get('_preparing_run')
        if error_run:
            run=Path(error_run);(run/'logs'/f'python-{a.command}-error.log').write_text(traceback.format_exc())
            state=load(run/'run.json');state['status']='failed';state['error']=str(e);write_json(run/'run.json',state)
            (run/'STATUS.md').write_text('# Failed\n\n'+str(e)+'\n')
        raise SystemExit(1)

if __name__=='__main__': main()
