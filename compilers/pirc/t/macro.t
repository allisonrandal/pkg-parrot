#!perl
# Copyright (C) 2008-2009, Parrot Foundation.
# $Id: macro.t 44433 2010-02-24 01:39:38Z mikehh $

use strict;
use warnings;

use lib qw(lib);
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
