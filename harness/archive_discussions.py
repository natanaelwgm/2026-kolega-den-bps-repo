#!/usr/bin/env python3
"""Export retained discussion text as small, ordered workspace/terminal/day JSON.

Reads explicit provider source paths, never authenticates, wakes a terminal,
reads a live TailTerm database, or sends a message. Internal reasoning, system
instructions, and raw tool outputs are not discussion records and are excluded.
"""
import argparse
from collections import Counter, defaultdict
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import re
from zoneinfo import ZoneInfo

TZ = ZoneInfo('Asia/Jakarta')
SECRET_PATTERNS = [
    r'\b(?:gh[pousr]_[A-Za-z0-9]{30,}|github_pat_[A-Za-z0-9_]{30,})\b',
    r'\bsk-(?:proj-)?[A-Za-z0-9_-]{30,}\b',
    r'\b\d{7,12}:[A-Za-z0-9_-]{30,}\b',
    r'\bAKIA[A-Z0-9]{16}\b',
    r'(?i)\bBearer\s+[A-Za-z0-9._~-]{24,}',
    r'-----BEGIN (?:RSA |EC |OPENSSH )?PRIVATE KEY-----[\s\S]*?-----END (?:RSA |EC |OPENSSH )?PRIVATE KEY-----',
]

def digest(data):
    return hashlib.sha256(data).hexdigest()

def clean_text(text):
    reasons = Counter()
    for pattern in SECRET_PATTERNS:
        text, n = re.subn(pattern, '[REDACTED: credential]', text)
        reasons['credential'] += n
    text, n = re.subn(r'<think>[\s\S]*?</think>', '[Internal reasoning omitted]', text, flags=re.I)
    reasons['internal_reasoning'] += n
    # A retained explanation prints three actual company rows as an example.
    # Keep the explanation and schema, while omitting those observation values.
    if 'raw_ltlnou10' in text and 'source_row' in text:
        text, n = re.subn(r'^\|\s*(?:2010\s*\|\s*)?[1-3]\s*\|[^\n]*$', '| [REDACTED: original company-record values] |', text, flags=re.M)
        reasons['company_record_example'] += n
    return text, {k:v for k,v in reasons.items() if v}

def content_text(content):
    if isinstance(content, str):
        return content
    if isinstance(content, list):
        return '\n'.join(x.get('text','') for x in content if isinstance(x,dict) and str(x.get('type','')).lower() in {'text','input_text','output_text'})
    return ''

def slug(text):
    return re.sub(r'[^a-z0-9]+','-',text.lower()).strip('-')[:78] or 'untitled'

def native_records(source):
    path = Path(source['path'])
    size = path.stat().st_size
    sha = hashlib.sha256()
    records, seen, kinds, errors = [], set(), Counter(), []
    with path.open('rb') as f:
        line_number = 0
        while f.tell() < size:
            line = f.readline(size-f.tell()); line_number += 1;sha.update(line)
            try:
                row=json.loads(line)
            except ValueError:
                errors.append({'line':line_number,'reason':'incomplete or invalid JSON at frozen byte boundary'}); continue
            payload=row.get('payload',{}); kinds[f"{row.get('type')}:{payload.get('type')}"]+=1
            item = payload.get('item',{})
            record = None
            if row.get('type')=='event_msg' and payload.get('type')=='item_completed' and item.get('type') in {'UserMessage','AgentMessage'}:
                if item.get('type')=='AgentMessage' and item.get('phase') not in {None,'commentary','final_answer'}:
                    continue
                record={'id':item.get('id') or f'line-{line_number}','turn_id':payload.get('turn_id'),'role':'user' if item['type']=='UserMessage' else 'assistant','phase':item.get('phase'),'content':content_text(item.get('content',[]))}
            elif row.get('type')=='response_item' and payload.get('type')=='agent_message':
                record={'id':payload.get('id') or f'line-{line_number}','role':'agent_to_agent','author':payload.get('author'),'recipient':payload.get('recipient'),'content':content_text(payload.get('content',[]))}
            if record is None or not record['content'] or record['id'] in seen:
                continue
            seen.add(record['id'])
            record.update(timestamp=row['timestamp'],source_line=line_number,source_ordinal=row.get('ordinal'))
            original=record['content'];record['content'], redactions=clean_text(original)
            record['source_content_sha256']=digest(original.encode())
            if redactions:record['redactions']=redactions
            records.append(record)
    return records, {'frozen_source_bytes':size,'frozen_source_sha256':sha.hexdigest(),'record_types':dict(kinds),'parse_errors':errors}

def hermes_records(source):
    data=Path(source['path']).read_bytes();records=[];kinds=Counter()
    for line_number,line in enumerate(data.splitlines(),1):
        row=json.loads(line);kinds[row.get('role')]+=1
        if row.get('role') not in {'user','assistant'} or not row.get('content'):
            continue
        original=content_text(row['content']);text,redactions=clean_text(original)
        record={'id':str(row['id']),'role':row['role'],'timestamp':datetime.fromtimestamp(row['timestamp'],timezone.utc).isoformat(),'source_line':line_number,'content':text,'source_content_sha256':digest(original.encode())}
        if redactions:record['redactions']=redactions
        records.append(record)
    return records, {'frozen_source_bytes':len(data),'frozen_source_sha256':digest(data),'record_types':dict(kinds),'parse_errors':[],'retention_scope':'active=1 records in the already retained export; inactive/compacted-away branches are not present'}

def encoded(value):
    return (json.dumps(value,ensure_ascii=False,indent=2)+'\n').encode()

def split_record(record, max_bytes):
    """Split an oversized message without dropping text or losing source identity."""
    if len(encoded(record)) < max_bytes-20000:
        return [record]
    text=record['content']; pieces=[]
    while text:
        lo,hi=1,len(text)
        while lo<hi:
            mid=(lo+hi+1)//2
            if len(encoded({**record,'content':text[:mid]})) < max_bytes-20000:lo=mid
            else:hi=mid-1
        pieces.append(text[:lo]);text=text[lo:]
    return [{**record,'content':s,'content_part':n+1,'content_parts':len(pieces)} for n,s in enumerate(pieces)]

def write_source(source, records, receipt, out, max_bytes):
    workspace=source.get('workspace') or ('1014-codex-review-20260913' if '/Documents/Codex/' in source['cwd'] else '1014-TFP-Estimation' if '/.worktrees/' in source['cwd'] else '1014-deasy-imed-si-new-data-paper')
    spawn=source.get('origin',{}).get('subagent',{}).get('thread_spawn',{}) if isinstance(source.get('origin'),dict) else {}
    title=source.get('terminal_name') or source.get('title') or spawn.get('agent_path') or source['id']
    terminal=f"{slug(title)}--{source['id'][:13]}"
    folder=Path(slug(workspace))/terminal
    days=defaultdict(list)
    for r in records:
        stamp=datetime.fromisoformat(r['timestamp'].replace('Z','+00:00'))
        day=stamp.astimezone(TZ).strftime('%Y-%m-%d')
        days[day].extend(split_record(r,max_bytes))
    source_meta={'source_id':source['id'],'title':source.get('title'),'terminal_name':source.get('terminal_name'),'workspace':workspace,'cwd':source['cwd'],'provider':source.get('provider','codex'),'parent_thread_id':spawn.get('parent_thread_id') or source.get('parent_thread_id'),'agent_path':spawn.get('agent_path')}
    parts=[]
    for day,items in sorted(days.items()):
        batches=[];batch=[]
        for record in items:
            test={'schema_version':1,'timezone':'Asia/Jakarta','source':source_meta,'date':day,'part':9999,'messages':batch+[record]}
            if batch and len(encoded(test))>max_bytes:batches.append(batch);batch=[]
            batch.append(record)
        if batch:batches.append(batch)
        for number,batch in enumerate(batches,1):
            name=folder/day/f'{day}--{terminal}--part-{number:03}.json'
            payload={'schema_version':1,'timezone':'Asia/Jakarta','source':source_meta,'date':day,'part':number,'messages':batch}
            data=encoded(payload);assert len(data)<=max_bytes,(name,len(data))
            target=out/name;target.parent.mkdir(parents=True,exist_ok=True);target.write_bytes(data)
            parts.append({'path':name.as_posix(),'date':day,'part':number,'message_fragments':len(batch),'bytes':len(data),'sha256':digest(data),'first_timestamp':batch[0]['timestamp'],'last_timestamp':batch[-1]['timestamp']})
    # Independently reopen all parts and reconstruct every original message.
    reconstructed=defaultdict(str)
    for part in parts:
        loaded=json.loads((out/part['path']).read_text())
        for r in loaded['messages']:reconstructed[r['id']]+=r['content']
    assert len(reconstructed)==len(records)
    assert all(reconstructed[r['id']]==r['content'] for r in records)
    return {**source_meta,**receipt,'messages':len(records),'roles':dict(Counter(r['role'] for r in records)),'redactions':dict(sum((Counter(r.get('redactions',{})) for r in records),Counter())),'parts':parts,'reconstruction_verified':True}

def main():
    parser=argparse.ArgumentParser();parser.add_argument('--sources',type=Path,required=True);parser.add_argument('--out',type=Path,required=True);parser.add_argument('--max-bytes',type=int,default=1000000)
    args=parser.parse_args();assert args.max_bytes>=50000
    meta=json.loads(args.sources.read_text());results=[]
    for source in meta['sources']:
        records,receipt=(hermes_records(source) if source.get('provider')=='hermes' else native_records(source))
        results.append(write_source(source,records,receipt,args.out,args.max_bytes))
    index={'schema_version':1,'created_at':datetime.now(TZ).isoformat(),'max_part_bytes':args.max_bytes,'discussion_scope':'User messages, user-facing assistant messages, and explicit agent-to-agent correspondence. Raw tool outputs, internal reasoning, system/context payloads and credentials are excluded.','sources':results,'source_count':len(results),'messages':sum(r['messages'] for r in results),'parts':sum(len(r['parts']) for r in results),'all_reconstruction_checks_passed':all(r['reconstruction_verified'] for r in results)}
    args.out.mkdir(parents=True,exist_ok=True);(args.out/'index.json').write_bytes(encoded(index))
    print(json.dumps({k:v for k,v in index.items() if k!='sources'},ensure_ascii=False))

if __name__=='__main__':main()
