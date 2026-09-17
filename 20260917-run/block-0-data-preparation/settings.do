/* Local configuration for data preparation.
   RAW_DATA       : annual Excel files and source references.
   WORK_DIR       : output/work folder outside the repository.
   REFERENCE_DATA : accepted comparison inputs for validation.

   To use the published dataset, open analysis_ready_data.dta directly.
*/
global RAW_DATA ""
global WORK_DIR ""
global REFERENCE_DATA ""
global PYTHON "python3"

* Empty = new run. Set to an existing run folder to resume.
global RESUME_RUN ""

* Optional validated cleaning run to reuse in a new run.
* Empty = rebuild from the annual source files.
global REUSE_CLEAN_RUN ""

* Optional machine-specific settings; excluded from Git.
capture confirm file "$B0_HOME/settings.local.do"
if !_rc do "$B0_HOME/settings.local.do"
