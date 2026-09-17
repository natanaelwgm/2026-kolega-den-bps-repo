"""Single-process byte-exact relay for a unique owned Stata batch log.

Prototype only until logging freeze. It does not spawn or manage any process.
The caller rejects all candidate paths before spawning; poll selects exactly one
new batch file. Streamed bytes remain private, alongside the original batch log.
"""
from pathlib import Path
import hashlib

class OwnedLogRelay:
    def __init__(self,candidates,sink,chunk_bytes=262144):
        self.candidates=[Path(p) for p in candidates]
        assert len(set(self.candidates))==len(self.candidates)
        assert all(not p.exists() and not p.is_symlink() for p in self.candidates), 'Owned batch name existed before launch'
        self.sink=sink;self.chunk_bytes=chunk_bytes;self.path=None;self.identity=None;self.offset=0;self.digest=hashlib.sha256()
    def poll(self):
        existing=[p for p in self.candidates if p.exists() or p.is_symlink()]
        assert len(existing)<=1,'Ambiguous owned batch locations'
        if not existing:return 0
        p=existing[0];assert p.is_file() and not p.is_symlink(),'Batch log must be a regular owned file'
        st=p.stat();identity=(st.st_dev,st.st_ino)
        if self.path is None:self.path=p;self.identity=identity
        assert p==self.path and identity==self.identity,'Owned batch file replaced'
        assert st.st_size>=self.offset,'Owned batch file truncated'
        with p.open('rb') as f:f.seek(self.offset);data=f.read(self.chunk_bytes)
        if data:
            self.sink.write(data);self.sink.flush();self.digest.update(data);self.offset+=len(data)
        return len(data)
    def finish(self):
        while self.poll():pass
        assert self.path is not None,'Owned batch file never appeared'
        st=self.path.stat();assert st.st_size==self.offset
        h=hashlib.sha256()
        with self.path.open('rb') as f:
            for b in iter(lambda:f.read(1048576),b''):h.update(b)
        assert h.hexdigest()==self.digest.hexdigest(),'Relay does not match complete final batch bytes'
        return {'status':'passed','source_path':str(self.path),'bytes_streamed':self.offset,'sha256':h.hexdigest(),'identity':list(self.identity),'scope':'complete owned batch bytes; caller separately proves PID exit'}
