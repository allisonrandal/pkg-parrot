#
# Infix.pm
#
# Copyright (C) 2002-2005, The Perl Foundation.
# This program is free software. It is subject to the same license
# as the Parrot interpreter.
#
# $Id: /parrotcode/local/languages/jako/lib/Jako/Construct/Expression/Infix.pm 880 2006-12-25T21:27:41.153122Z chromatic  $
#

use strict;
use warnings;

package Jako::Construct::Expression::Infix;

use base qw(Jako::Construct::Expression);

sub new {
    my $class = shift;
    my ( $left, $op, $right );

    return bless {
        LEFT  => $left,
        OP    => $op,
        RIGHT => $right,
    }, $class;
}

1;

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
