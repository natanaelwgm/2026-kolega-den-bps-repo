"""Focused regressions for PDF stripping and the export's source boundary."""
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

import export_ready_stata as exporter
from ready_stata_format import no_pdf


class ReadyExportTests(unittest.TestCase):
    def test_pdf_continuation_with_comment_does_not_leave_orphan_options(self):
        source = ('putpdf paragraph, /// human comment\n'
                  '    halign(center)\n'
                  'generate result = 2 * value\n')
        result, removed = no_pdf(source)
        self.assertEqual(removed, [1, 2])
        self.assertNotIn('halign(center)', result)
        self.assertIn('generate result = 2 * value', result)

    def test_conditional_pdf_export_and_shared_png_loop_keep_png(self):
        source = ('if "`format\'"=="pdf" graph export "figure.pdf", replace\n'
                  'foreach out in png pdf {\n'
                  '    graph export "figure.`out\'", replace\n'
                  '}\n'
                  'export delimited using "table.csv", replace\n')
        result, _ = no_pdf(source)
        self.assertIn('foreach out in png {', result)
        self.assertNotIn('graph export "figure.pdf"', result)
        self.assertIn('export delimited using "table.csv", replace', result)

    def test_pdf_helper_body_is_removed_without_removing_next_program(self):
        source = ('program define ctable_pdf\n'
                  '    syntax varlist, saving(string)\n'
                  '    putpdf begin\nend\n'
                  'program define calculate\n    display 42\nend\n')
        result, removed = no_pdf(source)
        self.assertEqual(removed, [1, 2, 3, 4])
        self.assertIn('program define calculate\n    display 42\nend', result)

    def test_source_boundary_rejects_parent_path(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory) / 'repo'
            root.mkdir()
            (root.parent / 'private.txt').write_text('not package content')
            with patch.object(exporter, 'ROOT', root):
                with self.assertRaises(ValueError):
                    exporter.source_file('../private.txt')

    def test_existing_export_is_preserved(self):
        with tempfile.TemporaryDirectory() as directory:
            output = Path(directory) / 'package.zip'
            output.write_bytes(b'previous export')
            with self.assertRaises(FileExistsError):
                exporter.export(output, None)
            self.assertEqual(output.read_bytes(), b'previous export')


if __name__ == '__main__':
    unittest.main()
