#! perl
# Copyright (C) 2010, Parrot Foundation.
# $Id: book-to-latex.pl 45506 2010-04-10 09:55:03Z mikehh $

use strict;
use warnings;

use Pod::PseudoPod::LaTeX;

print <<'HEADER';
\documentclass[11pt,a4paper,oneside]{report}
\usepackage{graphics,graphicx}
\usepackage{colortbl}

\begin{document}
\tableofcontents
HEADER

for (@ARGV) {
    my $parser = Pod::PseudoPod::LaTeX->new();
    $parser->output_fh( *STDOUT );
    $parser->parse_file( $_ );
}

print <<'FOOTER';
\end{document}
FOOTER

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
