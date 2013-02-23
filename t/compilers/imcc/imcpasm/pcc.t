#!perl
# Copyright (C) 2005, The Perl Foundation.
# $Id: /local/t/compilers/imcc/imcpasm/pcc.t 12838 2006-05-30T14:19:10.150135Z coke  $

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

