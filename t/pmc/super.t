#!perl
# Copyright: 2006 The Perl Foundation.  All Rights Reserved.
# $Id: super.t 11232 2006-01-17 22:27:20Z particle $

use strict;
use warnings;
use lib qw( . lib ../lib ../../lib );
use Test::More;
use Parrot::Test;

=head1 NAME

t/pmc/super.t - test the Super PMC


=head1 SYNOPSIS

	% prove t/pmc/super.t

=head1 DESCRIPTION

Tests the Super PMC.

=cut


pir_output_is(<<'CODE', <<'OUT', 'new');
.sub 'test' :main
	new P0, .Super
	print "ok 1\n"
.end
CODE
ok 1
OUT


# remember to change the number of tests :-)
BEGIN { plan tests => 1; }
