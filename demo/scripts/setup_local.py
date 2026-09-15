#!/usr/bin/env python3
"""Install a readable local owner folder without copying original company datasets."""
from pathlib import Path
import argparse
import json
import shutil
import sys
from datetime import datetime
from workflow import sha,quoted


def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--destination',type=Path,required=True);p.add_argument('--actual-g0',type=Path);p.add_argument('--original-g0-workspace',type=Path)
    a=p.parse_args();home=Path(__file__).resolve().parents[1];repo=home.parent;target=a.destination.resolve()
    if target==home or target.is_relative_to(repo):raise ValueError('Choose an owner folder outside the repository')
    target.mkdir(parents=True,exist_ok=True)
    archive=target/'prior-setup'/datetime.now().strftime('%Y%m%d-%H%M%S-%f')
    records=[]
    for source in sorted(home.rglob('*')):
        if not source.is_file() or any(x in source.parts for x in ['__pycache__','.git']):continue
        if source.name in ['local_paths.do','run_overrides.local.do','.gitignore'] or source.suffix in ['.pyc','.log']:continue
        rel=source.relative_to(home);dest=target/rel
        if dest.exists() and sha(dest)!=sha(source):
            prior=archive/rel;prior.parent.mkdir(parents=True,exist_ok=True)
            if prior.exists(): raise ValueError('Prior setup archive exists; choose a new destination')
            shutil.copy2(dest,prior)
        dest.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(source,dest)
        records.append({'path':str(rel),'sha256':sha(dest)})
    stata=shutil.which('stata-se') or shutil.which('stata') or 'stata-se'
    lines=[f'global RUN_REPO {quoted(repo)}',f'global RUN_OUTPUT {quoted(target/"runs")}',
           f'global RUN_PYTHON {quoted(sys.executable)}',f'global RUN_STATA {quoted(stata)}']
    if a.actual_g0:lines.append(f'global RUN_ACTUAL_PATH {quoted(a.actual_g0.resolve())}')
    if a.original_g0_workspace:lines.append(f'global G0_ORIGINAL_ROOT {quoted(a.original_g0_workspace.resolve())}')
    local=target/'local_paths.do'
    if local.exists() and local.read_text()!='\n'.join(lines)+'\n':raise ValueError('Existing local_paths.do differs; preserve/review it before changing the setup')
    local.write_text('\n'.join(lines)+'\n')
    (target/'Run.command').chmod(0o755)
    (target/'setup-receipt.json').write_text(json.dumps({'repository':str(repo),'owner_folder':str(target),'files':records,'restricted_data_copied':False},indent=2)+'\n')
    print(target)

if __name__=='__main__':main()
