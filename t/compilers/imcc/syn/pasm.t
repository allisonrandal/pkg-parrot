#!perl
# Copyright (C) 2001-2007, Parrot Foundation.
# $Id: pasm.t 36833 2009-02-17 20:09:26Z allison $

# Test some basic pasm errors, not pir

use strict;
use warnings;
use lib qw( . lib ../lib ../../lib );
use Test::More;
use Parrot::Config;
use Parrot::Test tests => 1;

# I am not sure if it is really important to support this, but at
# least, we should not segfault when it happens :->
pasm_error_output_like( "print \"Hi\\n\"", <<'OUT', "No new line at end of file" );
/^error:imcc:syntax error, unexpected EOM, expecting '\\n'/
OUT

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
