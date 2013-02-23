#! perl -w
# Copyright: 2001-2003 The Perl Foundation.  All Rights Reserved.
# $Id: gc.t 11489 2006-02-09 18:58:48Z particle $

=head1 NAME

t/stress/gc.t - Garbage Collection

=head1 SYNOPSIS

	% perl -Ilib t/stress/gc.t

=head1 DESCRIPTION

Tests garbage collection.

=cut

use Parrot::Test tests => 1;
use Test::More;
use Parrot::PMC qw(%pmc_types);

pasm_output_is(<<'CODE', <<'OUTPUT', "arraystress");
	print "starting\n"
	new P0, .Integer
	print "ending\n"
	end
CODE
starting
ending
OUTPUT

1;
