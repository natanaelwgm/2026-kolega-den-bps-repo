#!/usr/bin/env python3
"""Copy an explicit, content-screened research snapshot. Never runs analysis.

The source inventory is local operational metadata. The publication catalogue
records every inclusion/exclusion. Original work, datasets and nested Git are
never changed. An existing destination is replaced only by this explicit build.
"""
from __future__ import annotations
import csv, hashlib, io, json, re, shutil, zipfile
from collections import Counter
from datetime import datetime
from pathlib import Path, PurePosixPath
from zoneinfo import ZoneInfo
import openpyxl

ROOT = Path(__file__).resolve().parents[1]
LOCAL = ROOT / '04-working-understanding/20260910-github-harness'
CAT = ROOT / 'catalog'
DATA_EXT = {'.dta','.dbf','.parquet','.feather','.rds','.rdata','.sav','.sas7bdat','.sqlite','.sqlite3','.db','.stswp','.arrow','.ipc'}
TEXT_EXT = {'.md','.txt','.do','.ado','.py','.json','.jsonl','.csv','.tsv','.log','.smcl','.qmd','.tex','.html','.htm','.js','.ts','.css','.yml','.yaml','.xml','.sh','.command','.dot','.bib','.toml','.ini','.cfg','.rtf','.sha256'}
ALLOWED = TEXT_EXT | {'.pdf','.docx','.xlsx','.xls','.pptx','.png','.jpg','.jpeg','.svg','.webp'}
SECRET = re.compile(rb'(?:gh[pousr]_[A-Za-z0-9]{30,}|github_pat_[A-Za-z0-9_]{40,}|sk-(?:proj-|ant-)?[A-Za-z0-9_-]{32,}|AIza[A-Za-z0-9_-]{30,}|-----BEGIN (?:RSA |OPENSSH |EC )?PRIVATE KEY-----|\b[0-9]{8,12}:[A-Za-z0-9_-]{30,}\b)')
UNIT_KEYS = {'psid','firm_id','firmid','plant_id','record_id','bps_id','source_row','id_perusahaan','company_name','nama_perusahaan','nperush','npwp','alamat','address'}
AGGREGATE_WORDS = {'variable','field','metric','measure','statistic','source_state','observations','n','n_obs','count','node_id','status','parameter','term','coefficient','estimate','scope','method','scenario','table','column'}

def digest(b: bytes) -> str:
    return hashlib.sha256(b).hexdigest()

def destination(c: str, rel: str) -> str:
    if c == 'project': return 'research/1014/' + rel
    return 'references/' + c.replace('_','-') + '/' + rel

def base_policy(c: str, rel: str, size: int, symlink: bool) -> str | None:
    p=PurePosixPath(rel); low=rel.lower(); ext=p.suffix.lower(); name=p.name.lower()
    if symlink: return 'symlink_or_pointer_only; original target not implicitly traversed'
    if any(x in {'.git','node_modules','__pycache__','.venv'} for x in p.parts): return 'runtime_or_git_internals'
    if name.startswith(('._','~$')) or name == '.ds_store': return 'operating_system_or_office_lock_file'
    if ext in DATA_EXT: return 'dataset_or_database_excluded_by_owner'
    if ext=='.csv' and name in {'si_trade_panel.csv','01_si_trade_panel.csv'}:
        return 'firm_panel_csv_excluded_by_owner'
    if ext in {'.zip','.7z','.tar','.gz'}: return 'archive_not_uploaded; expanded release code indexed separately'
    if c == 'project' and ('01-intake/' in low):
        if ext == '.xlsx' and any(x in name for x in ['konversi','master_hs']): return None
        return 'raw_intake_dataset_or_recording; source metadata retained elsewhere'
    if ext in {'.xlsx','.xls','.csv','.html'} and (name.startswith(('sampel_mfg','sampel_')) or re.fullmatch(r'si\d{4}\.xlsx',name)):
        return 'raw_or_safe_sample_microdata; anonymisation_does_not_make_it_an_aggregate'
    if c == 'project' and low.startswith('04-working-understanding/20260910-github-harness/'):
        return 'local_publication_build_evidence; curated catalogue replaces raw operational inventory'
    if c == 'old_deasy':
        # The drive mixes the manufacturing source with a separate poverty paper.
        if not low.startswith('kuesioner/') or 'ibs' not in name:
            return 'separate_china_shock_poverty_project; only IBS questionnaires relevant here'
    if c == 'cips_harness':
        if low.startswith(('db/','viewer/')): return 'live_database_or_generated_viewer; research mirror retained'
        if name == 'prompts.md': return 'stale_template_mentions_unrelated_projects; not a valid research instruction'
        if low.startswith('_source/') and ext not in {'.pdf','.docx','.do','.ado','.xlsx','.pptx'}:
            return 'raw_communication_or_photo; relevant research attachments handled separately'
        if low.startswith('mirror/sessions/'):
            return 'retained_session_content_not_part_of_code_or_research_references'
    if name == '_chat.txt' or 'transcript' in name or 'agent-chat-history' in name:
        return 'raw_communication_not_uploaded; curated research context retained'
    if name.startswith('home') and size > 50000:
        return 'full_shared_home_body; unrelated_private_work_not_uploaded'
    if ext == '.json' and any(x in name for x in ['home-','receipt','inbox','readback']):
        if name not in {'snapshot-package-receipt.json','snapshot-first-comparison-receipt.json'}:
            return 'operational_message_or_home_payload; not research data'
    if ext in {'.csv','.xlsx','.html','.htm'} and ('_preview.' in low or 'ready_preview' in low):
        return 'observation_preview_may_contain_microdata'
    if ext not in ALLOWED and name not in {'makefile','.gitignore','requirements.txt'}: return 'unsupported_or_runtime_file_type'
    if size > 95_000_000: return 'oversize_file_requires_separate_review'
    return None

def inspect_content(rel: str, b: bytes) -> tuple[str | None, dict]:
    ext=PurePosixPath(rel).suffix.lower(); meta={}
    if ext in TEXT_EXT and SECRET.search(b): return 'credential_pattern_detected; content not copied',meta
    if ext == '.csv':
        try:
            rows=csv.reader(io.StringIO(b.decode('utf-8-sig',errors='replace'))); header=next(rows,[])
            n=sum(1 for _ in rows); keys={x.strip().lower() for x in header}
            meta={'rows':n,'columns':len(header),'headers':header}
            if 'hs2022' in keys and any(k.startswith('kbli') for k in keys):
                meta['classification']='product_industry_concordance; no establishment observations'
                return None,meta
            if keys & UNIT_KEYS:
                if not (keys <= {'scope','variable','psid','year','waran','source','abs_diff'} and n == 0):
                    return 'unit_record_identifier_columns; microdata_or_observation_diagnostics',meta
            if n>10000 and not keys & AGGREGATE_WORDS:
                return 'large_nonaggregate_table_requires_review',meta
        except Exception as e: return 'csv_inspection_failed:'+type(e).__name__,meta
    elif ext == '.xlsx':
        try:
            wb=openpyxl.load_workbook(io.BytesIO(b),read_only=True,data_only=False)
            sheets=[]; questionable=[]
            for ws in wb:
                heads=[]
                for row in ws.iter_rows(min_row=1,max_row=min(12,ws.max_row or 12),values_only=True):
                    heads.extend(str(v).strip().lower() for v in row if isinstance(v,str))
                keys=set(heads)
                sheets.append({'name':ws.title,'rows':ws.max_row,'columns':ws.max_column})
                # A data dictionary describes names in rows; it is not microdata.
                dictionary=(any(v in ws.title.lower() for v in ['dictionary','field map','name_map']) or bool(keys & {'variable','field','storage_type','stata_type','description'}))
                if keys & UNIT_KEYS and (ws.max_row or 0)>30 and not dictionary: questionable.append(ws.title)
            wb.close();meta={'sheets':sheets,'classification':'aggregate_results_or_reference_metadata'}
            if questionable:return 'workbook_unit_record_headers_require_review:'+','.join(questionable),meta
        except Exception as e: return 'workbook_inspection_failed:'+type(e).__name__,meta
    elif ext == '.xls':
        return 'legacy_workbook_requires_content_review',meta
    elif ext in {'.log','.smcl'}:
        # Retain aggregate logs; withhold row listings rather than leak data.
        if re.search(rb'(?mi)^\s*\.\s*(?:list|li)\s+(?:psid|firm_id|source_row|_all)\b',b):
            return 'stata_log_contains_unit_record_listing',meta
    return None,meta

def main():
    CAT.mkdir(exist_ok=True)
    inv=json.loads((LOCAL/'source-inventory.json').read_text())
    records=[];workbooks=[];errors=[]
    def item(c,rel,n,read,source,symlink=False):
        reason=base_policy(c,rel,n,symlink);b=None;meta={}
        if reason is None:
            try:
                b=read();n=len(b);reason,meta=inspect_content(rel,b)
            except Exception as e:reason='read_failed:'+type(e).__name__;errors.append(source)
        rec={'collection':c,'source':source,'source_relative_path':rel,'bytes':n,'disposition':'excluded' if reason else 'included','reason':reason or 'code_document_aggregate_or_reference','sha256':digest(b) if b is not None else '', 'repository_path':''}
        if not reason:
            dst=destination(c,rel);target=ROOT/dst;target.parent.mkdir(parents=True,exist_ok=True)
            if not target.exists() or digest(target.read_bytes()) != rec['sha256']: target.write_bytes(b)
            rec['repository_path']=dst
        else:
            # Preserve an earlier staged copy locally if a stricter review now
            # excludes it. It must not remain in the publication tree.
            target=ROOT/destination(c,rel)
            if target.is_file():
                private=LOCAL/'withheld-staging'/destination(c,rel)
                private.parent.mkdir(parents=True,exist_ok=True)
                if private.exists() and digest(private.read_bytes())==digest(target.read_bytes()):
                    private=private.with_name(private.name+'.second-screening-copy')
                shutil.move(str(target),str(private))
        if meta:
            rec['content_inspection']=meta
            if rel.lower().endswith('.xlsx'):workbooks.append(rec)
        records.append(rec)
    for x in inv:
        p=Path(x['root'])/x['relative_path']
        item(x['collection'],x['relative_path'],x['bytes'],p.read_bytes,str(p),x['symlink'])
    zpath=Path('/Users/natanaelmassie/Downloads/ludi-handover-20260825.zip')
    with zipfile.ZipFile(zpath) as z:
        for i in z.infolist():
            if i.is_dir(): continue
            rel=str(PurePosixPath(i.filename).relative_to('001-LUDI Handover'))
            assert '..' not in PurePosixPath(rel).parts
            item('ludi-handover',rel,i.file_size,lambda i=i:z.read(i),str(zpath)+'!/'+i.filename)
    (CAT/'source-files.json').write_text(json.dumps(records,ensure_ascii=False,indent=2)+'\n')
    fields=['collection','source','source_relative_path','bytes','disposition','reason','sha256','repository_path']
    with (CAT/'source-files.csv').open('w',newline='') as f:
        w=csv.DictWriter(f,fieldnames=fields,extrasaction='ignore');w.writeheader();w.writerows(records)
    (CAT/'workbook-screening.json').write_text(json.dumps(workbooks,ensure_ascii=False,indent=2)+'\n')
    summary={'timestamp':datetime.now(ZoneInfo('Asia/Jakarta')).isoformat(),'files_considered':len(records),'included':sum(r['disposition']=='included' for r in records),'excluded':sum(r['disposition']=='excluded' for r in records),'included_bytes':sum(r['bytes'] for r in records if r['disposition']=='included'),'exclusion_reasons':dict(Counter(r['reason'] for r in records if r['disposition']=='excluded')),'read_errors':errors,'analysis_executed':False}
    (CAT/'snapshot-summary.json').write_text(json.dumps(summary,indent=2)+'\n')
    print(json.dumps(summary,indent=2))

if __name__ == '__main__': main()
