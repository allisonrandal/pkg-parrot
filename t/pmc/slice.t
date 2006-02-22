#!perl
# Copyright: 2006 The Perl Foundation.  All Rights Reserved.
# $Id: slice.t 11323 2006-01-23 17:00:58Z leo $

use strict;
use warnings;
use lib qw( . lib ../lib ../../lib );
use Test::More;
use Parrot::Test;

=head1 NAME

t/pmc/slice.t - test Slice PMC


=head1 SYNOPSIS

	% prove t/pmc/slice.t

=head1 DESCRIPTION

Tests the Slice PMC.

=cut


pir_output_is(<<'CODE', <<'OUT', 'new');
.sub 'test' :main
	new P0, .Slice
	print "ok 1\n"
.end
CODE
ok 1
OUT

pir_output_is(<<'CODE', <<'OUT', 'bug with slice bits', todo => 'parser');
# the VT_CONSTP status gets destroyed, if this constant is
# used somewhere else as slice index
.const int vx = 3

.sub main :main
    .local pmc b, bj
    b = new FixedPMCArray
    b = 4
    bj = new .FixedFloatArray
    bj = 5
    b[3] = bj
    $N0 = b[3 .. vx]
    bj = b[3]
    $N1 = bj[vx]
    $N1 += 1.0
    bj[vx] = $N1
    print $N1
    print "\n"
.end
CODE
1.000000
OUT

# remember to change the number of tests :-)
BEGIN { plan tests => 2; }