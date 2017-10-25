# Format of command specifications
#
# %B: Base of filename for current command. E.g., if a postscript file
#     document.ps is being made from the dvi file document.dvi, then the
#     basename is document.
# %D: Destination file (e.g., the name of the postscript file when converting a
#     dvi file to postscript).
# %O: Options.
# %R: Root filename. This is the base name for the main tex file.
# %S: Source file (e.g., the name of the dvi file when converting a dvi file to
#     ps).
# %T: The name of the primary tex file.
# %Y: Name of directory for auxiliary output files (see the configuration
#     variable $aux_dir). A directory separation character ('/') is appended if
#     $aux_dir is non-empty and does not end in a suitable character, with
#     suitable characters being those appropriate to UNIX and MS-Windows, i.e.,
#     ':', '/' and '\'.
# %Z: Name of directory for output files (see the configuration variable
#     $out_dir). A directory separation character ('/') is appended if $out_dir
#     is non-empty and does not end in a suitable character, with suitable
#     characters being those appropriate to UNIX and MS-Windows, i.e., ':', '/'
#     and '\'.

$pdf_mode = 1;
$bibtex_use = 2;
$pdflatex = 'pdflatex --synctex=1 --shell-escape %O %S';
$clean_ext = 'synctex.gz pdfsync out bbl %R.%R.table %R.%R.gnuplot dvi';

# The command to invoke a pdf-previewer.
# $pdf_update_method = 0
if ($^O eq 'darwin') {
  $pdf_previewer = "open -a Preview %O %S";
}
elsif ($^O eq 'linux') {
  $pdf_previewer = 'start evince';
}

# vim: set syntax=perl:
