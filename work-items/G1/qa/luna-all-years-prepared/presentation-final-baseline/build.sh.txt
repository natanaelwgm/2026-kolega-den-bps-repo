#!/bin/sh
set -eu
PUB_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
cd "$PUB_DIR"
TEX_ENGINE=${XELATEX:-xelatex}
TEX_BUILD=$(mktemp -d "${TMPDIR:-/tmp}/g1-appendix.XXXXXX")
cleanup() { rm -rf "$TEX_BUILD"; }
trap cleanup EXIT HUP INT TERM
python3 - <<'PY_PREFLIGHT'
from pathlib import Path
import re
body=Path('appendix.tex').read_text()
assets=re.findall(r'\\includegraphics\[[^\]]*\]\{([^}]+)\}',body)+re.findall(r'\\GOneInput\{([^}]+)\}',body)
for asset in assets:
    path=Path(asset)
    assert path.is_file() and path.stat().st_size, 'Missing manuscript asset: '+asset
PY_PREFLIGHT
# WFDOC: Minimal dua pass; maksimum enam untuk menstabilkan lebar longtable dan rujukan sebelum PDF dipublikasikan.
for TEX_PASS in 1 2 3 4 5 6; do
    "$TEX_ENGINE" -interaction=nonstopmode -halt-on-error -file-line-error -output-directory="$TEX_BUILD" main.tex >"$TEX_BUILD/pass$TEX_PASS.txt" 2>&1 || { cat "$TEX_BUILD/pass$TEX_PASS.txt"; exit 1; }
    if [ "$TEX_PASS" -ge 2 ]; then
        if python3 - "$TEX_BUILD/main.log" <<'PY_SETTLED'
from pathlib import Path
import re,sys
text=Path(sys.argv[1]).read_text()
sys.exit(bool(re.search(r'widths have changed|Label\(s\) may have changed|Rerun to get',text,re.I)))
PY_SETTLED
        then break; fi
    fi
done
test -s "$TEX_BUILD/main.pdf"
python3 - "$TEX_BUILD/main.log" <<'PY_CHECK'
from pathlib import Path
import re,sys
text=Path(sys.argv[1]).read_text()
problems=[line for line in text.splitlines() if re.search(r'undefined|multiply defined|destination with the same identifier|Overfull|ignored error:|widths have changed|Label\(s\) may have changed|Rerun to get',line,re.I)]
assert not problems, 'Final TeX pass has unresolved references, duplicate anchors, overflow or an ignored error:\n'+'\n'.join(problems)
PY_CHECK
mkdir -p provenance
cp "$TEX_BUILD/main.log" provenance/compile.log
cp "$TEX_BUILD/main.aux" provenance/compiled-labels.aux
cp "$TEX_BUILD/main.pdf" .G1-Appendix.pdf.new
mv -f .G1-Appendix.pdf.new G1-Appendix.pdf
python3 - "$TEX_PASS" <<'PY_BUILD'
from pathlib import Path
import hashlib,json,re,subprocess,sys
p=Path('.');body=(p/'appendix.tex').read_text()
figures=re.findall(r'\\includegraphics\[[^\]]*\]\{([^}]+)\}',body)
tables=re.findall(r'\\GOneInput\{(tables/[^}]+)\}',body)
paths=[p/'main.tex',p/'appendix.tex',p/'g1-appendix.sty',*[p/x for x in tables],*[p/x for x in figures],p/'G1-Appendix.pdf']
receipt={'status':'COMPILED_STABLE_XELATEX_PASSES_VISUAL_REVIEW_SEPARATE','compile_passes':int(sys.argv[1]),'figures_used':figures,'tables_used':tables,'files':[{'path':str(f),'sha256':hashlib.sha256(f.read_bytes()).hexdigest()} for f in paths]}
try: receipt['pdfinfo']=subprocess.check_output(['pdfinfo','G1-Appendix.pdf'],text=True)
except FileNotFoundError: receipt['pdfinfo']='Unavailable'
(p/'provenance/pdf-build.json').write_text(json.dumps(receipt,indent=2)+'\n')
print(receipt['status'])
PY_BUILD
