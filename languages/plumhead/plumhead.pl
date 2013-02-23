#!/usr/bin/env perl

# $Id: /parrotcode/trunk/languages/plumhead/plumhead.pl 3304 2007-04-25T17:50:24.116328Z bernhard  $

# A workaround for run-tests.php

use strict;
use warnings;

# possible values are qw( phc antlr3 partridge yacc perl5re );
my $variant = $ENV{PLUMHEAD_VARIANT} || 'partridge';
exec './parrot', 'languages/plumhead/plumhead.pbc', "--variant=$variant", @ARGV;

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
