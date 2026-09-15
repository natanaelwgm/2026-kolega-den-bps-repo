#!/usr/bin/env python3
"""Render the final PDF and check real link targets; human visual review is separate."""
import argparse
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import subprocess
import sys

try:
    from pypdf import PdfReader
except ImportError:
    # WFDOC: Pustaka murni Python dari runtime desktop; tidak menginstal atau mengubah lingkungan.
    bundled = Path.home() / '.cache/codex-runtimes/codex-primary-runtime/dependencies/python/lib/python3.12/site-packages'
    sys.path.append(str(bundled))
    from pypdf import PdfReader
from PIL import Image, ImageDraw


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--pdf', required=True, type=Path)
    parser.add_argument('--out', required=True, type=Path)
    parser.add_argument('--dpi', type=int, default=90)
    args = parser.parse_args()
    pdf = args.pdf.resolve()
    out = args.out.resolve()
    out.mkdir(parents=True, exist_ok=True)
    reader = PdfReader(str(pdf))
    destinations = reader.named_destinations
    internal = external = 0
    broken = []
    # WFDOC: Periksa objek annotation PDF, bukan hanya teks label LaTeX. Target harus menunjuk halaman PDF yang benar-benar ada.
    for number, page in enumerate(reader.pages, 1):
        for ref in page.get('/Annots', []):
            annotation = ref.get_object()
            action = annotation.get('/A', {})
            if action.get('/S') == '/URI':
                external += 1
                continue
            target = annotation.get('/Dest', action.get('/D'))
            if target is None:
                continue
            internal += 1
            if isinstance(target, str):
                if target not in destinations:
                    broken.append({'page': number, 'target': str(target)})
                else:
                    index = reader.get_destination_page_number(destinations[target])
                    if index is None or not 0 <= index < len(reader.pages):
                        broken.append({'page': number, 'target': str(target), 'reason': 'page missing'})
            elif isinstance(target, list):
                candidate = target[0]
                if isinstance(candidate, int):
                    valid = 0 <= candidate < len(reader.pages)
                else:
                    valid = any(p.indirect_reference == candidate for p in reader.pages)
                if not valid:
                    broken.append({'page': number, 'target': str(target), 'reason': 'explicit page missing'})
            else:
                broken.append({'page': number, 'target': str(target), 'reason': 'unknown destination type'})
    assert not broken, broken
    # WFDOC: Seluruh halaman dirender secara serial; contact sheet untuk inventaris visual, halaman asli untuk pemeriksaan dekat.
    pages = out / 'pages'
    pages.mkdir(exist_ok=True)
    subprocess.run(['pdftoppm', '-r', str(args.dpi), '-png', str(pdf), str(pages / 'page')], check=True)
    images = sorted(pages.glob('page-*.png'))
    assert len(images) == len(reader.pages)
    sheets = out / 'contact-sheets'
    sheets.mkdir(exist_ok=True)
    for start in range(0, len(images), 6):
        subset = images[start:start + 6]
        sheet = Image.new('RGB', (2100, 3000), '#d7d7d7')
        draw = ImageDraw.Draw(sheet)
        for j, path in enumerate(subset):
            with Image.open(path) as page:
                page.thumbnail((1020, 950))
                x, y = (j % 2) * 1050 + (1050 - page.width) // 2, (j // 2) * 1000 + 36
                sheet.paste(page, (x, y))
                draw.text(((j % 2) * 1050 + 20, (j // 2) * 1000 + 10), f'Page {start + j + 1}', fill='black')
        sheet.save(sheets / f'pages-{start + 1:03d}-{start + len(subset):03d}.jpg', quality=90)
    receipt = {
        'status': 'LINKS_PASS_RENDERED_VISUAL_REVIEW_PENDING',
        'utc': datetime.now(timezone.utc).isoformat(), 'pdf': str(pdf), 'pdf_sha256': sha(pdf),
        'pages': len(reader.pages), 'render_dpi': args.dpi, 'render_directory': str(pages),
        'links': {'internal_links_checked': internal, 'external_links': external,
                  'named_destinations': len(destinations), 'broken_named_targets': broken},
        'fonts': subprocess.check_output(['pdffonts', str(pdf)], text=True),
        'rendered_page_hashes': [{'page': i, 'sha256': sha(p)} for i, p in enumerate(images, 1)],
    }
    (out / 'pdf-technical-review.json').write_text(json.dumps(receipt, indent=2) + '\n')
    print(json.dumps({k: receipt[k] for k in ['status', 'pages', 'pdf_sha256', 'links']}))


if __name__ == '__main__':
    main()
