#
# Number.pm
#
# Copyright (C) 2002-2005, The Perl Foundation.
# This program is free software. It is subject to the same license
# as the Parrot interpreter.
#
# $Id: Number.pm 16255 2006-12-25 22:20:28Z paultcochrane $
#

use strict;
use warnings;

package Jako::Construct::Type::Number;

use base qw(Jako::Construct::Type);

sub new {
    my $class = shift;
    my ($token) = @_;

    return bless {
        TOKEN    => $token,
        CODE     => 'N',
        NAME     => 'num',
        IMCC     => 'num',
        IMCC_PMC => 'Float'
    }, $class;
}

1;


# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
