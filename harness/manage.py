#!/usr/bin/env python3
"""Read-only request navigation, review prompts, and repository validation."""
from pathlib import Path
from urllib.parse import unquote
from xml.etree import ElementTree as ET
from collections import Counter
from datetime import datetime
from zoneinfo import ZoneInfo
import argparse,hashlib,json,re,sys,zipfile
ROOT=Path(__file__).resolve().parents[1]
FORBIDDEN={'.dta','.dbf','.parquet','.feather','.arrow','.rds','.rdata','.sav','.sas7bdat','.sqlite','.sqlite3','.db','.stswp','.zip','.7z'}
SECRET=re.compile(rb'(?:gh[pousr]_[A-Za-z0-9]{30,}|github_pat_[A-Za-z0-9_]{40,}|sk-(?:proj-|ant-)?[A-Za-z0-9_-]{32,}|AIza[A-Za-z0-9_-]{30,}|-----BEGIN (?:RSA |OPENSSH |EC )?PRIVATE KEY-----)')

def sha(p):
    h=hashlib.sha256()
    with p.open('rb') as f:
        for b in iter(lambda:f.read(1024*1024),b''):h.update(b)
    return h.hexdigest()

def synthetic_publication_allowed(path, records):
    """Exact hash-bound exception for executed fictional G0 states, never an arbitrary directory bypass."""
    rel=str(path.relative_to(ROOT))
    return (rel.startswith('data/synthetic-development/g0-pipeline/')
            and path.suffix.lower()=='.dta' and rel in records
            and (records[rel].get('kind')=='executed_synthetic_Stata_state' or (records[rel].get('kind')=='actual_WPI_reference_no_company_observations' and ('/references/toar-wpi-20260910/' in rel or '/dag/data/references/WPI_' in rel)))
            and sha(path)==records[rel].get('sha256'))

def g05_publication_allowed(path, records):
    """Owner-authorised, exact hash-bound G0.5 parts only; not a directory bypass."""
    rel=str(path.relative_to(ROOT))
    return (rel.startswith('data/g0-5-development/waves/') and path.suffix=='.parquet'
            and rel in records and sha(path)==records[rel]['sha256'])

def validate():
    failures=[];rows=json.loads((ROOT/'requests/registry.json').read_text());sources=json.loads((ROOT/'catalog/source-files.json').read_text())
    if len(rows)!=44 or len({r['request_id'] for r in rows})!=44:failures.append('Request count/unique IDs must be 44')
    families=dict(Counter(r['family'] for r in rows))
    if families!={'data':4,'descriptive':29,'estimation':11}:failures.append('Wrong family counts')
    word=ROOT/'references/deasy-word/List do file yang perlu dibuat.docx'
    if sha(word)!='027fbf675aa8001a50060561781930440ee4d9697cc790ba593452fe528edd92':failures.append('Word hash mismatch')
    ns={'w':'http://schemas.openxmlformats.org/wordprocessingml/2006/main'}
    with zipfile.ZipFile(word) as z:tree=ET.fromstring(z.read('word/document.xml'))
    tables=tree.findall('w:body/w:tbl',ns)
    exact_matches=0
    for r in rows:
        loc=re.search(r'table (\d+), row (\d+)',r['source_locator']);ti,ri=map(int,loc.groups())
        tr=tables[ti-1].findall('w:tr',ns)[ri-1];cells=[]
        for tc in tr.findall('w:tc',ns):
            cells.append('\n'.join(''.join((t.text or '') for t in par.iter('{'+ns['w']+'}t')) for par in tc.findall('w:p',ns)))
        values={'source_number':cells[0],'source_request':cells[1],
                'source_pic':cells[5] if ti==3 else cells[3],
                'source_strategy':cells[2] if ti==3 else '',
                'source_notes':cells[3] if ti==3 else '',
                'source_completion_cell':cells[4] if ti==3 else cells[2]}
        if any(r[k]!=v for k,v in values.items()):failures.append('Exact Word field mismatch '+r['request_id'])
        else:exact_matches+=1
        folder=ROOT/r['folder']
        for name in ['README.md','SOURCE.md','task.json','EVIDENCE.md','triage.md','decision.md','outputs/README.md']:
            if not (folder/name).is_file():failures.append('Missing packet file '+str(folder/name))
        if json.loads((folder/'task.json').read_text())!=r:failures.append('Packet/registry mismatch '+r['request_id'])
        if r['primary_exists'] != bool(r['primary_do'] and (ROOT/r['primary_do']).is_file()):failures.append('Primary status mismatch '+r['request_id'])
    copies=0;total=0
    included={r['repository_path']:r for r in sources if r['disposition']=='included'}
    for rel,r in included.items():
        p=ROOT/rel
        if not p.is_file():failures.append('Missing source '+rel);continue
        if sha(p)!=r['sha256']:failures.append('Source copy hash mismatch '+rel)
        copies+=1;total+=p.stat().st_size
    # Inspect actual publication trees, so stale unmanifested files cannot leak.
    synthetic_manifest=ROOT/'data/synthetic-development/g0-pipeline/results/synthetic-artifact-manifest.json'
    synthetic_records={}
    if synthetic_manifest.exists():
        sm=json.loads(synthetic_manifest.read_text())
        if sm.get('synthetic_only') is True and sha(synthetic_manifest.with_name('RUN-MANIFEST.json'))==sm.get('run_manifest_sha256'):
            synthetic_records={r['path']:r for r in sm['artifacts']}
        else:failures.append('Invalid synthetic publication manifest')
    g05_records={}
    g05=ROOT/'data/g0-5-development/manifest.json'
    if g05.exists():
        gm=json.loads(g05.read_text())
        if gm.get('data_kind')=='perturbed-development' and gm.get('status')=='PASS' and gm.get('final_results_allowed') is False:
            for item in gm['metadata_files']:
                p=(g05.parent/item['path']).resolve()
                if not p.is_relative_to(g05.parent.resolve()) or not p.is_file() or sha(p)!=item['sha256']:
                    failures.append('Invalid G0.5 metadata '+item['path'])
            g05_records={'data/g0-5-development/'+r['path']:r for r in gm['parts']}
        else:failures.append('Invalid G0.5 development manifest')
    checked=0
    for top in ['research','references','requests','docs','catalog','harness','data','work-items']:
        for p in (ROOT/top).rglob('*'):
            if not p.is_file():continue
            rel=str(p.relative_to(ROOT));n=p.name.lower();ext=p.suffix.lower();checked+=1
            if p.is_symlink():failures.append('Publication symlink '+rel)
            if '__pycache__' in p.parts:continue
            if ext in FORBIDDEN and not synthetic_publication_allowed(p,synthetic_records) and not g05_publication_allowed(p,g05_records):failures.append('Forbidden dataset/archive '+rel)
            if n.startswith('sampel_mfg') and ext=='.xlsx':failures.append('Raw sample Excel '+rel)
            if n.startswith('home') and p.stat().st_size>50000:failures.append('Full Home payload '+rel)
            if n=='_chat.txt':failures.append('Raw chat '+rel)
            if p.stat().st_size>95_000_000:failures.append('Oversize publication file '+rel)
            if ext in {'.md','.txt','.py','.do','.ado','.json','.jsonl','.csv','.yml','.yaml','.sh','.log','.js','.html'}:
                if SECRET.search(p.read_bytes()):failures.append('Credential pattern '+rel)
            if top in {'research','references'} and not rel.startswith('references/text/') and rel!='references/README.md' and rel not in included:
                failures.append('Unmanifested source copy '+rel)
    # New navigation must work. Archived source documents keep their exact bytes,
    # including historical absolute links, which are mapped in the catalogue.
    docs=[ROOT/'README.md',ROOT/'references/README.md',ROOT/'catalog/README.md']
    for d in ['docs','requests','data','work-items']:docs.extend((ROOT/d).rglob('*.md'))
    links_checked=0
    for p in docs:
        s=p.read_text();s=re.sub(r'```[\s\S]*?```','',s)
        for m in re.finditer(r'\[[^\]]*\]\(([^)]+)\)',s):
            target=m.group(1).strip('<>')
            if target.startswith(('http:','https:','mailto:','#')):continue
            target=unquote(target.split('#')[0])
            if not target:continue
            links_checked+=1
            if not (p.parent/target).exists():failures.append('Broken new link '+str(p.relative_to(ROOT))+' -> '+target)
    result={'timestamp':datetime.now(ZoneInfo('Asia/Jakarta')).isoformat(),'status':'PASS' if not failures else 'FAIL','request_count':len(rows),'families':families,'exact_word_rows_checked':exact_matches,'source_copies_hash_checked':copies,'source_bytes_checked':total,'publication_files_screened':checked,'new_navigation_links_checked':links_checked,'analysis_executed':False,'failures':failures}
    # Validation artefact is build output; it contains no source data.
    (ROOT/'catalog/validation.json').write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(result,indent=2));return 0 if not failures else 1

def main():
    a=argparse.ArgumentParser(description=__doc__);sub=a.add_subparsers(dest='command',required=True)
    sub.add_parser('list');sub.add_parser('validate')
    for cmd in ['show','prompt']:
        p=sub.add_parser(cmd);p.add_argument('request_id')
    p=sub.add_parser('find-source');p.add_argument('query')
    args=a.parse_args()
    if args.command=='validate':return validate()
    rows=json.loads((ROOT/'requests/registry.json').read_text())
    if args.command=='list':
        for r in rows:print(f'{r["request_id"]:5} {r["execution_stage"]:38} {r["title"]}')
    elif args.command=='find-source':
        q=args.query.lower()
        for r in json.loads((ROOT/'catalog/source-files.json').read_text()):
            if q in r['source'].lower():print(r['disposition'],r['repository_path'] or r['reason'],'SOURCE',r['source'])
    else:
        r=next((r for r in rows if r['request_id'].upper()==args.request_id.upper()),None)
        if not r:raise SystemExit('Unknown request ID; run list.')
        if args.command=='show':print((ROOT/r['folder']/'README.md').read_text())
        else:
            print(f'''Review/design handoff: {r['request_id']} — {r['title']}

Read README.md, docs/CURRENT-STATE.md, docs/DEPENDENCIES.md, and every file in
{r['folder']}/. Start with SOURCE.md for Deasy's exact text and PIC.

Current stage: {r['execution_stage']}.
{r['current_assessment']}

Task: reconcile the existing code and predecessor references against this row,
propose concrete changes and input requirements, and assess every definition-of-done
item in task.json. Use exact repository paths/evidence and distinguish proposed
outputs from actual files. Do not run Stata/estimators or contact coauthors from
this review prompt. Report what is ready, partial, missing or needs real data.
Preserve the source Word text, old results, verified/provisional flags and histories.
Write a bounded review in this row folder and a timestamped root agent-history entry.
If later authorised to implement, retain one primary Stata do-file for this row and
coordinate any shared input/registry change with the manager before integration.''')
    return 0

if __name__=='__main__':sys.exit(main())
