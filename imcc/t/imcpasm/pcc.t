#!perl
# Copyright: 2005 The Perl Foundation.  All Rights Reserved.
# $Id: pcc.t 9686 2005-11-01 16:25:50Z leo $

use strict;
use Parrot::Test tests => 1;


pir_2_pasm_like(<<'CODE', <<'OUT', 'end in :main');
.sub _main :main
     noop
.end
CODE
/_main:
  noop
  end
/
OUT

