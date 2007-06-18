#!perl
# Copyright (C) 2006-2007, The Perl Foundation.
# $Id: /parrotcode/trunk/t/pmc/lexpad.t 3479 2007-05-14T01:12:54.049559Z chromatic  $

use strict;
use warnings;
use lib qw( . lib ../lib ../../lib );
use Test::More;
use Parrot::Test tests => 1;

=head1 NAME

t/pmc/lexpad.t - test LexPad PMC


=head1 SYNOPSIS

    % prove t/pmc/lexpad.t

=head1 DESCRIPTION

Tests the LexPad PMC.

=cut

pir_error_output_like( <<'CODE', <<'OUT', 'new' );
.sub 'test' :main
    new P0, .LexPad
    print "ok 1\n"
.end
CODE
/don't create me like this
current instr\.:.*/
OUT

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
