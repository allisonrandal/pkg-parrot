#!perl
# Copyright (C) 2005, The Perl Foundation.
# $Id: /parrotcode/local/t/compilers/imcc/imcpasm/pcc.t 733 2006-12-17T23:24:17.491923Z chromatic  $

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

