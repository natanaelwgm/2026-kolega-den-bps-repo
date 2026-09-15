#!/usr/bin/env python3
"""Build searchable text companions from retained research documents only."""
from pathlib import Path
from xml.etree import ElementTree as ET
from urllib.parse import quote
from concurrent.futures import ThreadPoolExecutor
import csv,json,os,re,subprocess,zipfile
ROOT=Path(__file__).resolve().parents[1]
W='{http://schemas.openxmlformats.org/wordprocessingml/2006/main}'
A='{http://schemas.openxmlformats.org/drawingml/2006/main}'

def convert(row):
    p=ROOT/row['repository_path'];ext=p.suffix.lower();sha=row['sha256']
    stem=re.sub('[^A-Za-z0-9._-]+','-',p.stem)[:80]
    dst=ROOT/'references/text'/f'{sha[:16]}-{stem}.md'
    status='text_extracted';pages=None
    try:
        if ext=='.pdf':
            cp=subprocess.run(['pdftotext','-layout','-enc','UTF-8',str(p),'-'],capture_output=True,timeout=45)
            if cp.returncode:raise ValueError('pdftotext return '+str(cp.returncode))
            t=cp.stdout.decode('utf-8',errors='replace');parts=t.split('\f');pages=len(parts)-(1 if parts and not parts[-1].strip() else 0)
            text='\n\n'.join(f'## PDF page {i+1}\n\n```text\n{s.strip()}\n```' for i,s in enumerate(parts) if s.strip())
            if len(t.strip())<80:status='little_or_no_text_layer; original retained; OCR not claimed'
        else:
            sections=[]
            with zipfile.ZipFile(p) as z:
                if ext=='.docx':
                    names=[n for n in z.namelist() if n=='word/document.xml' or re.match(r'word/(?:footnotes|endnotes|comments|header\d+|footer\d+)\.xml$',n)]
                    for name in names:
                        tree=ET.fromstring(z.read(name));paras=[]
                        for par in tree.iter(W+'p'):
                            s=''.join(x.text or '' for x in par.iter(W+'t'))
                            if s.strip():paras.append(s)
                        sections.append('## '+name+'\n\n'+'\n\n'.join(paras))
                else:
                    names=sorted([n for n in z.namelist() if re.match(r'ppt/slides/slide\d+\.xml$',n)],key=lambda s:int(re.search(r'slide(\d+)',s).group(1)))
                    for name in names:
                        tree=ET.fromstring(z.read(name));sections.append('## '+name+'\n\n'+'\n'.join(x.text or '' for x in tree.iter(A+'t')))
            text='\n\n'.join(sections)
        source=os.path.relpath(p,dst.parent)
        hdr=f'# Text companion — {p.name}\n\nSource: [{p.name}]({quote(source,safe="/._-")}). SHA256 `{sha}`.\n\nThis is a searchable extraction, not a new review or a reformatted authoritative paper. Original tables/figures, layout, tracked changes and equation rendering remain authoritative in the source. Empty text layers are explicitly reported; no OCR is implied.\n\n'
        dst.parent.mkdir(exist_ok=True,parents=True);dst.write_text(hdr+text+'\n')
        return {'sha256':sha,'repository_path':row['repository_path'],'text_path':str(dst.relative_to(ROOT)),'status':status,'pages':pages,'text_characters':len(text)}
    except Exception as e:
        return {'sha256':sha,'repository_path':row['repository_path'],'text_path':'','status':'extraction_failed: '+str(e),'pages':None,'text_characters':0}

def main():
    sources=json.loads((ROOT/'catalog/source-files.json').read_text())
    docs=[r for r in sources if r['disposition']=='included' and Path(r['repository_path']).suffix.lower() in {'.docx','.pdf','.pptx'}]
    unique={}
    for r in docs:unique.setdefault(r['sha256'],r)
    with ThreadPoolExecutor(max_workers=4) as ex:results=list(ex.map(convert,unique.values()))
    bysha={r['sha256']:r for r in results}
    index=[dict(bysha[r['sha256']],collection=r['collection'],repository_path=r['repository_path'],source=r['source']) for r in docs]
    (ROOT/'catalog/documents.json').write_text(json.dumps(index,ensure_ascii=False,indent=2)+'\n')
    with (ROOT/'catalog/documents.csv').open('w',newline='') as f:
        w=csv.DictWriter(f,fieldnames=list(index[0]));w.writeheader();w.writerows(index)
    print(json.dumps({'source_documents':len(docs),'unique_documents':len(results),'text_extracted':sum(r['status']=='text_extracted' for r in results),'exceptions':[r for r in results if r['status']!='text_extracted']},indent=2))

if __name__=='__main__':main()
