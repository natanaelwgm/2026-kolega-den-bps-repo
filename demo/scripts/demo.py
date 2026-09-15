#!/usr/bin/env python3
"""Bounded local G1 demo adapter. Native Stata estimators own the analytical results."""
from pathlib import Path
import os
for k in ['OPENBLAS_NUM_THREADS','OMP_NUM_THREADS','MKL_NUM_THREADS']: os.environ[k]='1'
import sys,json,hashlib,shutil,datetime,html
import pandas as pd

def write(p,obj): p.write_text(json.dumps(obj,indent=2,default=str)+'\n')
def sha(p):
 h=hashlib.sha256()
 with p.open('rb') as f:
  for b in iter(lambda:f.read(8*1024*1024),b''):h.update(b)
 return h.hexdigest()
def page(run,status):
 imgs=''.join('<figure><img src="'+html.escape(str(p.relative_to(run)))+'"><figcaption>'+html.escape(p.stem)+'</figcaption></figure>' for p in sorted((run/'figures').glob('*.svg'),key=lambda p:(not p.name.startswith('g1_'),p.name)))
 links=''.join('<li><a href="'+html.escape(str(p.relative_to(run)))+'">'+html.escape(str(p.relative_to(run)))+'</a></li>' for pat in ['data/*.dta','g1/analysis/*.dta','*.xlsx','reports/*.xlsx','tables/*.xlsx','g1/outputs/*.csv','g1/outputs/*.xlsx','DEMO_COMPLETE.json','START_HERE.md'] for p in sorted(run.glob(pat)))
 metrics=''
 if (run/'DEMO_COMPLETE.json').exists():
  summary=json.loads((run/'DEMO_COMPLETE.json').read_text())
  if summary.get('rows'):metrics='<h2>'+format(summary['rows'],',')+' observations · '+str(summary['successful_primary_fits'])+' successful primary fits</h2>'
 refresh='' if status.startswith('DONE') else '<meta http-equiv="refresh" content="5">'
 (run/'DEMO.html').write_text('<!doctype html><html><meta charset="utf-8">'+refresh+'<title>Deasy–Imed live demo</title><style>body{font:17px system-ui;margin:36px;max-width:1300px;background:#f5f7fb;color:#14243b}header{background:#14243b;color:white;padding:28px;border-radius:16px}main{display:grid;grid-template-columns:repeat(2,minmax(0,1fr));gap:20px}figure{margin:0;background:white;padding:18px;border-radius:12px}img{width:100%}a{color:#2162a5}</style><header><h1>G0 → G0.5 → G1</h1><p>'+html.escape(status)+'</p><p>Development demo: nominal residuals, fictional panel linkage. No real-TFP or causal claim. Primary point fits; uncertainty only if bootstrap explicitly run.</p></header><p>Run: '+html.escape(run.name)+'</p>'+metrics+'<details><summary>Data, Excel, tables and verification</summary><ul>'+links+'</ul></details><p></p><main>'+imgs+'</main></html>')
 (run.parent.parent/'LATEST.html').write_text('<meta http-equiv="refresh" content="0;url=runs/'+run.name+'/DEMO.html">')

