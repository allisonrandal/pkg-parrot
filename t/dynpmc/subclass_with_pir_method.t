#! perl
# Copyright (C) 2001-2006, The Perl Foundation.
# $Id: /parrotcode/local/t/dynpmc/subclass_with_pir_method.t 880 2006-12-25T21:27:41.153122Z chromatic  $

use strict;
use warnings;
use lib qw( . lib ../lib ../../lib );

use Test::More;
use Parrot::Test tests => 2;

=head1 NAME

t/dynpmc/subclass_with_pir_method.t - test adding pir methods to dynpmc's PMC

=head1 SYNOPSIS

    % prove t/dynpmc/subclass_with_pir_method.t

=head1 DESCRIPTION

Tests the C<PerlString> PMC. Checks pir method execution in a dynpmc and a subclass of the pmc

=cut

# this works
pir_output_is(
    <<'CODE', <<'OUTPUT', "subclass with pir method - .loadlib", todo => "PMCs don't obey HLL namespaces" );
.loadlib  'perl_group'
.sub main :main
  new $P0, 'PerlString'
  $P0.'perl_printhi'()
  getclass $P2, 'PerlString'
  subclass $P0, $P2, 'NewPerlString'
  $P0.'perl_printhi'()
  new $P1, 'NewPerlString'
  $P1.'perl_printhi'()
.end

.HLL 'Perl', 'perl_group'
.namespace ['PerlString']
.sub 'perl_printhi' :method
    print "HI from PerlString\n"
.end

CODE
HI from PerlString
HI from PerlString
HI from PerlString
OUTPUT

pir_output_is(
    <<'CODE', <<'OUTPUT', "subclass with pir method - .HLL", todo => "PMCs don't obey HLL namespaces" );
.HLL 'Perl', 'perl_group'
.sub main :main
  new $P0, 'PerlString'
  $P0.'perl_printhi'()
  getclass $P2, 'PerlString'
  subclass $P0, $P2, 'NewPerlString'
  $P0.'perl_printhi'()
  new $P1, 'NewPerlString'
  $P1.'perl_printhi'()
.end

.namespace ['PerlString']
.sub 'perl_printhi' :method
    print "HI from PerlString\n"
.end

CODE
HI from PerlString
HI from PerlString
HI from PerlString
OUTPUT

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4: