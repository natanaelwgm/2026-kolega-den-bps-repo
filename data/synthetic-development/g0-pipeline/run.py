"""Run one primary Stata pipeline and retain its transcript; Python only prepares/formats/checks."""
from pathlib import Path
import subprocess,sys,datetime,shutil
P=Path(__file__).resolve().parent;ROOT=P.parents[2]
def python(name):subprocess.run([sys.executable,str(P/name)],cwd=ROOT,check=True)
python('inspect_wpi_reference.py')
python('prepare.py');python('audit_execution_scope.py')
run=P/'dag/logs/attempts'/datetime.datetime.now().strftime('run-%Y%m%d-%H%M%S');run.mkdir(parents=True)
r=subprocess.run(['stata-se','-b','do',str(P/'G0_build_synthetic_dataset.do'),str(ROOT)],cwd=run)
log=run/'G0_build_synthetic_dataset.log'
if not log.exists() or r.returncode or '\nG0_SYNTHETIC_FULL_PIPELINE_SUCCESS\n' not in log.read_text():raise SystemExit('Stata did not complete. Inspect '+str(run))
shutil.copy2(log,P/'dag/logs/G0_build_synthetic_dataset_complete.log')
python('describe_wpi_preparation.py');python('publish.py');python('document_processes.py');python('render_workbook_previews.py')
print('SYNTHETIC_G0_RUN_AND_PUBLICATION_PASS')
