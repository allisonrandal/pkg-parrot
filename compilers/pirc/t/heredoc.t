#!perl
# Copyright (C) 2008-2009, Parrot Foundation.
# $Id: heredoc.t 36833 2009-02-17 20:09:26Z allison $

use lib "../../lib";
use Parrot::Test tests => 1;

pirc_2_pasm_is(<<'CODE', <<'OUTPUT', "a single const declaration");
.sub main
    say "ok"
.end
CODE
ok
OUTPUT

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
