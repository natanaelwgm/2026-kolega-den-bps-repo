"""Exercise the comment-overlay boundary without touching production code."""
# WFDOC: Uji membuat salinan sementara builder dan vendor lalu memeriksa aturan overlay tanpa mengubah adapter produksi atau menjalankan Stata.
from pathlib import Path
import hashlib,json,shutil,subprocess,sys,tempfile
R=Path(__file__).resolve().parent.parent
with tempfile.TemporaryDirectory(prefix='g1-comment-overlay-') as tmp:
    d=Path(tmp); (d/'vendor').mkdir()
    shutil.copyfile(R/'build_adapter.py',d/'build_adapter.py')
    shutil.copyfile(R/'vendor/prodest.ado',d/'vendor/prodest.ado')
    def build(ok):
        p=subprocess.run([sys.executable,str(d/'build_adapter.py')],capture_output=True,text=True)
        assert (p.returncode==0)==ok,p.stderr
    build(True)
    base=(d/'g1_prodest_point.ado').read_bytes(); sha=hashlib.sha256(base).hexdigest()
    lines=base.decode().splitlines(); mata=lines.index('mata:')+2
    # WFDOC: Kasus menerima komentar Stata biasa dan komentar Mata //, tetapi menolak teks eksekusi, hash dasar yang salah, dan prefiks Stata di dalam Mata.
    cases=[({'base_sha256':sha,'insertions':[{'before_line':1,'text':'* WFDOC: Penjelasan komentar; tanpa mengubah kode.'}]},True),
        ({'base_sha256':sha,'insertions':[{'before_line':1,'text':'display 99'}]},False),
        ({'base_sha256':'0'*64,'insertions':[]},False),
        ({'base_sha256':sha,'insertions':[{'before_line':mata,'text':'* WFDOC: Invalid Mata comment'}]},False),
        ({'base_sha256':sha,'insertions':[{'before_line':mata,'text':'// WFDOC: Komentar Mata yang sah.'}]},True)]
    for overlay,ok in cases:
        (d/'adapter-commentary.json').write_text(json.dumps(overlay))
        build(ok)
        if ok:
            rebuilt=(d/'g1_prodest_point.ado').read_text()
            stripped=''.join(line for line in rebuilt.splitlines(True) if 'WFDOC:' not in line)
            assert stripped.encode()==base
# WFDOC: Setelah setiap overlay yang diterima, hapus baris WFDOC dan bandingkan byte adapter dengan hasil build dasar; receipt merangkum dua penerimaan dan tiga penolakan.
receipt={'status':'PASS','cases':5,'accepted':2,'rejected':3,'scientific_bytes_identical_after_comment_removal':True,'builder_sha256':hashlib.sha256((R/'build_adapter.py').read_bytes()).hexdigest()}
(R/'tests/overlay-validation.json').write_text(json.dumps(receipt,indent=2)+'\n')
print(json.dumps(receipt,indent=2))
