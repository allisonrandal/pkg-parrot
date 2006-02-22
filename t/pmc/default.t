#!perl
# Copyright: 2006 The Perl Foundation.  All Rights Reserved.
# $Id: default.t 11232 2006-01-17 22:27:20Z particle $

use strict;
use warnings;
use lib qw( . lib ../lib ../../lib );
use Test::More;
use Parrot::Test;

=head1 NAME

t/pmc/default.t - test default PMC


=head1 SYNOPSIS

	% prove t/pmc/default.t

=head1 DESCRIPTION

Tests the default PMC.

=cut


pir_output_is(<<'CODE', <<'OUT', 'new', todo => 'not implemeted');
.sub 'test' :main
	new P0, .default
	print "ok 1\n"
.end
CODE
ok 1
OUT


# remember to change the number of tests :-)
BEGIN { plan tests => 1; }