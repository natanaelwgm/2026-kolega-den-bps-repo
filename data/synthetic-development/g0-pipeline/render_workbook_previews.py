"""Bounded visual QA of actual saved workbook cells; no recalculation or authoring engine."""
from pathlib import Path
from openpyxl import load_workbook
from PIL import Image,ImageDraw,ImageFont
import json,textwrap,zipfile,xml.etree.ElementTree as ET
P=Path(__file__).resolve().parent;R=P/'results';out=R/'workbook-previews';out.mkdir(exist_ok=True)
book=load_workbook(R/'G0_analysis_ready_SYNTHETIC_CALCULATED.xlsx',read_only=True,data_only=False)
font=ImageFont.truetype('/System/Library/Fonts/Supplemental/Arial.ttf',15);bold=ImageFont.truetype('/System/Library/Fonts/Supplemental/Arial Bold.ttf',16)
checks=[]
for number,ws in enumerate(book,1):
 if ws.title=='Charts':
  with zipfile.ZipFile(R/'G0_analysis_ready_SYNTHETIC_CALCULATED.xlsx') as z:assert len([n for n in z.namelist() if n.startswith('xl/media/')])==4
  checks.append(dict(sheet=ws.title,four_embedded_charts=True,inspection='Stata source PNGs separately inspected'));continue
 rows=list(ws.iter_rows(max_row=8,values_only=True));cols=list(range(min(7,len(rows[0]))));widths=[440 if str(rows[0][c]) in ['value','varlab','reason','actual_result','remaining_source_or_limit','source_gap','impact'] else 210 for c in cols]
 w=sum(widths)+40;h=85+len(rows)*105;im=Image.new('RGB',(w,h),'white');d=ImageDraw.Draw(im);d.text((20,15),ws.title+' — SYNTHETIC calculated output',font=bold,fill='#20365E');y=65
 for rn,row in enumerate(rows):
  x=20
  for col,width in zip(cols,widths):
   v=row[col] if col<len(row) else None;s='' if v is None else str(v);lines=textwrap.wrap(s,width=max(15,int(width/8))) or ['']
   d.rectangle((x,y,x+width,y+105),fill='#20365E' if rn==0 else '#EEF3F8' if rn%2==0 else 'white',outline='#CAD5E1')
   for i,line in enumerate(lines[:5]):d.text((x+6,y+5+i*18),line,font=font,fill='white' if rn==0 else '#20365E')
   x+=width
  y+=105
 name=f'{number:02}-{ws.title.replace(" ","_")}.png';im.save(out/name);checks.append(dict(sheet=ws.title,preview=name,rows=len(rows),displayed_columns=[rows[0][c] for c in cols]))
book.close();(R/'workbook-visual-qa.json').write_text(json.dumps(checks,indent=2));print('Workbook previews',len(checks),'sheets')
