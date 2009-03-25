#!perl
# Copyright (C) 2005, Parrot Foundation.
# $Id: pcc.t 37201 2009-03-08 12:07:48Z fperrad $

use strict;
use warnings;
use lib qw( . lib ../lib ../../lib );
use Parrot::Test tests => 1;

pir_2_pasm_like( <<'CODE', <<'OUT', 'end in :main' );
.sub _main :main
     noop
.end
CODE
/_main:
  noop
  end
/
OUT

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:

