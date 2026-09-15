# Repository tooling

`manage.py` is the safe entrypoint: list/show requests, print review prompts, find sources and validate the repository. It uses Python's standard library. No command starts analysis or another agent.

Build order in the original owner workspace:

1. `build_source_snapshot.py`: uses the ignored local metadata inventory to screen/copy sources and build provenance. Requires openpyxl. Original sources never change; excluded staged copies are preserved in local withheld-staging, outside publication.
2. `index_documents.py`: creates searchable companions for included PDF/DOCX/PPTX. Uses pdftotext for PDFs and XML extraction for Office files; no new PDF rendering.
3. `build_requests.py`: joins exact Word rows, prior detailed plans and current state into 44 packets.
4. `build_catalogue.py`: indices and input contracts.
5. `build_readme.py`: comprehensive entrypoint from the current request registry.
6. `manage.py validate`: exact Word comparison, source hashes, file/privacy boundaries and new navigation.

These are documentation/packaging tools. Archived Stata code and result builders have their own execution/input requirements. A fresh clone already contains the complete publication snapshot and does not need the local inventory to read/review it. Rebuilding the source snapshot requires original source roots and a fresh manager-approved inventory; never blindly replace newer accepted clone edits.

Word source/PIC and current-vs-historical status are validated separately. Document extraction logs explicitly distinguish no text layer or invalid source files; it is not a claim of substantive full-paper review. Original workbook bytes are retained; screening opens their sheets without recalculating or changing formulas.
