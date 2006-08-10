#!perl
# Copyright (C) 2006, The Perl Foundation.
# $Id: /local/t/pmc/parrotobject.t 12838 2006-05-30T14:19:10.150135Z coke  $

use strict;
use warnings;
use lib qw( . lib ../lib ../../lib );
use Test::More;
use Parrot::Test;

=head1 NAME

t/pmc/parrotobject.t - test the ParrotObject PMC


=head1 SYNOPSIS

	% prove t/pmc/parrotobject.t

=head1 DESCRIPTION

Tests the ParrotObject PMC.

=cut


pir_output_like(<<'CODE', <<'OUT', 'new');
.sub 'test' :main
	new P0, .ParrotObject
	print "ok 1\n"
.end
CODE
/Can't create new ParrotObjects - use the registered class instead
current instr\.:/
OUT
# '


# remember to change the number of tests :-)
BEGIN { plan tests => 1; }
