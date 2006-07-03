#!perl
# Copyright (C) 2005, The Perl Foundation.
# $Id: pcc.t 12838 2006-05-30 14:19:10Z coke $

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

