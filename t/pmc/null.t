#!perl
# Copyright (C) 2006, The Perl Foundation.
# $Id: /local/t/pmc/null.t 12838 2006-05-30T14:19:10.150135Z coke  $

use strict;
use warnings;
use lib qw( . lib ../lib ../../lib );
use Test::More;
use Parrot::Test;

=head1 NAME

t/pmc/null.t - test Null PMC


=head1 SYNOPSIS

	% prove t/pmc/null.t

=head1 DESCRIPTION

Tests the Null PMC.

=cut


pir_output_is(<<'CODE', <<'OUT', 'new');
.sub 'test' :main
	new P0, .Null
	print "ok 1\n"
.end
CODE
ok 1
OUT


# remember to change the number of tests :-)
BEGIN { plan tests => 1; }
