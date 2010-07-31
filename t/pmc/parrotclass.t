#!./parrot
# Copyright (C) 2006-2008, Parrot Foundation.
# $Id: parrotclass.t 46007 2010-04-25 11:44:15Z fperrad $

=head1 NAME

t/pmc/parrotclass.t - test the Class PMC

=head1 SYNOPSIS

    % prove t/pmc/parrotclass.t

=head1 DESCRIPTION

Tests the Class PMC.

=cut

.sub main :main
    .include 'test_more.pir'

    plan(1)

    new $P0, ['Class']
    ok(1, 'Instantiated a Class PMC')
.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:
