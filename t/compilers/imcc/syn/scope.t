#!perl
# Copyright (C) 2001-2005, The Perl Foundation.
# $Id: /parrotcode/local/t/compilers/imcc/syn/scope.t 880 2006-12-25T21:27:41.153122Z chromatic  $

use strict;
use warnings;
use lib qw( . lib ../lib ../../lib );
use Test::More;
use Parrot::Config;
use Parrot::Test tests => 1;

##############################
pir_output_is( <<'CODE', <<'OUT', "global const" );
.sub test :main
	.globalconst string ok = "ok\n"
	print ok
	_sub()
	end
.end
.sub _sub
	print ok
.end
CODE
ok
ok
OUT

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