def prepare(run,repo,full,reply):
 print('G1 INPUT | membaca kolom analisis dari master terverifikasi',flush=True)
 state=json.loads((run/'run.json').read_text());source=Path(state['input']);g=run/'g1'
 for d in ['nominal','analysis','outputs','logs']: (g/d).mkdir(parents=True,exist_ok=True)
 with pd.read_stata(source,iterator=True,convert_categoricals=False) as reader: available=list(reader.variable_labels())
 cols=json.loads((repo/'work-items/G1/config.json').read_text())['input_columns']
 required=['source_year','obs_id','psid','psid_status','value_added_nominal','workers','capital_stock_nominal','capital_additions_nominal','val_rtlvcu','industry_code','province_code']
 missing=set(required)-set(available)
 if missing:raise ValueError('G1 input columns missing: '+str(sorted(missing))+'; map capital fields in 01_INPUTS.do / INPUT_EXTRA_FIELDS')
 df=pd.read_stata(source,columns=[c for c in cols if c in available],convert_categoricals=False)
 if set(df.psid_status.unique())!={'synthetic_development'}:raise ValueError('G1 demo requires fictional development panel. For custom data set RUN_DATA_MODE development and RUN_ID_POLICY synthetic. Source IDs are retained separately.')
 if df[['obs_id','source_year']].duplicated().any() or df[['psid','source_year']].duplicated().any():raise ValueError('Input keys are not unique')
 if not set(df.source_year).issubset(set(range(2010,2023))-{2016}):raise ValueError('Accepted G1 timing contract supports 2010–2015 and 2017–2022; new years need explicit model adaptation')
 for c in ['capital_stock_verified','capital_additions_verified']:
  if c not in df:df[c]=0
 if 'dev_panel_stratum' not in df:df['dev_panel_stratum']=df.province_code.astype(str)+'_'+df.industry_code.astype(str).str[:2]
 if 'dev_prev_year' not in df:
  prev=df.sort_values(['psid','source_year']).groupby('psid').source_year.shift();df['dev_prev_year']=prev.reindex(df.index)
 df.to_stata(g/'S01_input.dta',write_index=False,version=118,data_label='G0.5 DEVELOPMENT: G1 selected inputs, nominal demo')
 fullsource=source if full=='1' else g/'S01_input.dta'
 if full=='1' and shutil.disk_usage(run).free<source.stat().st_size+700*1024**2:raise ValueError('Full master needs source size plus 700 MiB reserve. Set RUN_FULL_MASTER 0 or another output volume.')
 (g/'full_input.dta').symlink_to(fullsource)
 source_sha=sha(source)
 home=Path(state['config']['home'])
 execution_code={str(p):sha(p) for base in [home/'code',home/'scripts'] for p in base.rglob('*') if p.is_file() and p.suffix in ['.do','.py']}
 write(g/'provenance.json',{'execution_code':execution_code,'source':str(source),'source_sha256':source_sha,'rows':len(df),'firms':df.psid.nunique(),'input_columns':list(df),'full_master':full=='1','original_full_input':str(source),'timestamp':datetime.datetime.now().astimezone().isoformat(),'mode':'nominal_development','native_code':{p.name:sha(p) for p in (repo/'work-items/G1/stata/nominal').glob('*.do')}})
 reply.write_text(f'global G1_RUN "{g}"\nglobal G1_ROOT "{repo}"\nglobal G1_CODE "{repo}/work-items/G1/stata"\nglobal G1_EXPECTED_ROWS {len(df)}\nglobal G1_INPUT_SHA "{source_sha}"\n')
 page(run,'G0 / G0.5 done · G1 input verified · '+str(len(df))+' observations')

