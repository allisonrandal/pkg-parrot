#!perl
# Copyright: 2001-2005 The Perl Foundation.  All Rights Reserved.
# $Id: errors.t 10933 2006-01-06 01:43:24Z particle $

use strict;
use warnings;
use lib qw( . lib ../lib ../../lib );
use Test::More;
use Parrot::Config;
use Parrot::Test tests => 1;

## tests for imcc error messages

pir_output_like(<<'CODE', <<'OUT', "op not found");
.sub 'test' :main
    branch $P0
.end
CODE
/.*The opcode 'branch_p' \(branch\<1\>\) was not found\. Check the type and number of the arguments.*/
OUT
