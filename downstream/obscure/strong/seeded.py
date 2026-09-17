"""Domain-separated keyed draws and exact encrypted owner recovery."""
from pathlib import Path
import hashlib,hmac,secrets,io,json,zipfile
from cryptography.hazmat.primitives.ciphers.aead import AESGCM
from policy import VERSION

MAGIC=b'KOLEGA-RECOVERY-V2\n'

def sha(p):
    h=hashlib.sha256()
    with Path(p).open('rb') as f:
        for b in iter(lambda:f.read(4*1024**2),b''):h.update(b)
    return h.hexdigest()

def digest(key,source,obs,channel,attempt=0):
    return hmac.new(key,json.dumps([VERSION,source,str(obs),channel,attempt],separators=(',',':')).encode(),hashlib.sha256).digest()

def factor(key,source,obs,channel,attempt=0):
    d=digest(key,source,obs,channel,attempt)
    return 1+(-1 if d[8]&1 else 1)*(.20+.10*int.from_bytes(d[:8],'big')/2**64)

def recovery_key(seed):
    return hmac.new(seed,b'kolega-owner-recovery-encryption-v2',hashlib.sha256).digest()

def encrypt_recovery(seed,files,target):
    buf=io.BytesIO()
    with zipfile.ZipFile(buf,'w',zipfile.ZIP_DEFLATED,compresslevel=3) as z:
        for name,content in files.items():z.writestr(name,content)
    nonce=secrets.token_bytes(12)
    Path(target).write_bytes(MAGIC+nonce+AESGCM(recovery_key(seed)).encrypt(nonce,buf.getvalue(),MAGIC))

def decrypt_recovery(seed,path):
    payload=Path(path).read_bytes()
    if not payload.startswith(MAGIC):raise ValueError('Wrong recovery format')
    rest=payload[len(MAGIC):]
    plain=AESGCM(recovery_key(seed)).decrypt(rest[:12],rest[12:],MAGIC)
    with zipfile.ZipFile(io.BytesIO(plain)) as z:return {n:z.read(n) for n in z.namelist()}
