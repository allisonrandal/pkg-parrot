#!perl
# Copyright: 2005 The Perl Foundation.  All Rights Reserved.
# $Id: pcc.t 10238 2005-11-29 03:16:07Z particle $

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