def finish(run,stage):
 state=json.loads((run/'run.json').read_text())
 if state['status']!='selected_stages_passed':raise ValueError('G0 stages incomplete')
 result={'status':'passed','run_to':stage,'completed_at':datetime.datetime.now().astimezone().isoformat(),'g0_receipt':'run.json'}
 if stage=='g1':
  print('VALIDASI | hash sumber, jumlah baris dan kunci observasi',flush=True)
  g=run/'g1';prov=json.loads((g/'provenance.json').read_text())
  assert sha(Path(prov['source']))==prov['source_sha256'],'G1 input changed during execution'
  for path,digest in prov['execution_code'].items():assert sha(Path(path))==digest,'G1 code changed during execution: '+path
  df=pd.read_stata(g/'analysis/G1_main_with_tfp.dta',convert_categoricals=False)
  assert len(df)==prov['rows'] and not df[['obs_id','source_year']].duplicated().any()
  fits=pd.read_csv(g/'outputs/nominal_coefficients.csv');ok=fits[(fits.status=='fit_success') & (fits.variant=='primary')]
  if len(ok)==0:raise ValueError('No successful primary G1 fits: review sample support')
  # Independent reconstruction of attached own-sample residuals from input values + coefficients.
  src=pd.read_stata(g/'S01_input.dta',convert_categoricals=False).sort_values(['psid','source_year'])
  src['prior_year']=src.groupby('psid').source_year.shift();src['prior_k']=src.groupby('psid').capital_stock_nominal.shift()
  chk=df.merge(src[['obs_id','source_year','prior_year','prior_k']],on=['obs_id','source_year'],validate='one_to_one')
  import numpy as np
  checked={}
  for m in ['op','lp','acf','wrdg']:
   print('VALIDASI RESIDUAL | '+m.upper(),flush=True)
   col='dev_nominal_tfp_'+m
   assert col in df
   count=0
   for _,r in ok[ok.method==m].iterrows():
    if r.sample_id!='own':continue
    sel=(chk.industry_code.astype(str).str[:2]==str(int(r.sector)).zfill(2)) & chk[col].notna()
    z=chk[sel]
    if len(z):
     assert (z.source_year-z.prior_year==1).all()
     expected=np.log(z.value_added_nominal)-r.beta_L*np.log(z.workers)-r.beta_K*np.log(z.prior_k)
     assert np.allclose(z[col],expected,atol=1e-7,rtol=1e-7),m+' residual mismatch'
     count+=len(z)
   checked[m]=count
  common_checked={}
  for m in checked:
   col='dev_nominal_common_tfp_'+m;count=0
   for _,r in ok[(ok.method==m)&(ok.sample_id=='common')].iterrows():
    z=chk[(chk.industry_code.astype(str).str[:2]==str(int(r.sector)).zfill(2)) & chk[col].notna()]
    if len(z):
     assert (z.source_year-z.prior_year==1).all()
     expected=np.log(z.value_added_nominal)-r.beta_L*np.log(z.workers)-r.beta_K*np.log(z.prior_k)
     assert np.allclose(z[col],expected,atol=1e-7,rtol=1e-7),m+' common residual mismatch'
     count+=len(z)
   common_checked[m]=count
  before=pd.read_stata(g/'full_input.dta',convert_categoricals=False)
  pd.testing.assert_frame_equal(df[list(before)],before,check_dtype=False,check_exact=True)
  import matplotlib
  matplotlib.use('Agg')
  import matplotlib.pyplot as plt
  for name in ['g1_residuals','g1_coverage']:
   print('GRAFIK G1 | '+name,flush=True)
   fig,ax=plt.subplots(figsize=(9,5))
   if name=='g1_residuals':
    for m in checked:
     values=df['dev_nominal_tfp_'+m].dropna()
     if len(values):ax.hist(values,bins=40,density=True,histtype='step',label=m.upper(),linewidth=1.6)
    ax.set_xlabel('Nominal log value-added residual');ax.set_ylabel('Density')
   else:
    for m in checked:df.groupby('source_year')['dev_nominal_tfp_'+m].count().plot(ax=ax,label=m.upper(),marker='o')
    ax.set_xlabel('Source year');ax.set_ylabel('Rows with attached residual')
   ax.legend();ax.set_title('G1 development demo · primary point estimates');fig.tight_layout();fig.savefig(run/'figures'/f'{name}.svg');plt.close(fig)
  result.update(rows=len(df),successful_primary_fits=len(ok),residual_rows_checked=checked,common_residual_rows_checked=common_checked,source_values_and_order_preserved=True,full_master=prov['full_master'],output='g1/analysis/G1_main_with_tfp.dta',output_sha256=sha(g/'analysis/G1_main_with_tfp.dta'),bootstrap=(g/'outputs/nominal_bootstrap_summary.csv').exists(),scope='Nominal development point estimates; no real TFP claim')
 # Small, reproducible workbook of native Stata aggregate tables (no microdata).
 if stage=='g1':
  from openpyxl import Workbook,load_workbook
  from openpyxl.styles import Font,PatternFill,Alignment
  from openpyxl.workbook.properties import CalcProperties
  print('EXCEL G1 | membuat workbook hasil estimasi',flush=True)
  wb=Workbook();ws=wb.active;ws.title='READ_ME'
  for row in [('DEASY–IMED G1 DEMO',''),('Run',run.name),('Rows',result['rows']),('Successful primary fits',result['successful_primary_fits']),('Mode','Nominal development; fictional panel linkage'),('Inference','Point estimates only unless explicit bootstrap output exists'),('Master columns','All original fields' if result['full_master'] else 'All rows, selected analytical input fields + G1 results')]:ws.append(row)
  expectations={}
  for filename,title in [('nominal_coefficients.csv','Coefficients'),('nominal_sample_support.csv','Sample support'),('nominal_master_attachment.csv','Attachment by year'),('nominal_distribution_quantiles.csv','Distributions'),('nominal_pairwise_comparisons.csv','Method comparisons')]:
   frame=pd.read_csv(g/'outputs'/filename);tab=wb.create_sheet(title);tab.append(list(frame.columns))
   for row in frame.itertuples(index=False,name=None):tab.append([None if pd.isna(v) else v for v in row])
   expectations[title]=(len(frame)+1,len(frame.columns));tab.auto_filter.ref=tab.dimensions
  for tab in wb:
   tab.freeze_panes='A2'
   for cell in tab[1]:cell.font=Font(color='FFFFFF',bold=True);cell.fill=PatternFill('solid',fgColor='14243B')
   for column in tab.columns:
    letter=column[0].column_letter;tab.column_dimensions[letter].width=min(55,max(15,max(len(str(c.value or '')) for c in list(column)[:60])+2))
  wb.calculation=CalcProperties(calcMode='auto',fullCalcOnLoad=True,forceFullCalc=True)
  output=g/'outputs/G1_results.xlsx';wb.save(output)
  reopened=load_workbook(output,data_only=False)
  for title,shape in expectations.items():assert (reopened[title].max_row,reopened[title].max_column)==shape
  assert reopened['READ_ME']['B3'].value==result['rows']
  result['workbook']='g1/outputs/G1_results.xlsx';result['workbook_sha256']=sha(output)
 write(run/'DEMO_COMPLETE.json',result);page(run,'DONE · '+stage.upper()+' · checks passed')
 print('DEMO VERIFIED | '+str(run/'DEMO.html'),flush=True)

if __name__=='__main__':
 action=sys.argv[1];run=Path(sys.argv[2])
 if action=='prepare':prepare(run,Path(sys.argv[3]),sys.argv[4],Path(sys.argv[5]))
 elif action=='progress':page(run,sys.argv[3])
 elif action=='finish':finish(run,sys.argv[3])
 elif action=='failed':
  write(run/'DEMO_FAILED.json',{'status':'failed','message':sys.argv[3]});page(run,'DONE · FAILED · '+sys.argv[3])
