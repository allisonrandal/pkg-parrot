#
# String.pm
#
# Copyright (C) 2002-2005, The Perl Foundation.
# This program is free software. It is subject to the same license
# as the Parrot interpreter.
#
# $Id: /parrotcode/local/languages/jako/lib/Jako/Construct/Type/String.pm 880 2006-12-25T21:27:41.153122Z chromatic  $
#

use strict;
use warnings;

package Jako::Construct::Type::String;

use base qw(Jako::Construct::Type);

sub new {
    my $class = shift;
    my ($token) = @_;

    return bless {
        TOKEN    => $token,
        CODE     => 'S',
        NAME     => 'str',
        IMCC     => 'string',
        IMCC_PMC => 'String'
    }, $class;
}

1;

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
