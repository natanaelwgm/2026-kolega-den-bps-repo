#!/usr/bin/env python3
"""Native Stata integration cases for Excel/DTA mappings and company identity."""
from pathlib import Path
import argparse
import json
import shutil
import subprocess
import sys
import time


def fixtures(root):
    import pandas as pd
    from openpyxl import Workbook
    from openpyxl.workbook.properties import CalcProperties
    root.mkdir(parents=True,exist_ok=True)
    ids=['001','1','AB-7','010','50']
    canonical=['firm_identifier','wave','prov','sector','employment','output','va','inputs','materials','fuel','electricity','prod_pay','other_pay','assets','unmapped']
    headers=['Company ID','Survey year','Province','Sector','Employment','Output','VA','Inputs','Materials','Fuel','Electricity','ProdPay','OtherPay','Assets','Untouched column']
    def records(year):
        return [[ident,year,'11' if i<3 else '12','10110' if i<3 else '20110',10+i,100+10*i,-2 if i==0 else 60+i,40+i,30+i,6+i,100+i,15+i,9+i,700+i,'retained-'+ident] for i,ident in enumerate(ids)]
    workbook=Workbook();ws=workbook.active;ws.title='Annual plants';ws.append(['Fixture only']);ws.append(['Not actual observations']);ws.append(headers)
    for row in records(2014):ws.append(row)
    workbook.calculation=CalcProperties(calcMode='auto',fullCalcOnLoad=True,forceFullCalc=True)
    workbook.save(root/'annual2014.xlsx')
    for row in records(2015):ws.append(row)
    workbook.save(root/'combined.xlsx')
    frame=pd.DataFrame(records(2015),columns=canonical)
    frame.to_stata(root/'annual2015.dta',write_index=False,version=118)
    pd.concat([pd.DataFrame(records(2014),columns=canonical),frame],ignore_index=True).to_stata(root/'combined.dta',write_index=False,version=118)
    duplicate=frame.copy();duplicate.loc[1,'firm_identifier']=duplicate.loc[0,'firm_identifier'];duplicate.to_stata(root/'duplicate2015.dta',write_index=False,version=118)
    unsafe=frame.copy();unsafe['firm_identifier']=float(2**54);unsafe.to_stata(root/'unsafe2015.dta',write_index=False,version=118)
    return headers,canonical


def settings(root,headers,canonical,name):
    h=dict(zip(['FIRM_ID','YEAR','PROVINCE','SECTOR','WORKERS','OUTPUT','VALUE_ADDED','INPUTS','MATERIALS','FUEL_COST','ELECTRICITY','PAYROLL_PROD','PAYROLL_OTHER','EXTRA_capital_stock_nominal'],headers))
    d=dict(zip(h,canonical))
    lines=['global RUN_INPUT "custom"','global INPUT_YEARS "2014 2015"','global RUN_DATA_MODE "actual"','global RUN_REAL_ID_CONFIRMED 1',
           'global RUN_WORKBOOK 0','global RUN_FIGURES 0','global RUN_G0_TABLES 0','global INPUT_EXTRA_FIELDS "capital_stock_nominal"',
           f'global FILE_2014 "{root}/annual2014.xlsx"','global FORMAT_2014 "excel"','global SHEET_2014 "Annual plants"',
           'global HEADER_2014 3','global FIRST_2014 4','global LAST_2014 0',
           f'global FILE_2015 "{root}/annual2015.dta"','global FORMAT_2015 "dta"','global SHEET_2015 ""',
           'global HEADER_2015 1','global FIRST_2015 2','global LAST_2015 0','global MAP_OBS_ID_2014 ""','global MAP_OBS_ID_2015 ""']
    for role in h:
        macro='EXTRA1' if role.startswith('EXTRA_') else 'MAP_'+role
        lines += [f'global {macro}_2014 "{h[role]}"',f'global {macro}_2015 "{d[role]}"']
    if name=='combined_dta':
        lines += [f'global FILE_2014 "{root}/combined.dta"',f'global FILE_2015 "{root}/combined.dta"','global FORMAT_2014 "dta"','global FILTER_YEAR_2014 1','global FILTER_YEAR_2015 1']
        for role in d:
            macro='EXTRA1' if role.startswith('EXTRA_') else 'MAP_'+role
            lines += [f'global {macro}_2014 "{d[role]}"']
    if name=='combined_excel':
        lines += [f'global FILE_2014 "{root}/combined.xlsx"',f'global FILE_2015 "{root}/combined.xlsx"','global FORMAT_2015 "excel"','global SHEET_2015 "Annual plants"','global HEADER_2015 3','global FIRST_2015 4','global FILTER_YEAR_2014 1','global FILTER_YEAR_2015 1']
        for role in h:
            macro='EXTRA1' if role.startswith('EXTRA_') else 'MAP_'+role
            lines += [f'global {macro}_2015 "{h[role]}"']
    if name=='single_wave':lines+=['global INPUT_YEARS "2014"']
    if name=='excel_letter':lines+=['global MAP_WORKERS_2014 "@E"']
    if name=='synthetic_missing_id':lines+=['global RUN_DATA_MODE "development"','global RUN_REAL_ID_CONFIRMED 0','global MAP_FIRM_ID_2014 ""','global MAP_FIRM_ID_2015 ""']
    if name=='actual_missing_id':lines+=['global RUN_REAL_ID_CONFIRMED 0','global MAP_FIRM_ID_2014 ""','global MAP_FIRM_ID_2015 ""']
    if name=='duplicate_id':lines+=[f'global FILE_2015 "{root}/duplicate2015.dta"']
    if name=='partial_id':lines+=['global MAP_FIRM_ID_2015 ""']
    if name=='wrong_header':lines+=['global MAP_WORKERS_2014 "Workers-not-present"']
    if name=='unsafe_numeric_id':lines+=[f'global FILE_2015 "{root}/unsafe2015.dta"']
    return '\n'.join(lines)+'\n'


def main():
    p=argparse.ArgumentParser();p.add_argument('--output',type=Path,required=True);p.add_argument('--stata',default='/usr/local/bin/stata-se');p.add_argument('--prepare-only',action='store_true');a=p.parse_args()
    original=Path(__file__).resolve().parents[1];repo=original.parent
    a.output.mkdir(parents=True,exist_ok=False)
    headers,canonical=fixtures(a.output/'fixtures')
    cases=['supplied_mixed_formats','synthetic_missing_id','actual_missing_id','duplicate_id','partial_id','wrong_header','unsafe_numeric_id','combined_dta','excel_letter','combined_excel','single_wave']
    for case in cases:
        home=a.output/case/'workflow';shutil.copytree(original,home,ignore=shutil.ignore_patterns('local_paths.do','run_overrides.local.do','__pycache__','*.log','evidence'))
        (home/'local_paths.do').write_text(f'global RUN_REPO "{repo}"\nglobal RUN_OUTPUT "{a.output/case}/runs"\nglobal RUN_PYTHON "{sys.executable}"\n')
        (home/'run_overrides.local.do').write_text(settings(a.output/'fixtures',headers,canonical,case))
        (home.parent/'test.do').write_text(f'do "{home}/00_RUN_ME.do" "{home}"\n')
    if a.prepare_only:print('Prepared integration cases at',a.output);return
    import pandas as pd
    results=[]
    for case in cases:
        folder=a.output/case;t=time.monotonic()
        subprocess.run([a.stata,'-b','do','test.do'],cwd=folder,check=True,timeout=180)
        candidates=list((folder/'runs').glob('*/run.json'))
        state=json.loads(candidates[-1].read_text()) if candidates else {}
        good=case in cases[:3] or case in ['combined_dta','excel_letter','combined_excel','single_wave'];log=(folder/'test.log').read_text()
        assert (state.get('status')=='selected_stages_passed')==good,(case,state.get('status'))
        evidence={}
        if good:
            df=pd.read_stata(state['input'],convert_categoricals=False)
            waves=1 if case=='single_wave' else 2
            assert len(df)==5*waves and df.obs_id.is_unique
            assert df.capital_stock_nominal.tolist()==[700,701,702,703,704]*waves
            assert df.value_added_nominal.lt(0).sum()==waves
            if case in ['supplied_mixed_formats','combined_dta','excel_letter','combined_excel','single_wave']:
                assert df.groupby('firm_id_original').psid.nunique().eq(1).all()
                assert df.firm_id_original.nunique()==5 and df.psid.nunique()==5
                assert df.psid_status.eq('verified').all()
                assert df.loc[df.firm_id_original=='001','psid'].iloc[0]!=df.loc[df.firm_id_original=='1','psid'].iloc[0]
                evidence['leading_zero_ids_kept_distinct']=True
                if case=='single_wave':
                    panel=pd.read_csv(candidates[-1].parent/'tables/panel_summary.csv')
                    assert panel.panel_ready.iloc[0]==1 and panel.adjacent_year_links.iloc[0]==0
                    assert pd.read_csv(candidates[-1].parent/'tables/panel_calendar_links.csv').empty
            elif case=='synthetic_missing_id':
                assert df.psid.notna().all() and not df.duplicated(['psid','source_year']).any()
                assert df.groupby('psid').province_code.nunique().le(1).all()
                assert df.groupby('psid').industry_code.nunique().le(1).all()
                assert df.psid_status.eq('synthetic_development').all()
            else:
                assert df.psid.isna().all()
                panel=pd.read_csv(candidates[-1].parent/'tables/panel_summary.csv');assert panel.panel_ready.iloc[0]==0
        else:
            expected={'duplicate_id':'Duplicate firm','partial_id':'Firm IDs are partial','wrong_header':'mapping WORKERS','unsafe_numeric_id':'NORMALIZE FAILED'}[case]
            assert expected in log,(case,log[-1000:])
        result={'case':case,'status':'PASS','expected_run_success':good,'elapsed_seconds':round(time.monotonic()-t,3),**evidence}
        results.append(result);print(json.dumps(result),flush=True)
    (a.output/'test-results.json').write_text(json.dumps({'status':'PASS','cases':results},indent=2)+'\n')

if __name__=='__main__':main()
