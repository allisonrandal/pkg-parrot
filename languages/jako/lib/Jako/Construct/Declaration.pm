#
# Declaration.pm
#
# Copyright (C) 2002-2005, The Perl Foundation.
# This program is free software. It is subject to the same license
# as the Parrot interpreter.
#
# $Id: Declaration.pm 16255 2006-12-25 22:20:28Z paultcochrane $
#

use strict;
use warnings;

package Jako::Construct::Declaration;

use base qw(Jako::Construct);

sub access { return shift->{ACCESS}; }

1;


# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
